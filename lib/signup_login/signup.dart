import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance

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

      if (userCredential.user != null && idImage != null) {
        // Save user data to Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'phone': phoneController.text.trim(),
          'createdAt': Timestamp.now(),
        });

        await uploadID(userCredential.user!.uid);

        // Display success message and navigate to login screen
        setState(() {
          message = 'Account created successfully! Please log in.';
        });

        // Navigate to the login screen after a short delay
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushReplacementNamed(context, '/LoginScreen');
      } else {
        setState(() {
          message = 'User creation or ID image upload failed';
        });
      }
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
      setState(() {
        idImage = File(pickedImage.path);
        message = 'Image selected: ${pickedImage.name}'; // Show selected image name
      });
    }
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
                child: Text('Upload ID/Passport'),
              ),
              SizedBox(height: 16.0),

              // Display the selected image
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
