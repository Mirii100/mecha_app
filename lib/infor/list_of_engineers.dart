import 'package:flutter/material.dart';

import 'engineers_details.dart';
import 'my_engineer.dart';

class MechanicsListScreen extends StatelessWidget {
  final List<Mechanic> mechanics = [
    // Sample data
    Mechanic(
      name: "Alexander njuguna",
      profilePic: "images/me.jpg", // placeholder for profile image path
      location: "muranga",
      distance: 3.0,
      rating: 4.5,
      status: "Available",
      specializations: "Engine Repair, Tire Replacement",
      experience: "5 years",
      contact: "123-456-7890",
      availability: "Mon - Fri, 9 AM - 6 PM",
      documents: ["ID", "Certification"],
    ),
    Mechanic(
      name: "njuguna mirii",
      profilePic: "images/me.jpg", // placeholder for profile image path
      location: "muranga",
      distance: 3.0,
      rating: 6,
      status: "Available",
      specializations: "Engine Repair, Tire Replacement",
      experience: "5 years",
      contact: "123-456-7890",
      availability: "Mon - Fri, 9 AM - 6 PM",
      documents: ["ID", "Certification"],
    ),
    // Add more mechanics here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Mechanics"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search Mechanics",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: mechanics.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final mechanic = mechanics[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(mechanic.profilePic),
                  ),
                  title: Text(
                    mechanic.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${mechanic.distance} km away - ${mechanic.status}"),
                  trailing: mechanic.rating != null
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(mechanic.rating.toString()),
                    ],
                  )
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MechanicProfileScreen(mechanic: mechanic),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
