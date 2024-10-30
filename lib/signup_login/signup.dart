import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // Import foundation to check for kIsWeb
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  File? idImage;
  String message = '';

  Future<void> signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'createdAt': Timestamp.now(),
      });

      // Only upload ID if an image has been selected
      if (idImage != null) {
        await uploadID(userCredential.user!.uid);
      }

      // Display success message and navigate to login screen
      setState(() {
        message = 'Account created successfully! Please log in.';
      });

      // Navigate to the login screen after a short delay
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, '/LoginScreen');
    } catch (e) {
      setState(() {
        message = 'Signup error: $e';
      });
    }
  }

  Future<void> uploadID(String uid) async {
    try {
      final ref = FirebaseStorage.instance.ref().child('users/$uid/id');
      await ref.putFile(idImage!);
      setState(() {
        message = 'ID uploaded successfully';
      });
    } catch (e) {
      setState(() {
        message = 'Upload error: $e';
      });
    }
  }

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final file = File(pickedImage.path);
      // Check if the selected file is a valid image
      final imageBytes = await file.readAsBytes();
      final imageType = identifyImageType(imageBytes); // Check if it's a valid image

      if (imageType != null) {
        setState(() {
          idImage = file;
          message = 'Image selected: ${pickedImage.name}';
        });
      } else {
        setState(() {
          message = 'Selected file is not a valid image.';
        });
      }
    }
  }

  String? identifyImageType(Uint8List imageBytes) {
    // Check the file header bytes for common image formats
    if (imageBytes.length >= 4) {
      if (imageBytes[0] == 0xFF && imageBytes[1] == 0xD8) return 'jpg'; // JPEG
      if (imageBytes[0] == 0x89 && imageBytes[1] == 0x50) return 'png'; // PNG
      // Add more formats if needed
    }
    return null; // Not a valid image format
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(color: Colors.white),
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIconColor: Colors.blue,
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  prefixIconColor: Colors.blue,
                  prefixIcon: Icon(Icons.phone_iphone),
                  hintText: "987654",
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password_sharp),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: pickImage,
                child: Text('Upload ID/Passport (Optional)'),
              ),
              SizedBox(height: 16.0),

              // Display the selected image based on the platform
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: idImage == null
                    ? Center(child: Text('No image selected'))
                    : Image.file(idImage!, fit: BoxFit.cover),
              ),
              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: signUp,
                child: Text('Sign Up'),
              ),

              // Display the message
              SizedBox(height: 16.0),
              Text(
                message,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
