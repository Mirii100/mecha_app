import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_engineer.dart';

class MechanicProfileScreen extends StatelessWidget {
  final Mechanic mechanic;

  MechanicProfileScreen({required this.mechanic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mechanic.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(mechanic.profilePic),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                mechanic.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Location: ${mechanic.location} (${mechanic.distance} km away)",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Specializations: ${mechanic.specializations}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Experience: ${mechanic.experience}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Contact: ${mechanic.contact}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Availability: ${mechanic.availability}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Documents",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            for (var doc in mechanic.documents)
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
    );
  }
}
