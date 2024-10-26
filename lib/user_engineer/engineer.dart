import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EngineerProfileUploadScreen extends StatefulWidget {
  @override
  _EngineerProfileUploadScreenState createState() => _EngineerProfileUploadScreenState();
}

class _EngineerProfileUploadScreenState extends State<EngineerProfileUploadScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController certificationsController = TextEditingController();
  final TextEditingController portfolioController = TextEditingController();
  bool isSubmitting = false;

  Future<void> uploadEngineerDetails() async {
    setState(() {
      isSubmitting = true;
    });

    try {
      await FirebaseFirestore.instance.collection('engineers').add({
        'name': nameController.text,
        'skills': skillsController.text,
        'experience': experienceController.text,
        'contact': contactController.text,
        'location': locationController.text,
        'certifications': certificationsController.text,
        'portfolio': portfolioController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Engineer details uploaded successfully")),
      );
      clearForm();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload engineer details")),
      );
    }

    setState(() {
      isSubmitting = false;
    });
  }

  void clearForm() {
    nameController.clear();
    skillsController.clear();
    experienceController.clear();
    contactController.clear();
    locationController.clear();
    certificationsController.clear();
    portfolioController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Engineer Profile Upload'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: skillsController,
                decoration: InputDecoration(
                  labelText: 'Skills',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: experienceController,
                decoration: InputDecoration(
                  labelText: 'Experience',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: contactController,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: certificationsController,
                decoration: InputDecoration(
                  labelText: 'Certifications',
                  hintText: 'E.g., Certified Mechanical Engineer',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: portfolioController,
                decoration: InputDecoration(
                  labelText: 'Portfolio Link',
                  hintText: 'E.g., https://yourportfolio.com',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: isSubmitting ? null : uploadEngineerDetails,
                child: isSubmitting
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
