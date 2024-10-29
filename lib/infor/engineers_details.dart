import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'editMechanicProfile.dart';
import 'my_engineer.dart';

class MechanicProfileScreen extends StatefulWidget {
  final Mechanic mechanic;

  MechanicProfileScreen({required this.mechanic});

  @override
  State<MechanicProfileScreen> createState() => _MechanicProfileScreenState();
}

class _MechanicProfileScreenState extends State<MechanicProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mechanic.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(widget.mechanic.profilePic),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                widget.mechanic.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Location: ${widget.mechanic.location} (${widget.mechanic.distance} km away)",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Specializations: ${widget.mechanic.specializations}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Experience: ${widget.mechanic.experience}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Contact: ${widget.mechanic.contact}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Availability: ${widget.mechanic.availability}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Documents",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            for (var doc in widget.mechanic.documents)
              ListTile(
                title: Text(doc),
                trailing: Icon(Icons.download),
                onTap: () {
                  // Implement download/view functionality
                },
              ),
            SizedBox(height: 16),
            // Add a map integration here if needed.
          ],
        ),
      ),
      // Inside MechanicProfileScreen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditMechanicScreen(mechanic: widget.mechanic),
            ),
          ).then((updatedMechanic) {
            if (updatedMechanic != null) {
              // Update the profile with the new details
              // You may need to fetch the latest data from Firestore or update the UI directly
            }
          });
        },
        child: Icon(Icons.edit),
      ),

    );
  }
}
