import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_engineer.dart';

class EditMechanicScreen extends StatefulWidget {
  final Mechanic mechanic;

  EditMechanicScreen({required this.mechanic});

  @override
  _EditMechanicScreenState createState() => _EditMechanicScreenState();
}

class _EditMechanicScreenState extends State<EditMechanicScreen> {
  late TextEditingController nameController;
  // Add other controllers for each field...

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.mechanic.name);
    // Initialize other controllers...
  }

  @override
  void dispose() {
    nameController.dispose();
    // Dispose other controllers...
    super.dispose();
  }

  void saveChanges() {
    // Create a new Mechanic object with updated details
    Mechanic updatedMechanic = Mechanic(
      name: nameController.text,
      profilePic: widget.mechanic.profilePic,
      location: widget.mechanic.location,
      distance: widget.mechanic.distance,
      rating: widget.mechanic.rating,
      status: widget.mechanic.status,
      specializations: widget.mechanic.specializations,
      experience: widget.mechanic.experience,
      contact: widget.mechanic.contact,
      availability: widget.mechanic.availability,
      documents: widget.mechanic.documents,
    );

    // Update Firestore
    addMechanic(updatedMechanic).then((_) {
      Navigator.pop(context, updatedMechanic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Mechanic Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            // Add more TextFields for other details...
            ElevatedButton(
              onPressed: saveChanges,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
