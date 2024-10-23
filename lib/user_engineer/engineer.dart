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

  Future<void> uploadEngineerDetails() async {
    try {
      await FirebaseFirestore.instance.collection('engineers').add({
        'name': nameController.text,
        'skills': skillsController.text,
        'experience': experienceController.text,
      });
      // Success, you can now navigate or notify
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Engineer Profile Upload'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
            ElevatedButton(
              onPressed: uploadEngineerDetails,
              child: Text('Upload Details'),
            ),
          ],
        ),
      ),
    );
  }
}
