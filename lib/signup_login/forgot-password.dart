import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  String verificationCode = '';
  bool isCodeSent = false;

  Future<void> sendResetCode() async {
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();

    if (email.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter your email and phone number.'),
      ));
      return;
    }

    try {
      // Send a password reset email
      await _auth.sendPasswordResetEmail(email: email);
      // Here you can implement the logic to send a verification code via SMS
      // For demonstration, we assume the code is sent successfully
      setState(() {
        verificationCode = "123456"; // Simulate the verification code
        isCodeSent = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Reset code sent to your email.'),
      ));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to send reset code. Please try again.'),
      ));
    }
  }

  Future<void> verifyCodeAndResetPassword() async {
    String inputCode = codeController.text.trim();

    if (inputCode != verificationCode) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid verification code.'),
      ));
      return;
    }

    // Here you would typically allow the user to set a new password
    // For demonstration, we will show a dialog to confirm password reset
    showDialog(
      context: context,
      builder: (context) {
        String newPassword = '';

        return AlertDialog(
          title: Text('Reset Password'),
          content: TextField(
            onChanged: (value) {
              newPassword = value;
            },
            decoration: InputDecoration(labelText: 'New Password'),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  // Call the method to reset the password (assuming user is logged in)
                  await _auth.currentUser!.updatePassword(newPassword);
                  Navigator.of(context).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Password reset successful.'),
                  ));
                } catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to reset password. Please try again.'),
                  ));
                }
              },
              child: Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: sendResetCode,
              child: Text('Send Reset Code'),
            ),
            SizedBox(height: 24.0),
            if (isCodeSent) ...[
              TextField(
                controller: codeController,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: verifyCodeAndResetPassword,
                child: Text('Verify and Reset Password'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
