import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

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

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'createdAt': Timestamp.now(),
      });

      if (idImage != null) {
        await uploadID(userCredential.user!.uid);
      }

      setState(() {
        message = 'Account created successfully! Please log in.';
      });

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
      setState(() {
        idImage = file;
        message = 'Image selected: ${pickedImage.path.split('/').last}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/me.jpg',width: 80,height: 80,alignment: Alignment.center,),
                SizedBox(height: 32.0),

                // Name TextField
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Alex',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // Email TextField
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // Phone Number TextField
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                // Password TextField
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),

                // Upload ID Button
                ElevatedButton(
                  onPressed: pickImage,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                  child: Text('Upload ID/Passport (Optional)'),
                ),
                SizedBox(height: 16.0),

                // Display the selected image
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: idImage == null
                      ? Center(child: Text('No image selected'))
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(idImage!, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 16.0),

                // Sign Up Button
                ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  ),
                  child: Text('Sign Up'),
                ),
                SizedBox(height: 16.0),

                // Divider
                Text('- OR -', style: TextStyle(color: Colors.grey)),
                SizedBox(height: 16.0),

                // Google Sign-In Button with Google Logo
                ElevatedButton.icon(
                  onPressed: () {
                    // Google Sign-In logic here
                  },
                  icon: Image.asset('images/google_Logo.png', height: 24),
                  label: Text('Sign in with Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.grey),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                ),
                SizedBox(height: 32.0),

                // Footer Text
                Text(
                  'developed by Alex ',
                  style: TextStyle(color: Colors.grey),
                ),

                SizedBox(height: 16.0),

                // Display message if any
                Text(
                  message,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
