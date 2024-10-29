import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../infor/my_engineer.dart';
 // Import the Mechanic class

class RegisterMechanicScreen extends StatefulWidget {
  @override
  _RegisterMechanicScreenState createState() => _RegisterMechanicScreenState();
}

class _RegisterMechanicScreenState extends State<RegisterMechanicScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController profilePicController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController specializationsController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();
  final List<String> documents = []; // Initialize an empty list for documents

  @override
  void dispose() {
    // Dispose of controllers when the widget is removed from the widget tree
    nameController.dispose();
    profilePicController.dispose();
    locationController.dispose();
    distanceController.dispose();
    ratingController.dispose();
    statusController.dispose();
    specializationsController.dispose();
    experienceController.dispose();
    contactController.dispose();
    availabilityController.dispose();
    super.dispose();
  }

  Future<void> registerMechanic() async {
    Mechanic mechanic = Mechanic(
      name: nameController.text,
      profilePic: profilePicController.text,
      location: locationController.text,
      distance: double.parse(distanceController.text),
      rating: double.tryParse(ratingController.text) ?? 0,
      status: statusController.text,
      specializations: specializationsController.text,
      experience: experienceController.text,
      contact: contactController.text,
      availability: availabilityController.text,
      documents: documents, // Add any documents here
    );

    // Save mechanic to Firestore
    try {
      await FirebaseFirestore.instance.collection('mechanics').add(mechanic.toMap());
      // Optionally, you can show a success message or navigate to another screen
    } catch (e) {
      print("Error saving mechanic: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register Mechanic')),
      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(

                controller: profilePicController,
                decoration: InputDecoration(labelText: 'Profile Picture URL'),
              ),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: distanceController,
                decoration: InputDecoration(labelText: 'Distance (km)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: ratingController,
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: statusController,
                decoration: InputDecoration(labelText: 'Status'),
              ),
              TextField(
                controller: specializationsController,
                decoration: InputDecoration(labelText: 'Specializations'),
              ),
              TextField(
                controller: experienceController,
                decoration: InputDecoration(labelText: 'Experience'),
              ),
              TextField(
                controller: contactController,
                decoration: InputDecoration(labelText: 'Contact'),
              ),
              TextField(
                controller: availabilityController,
                decoration: InputDecoration(labelText: 'Availability'),
              ),
              // Add a button to register the mechanic
              ElevatedButton(
                onPressed: registerMechanic,
                child: Text('Register Mechanic'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
