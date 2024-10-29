import 'package:cloud_firestore/cloud_firestore.dart';

class Mechanic {
  final String name;
  final String profilePic;
  final String location;
  final double distance;
  final double? rating; // Make rating nullable
  final String status;
  final String specializations;
  final String experience;
  final String contact;
  final String availability;
  final List<String> documents;

  Mechanic({
    required this.name,
    required this.profilePic,
    required this.location,
    required this.distance,
    this.rating, // Nullable in the constructor
    required this.status,
    required this.specializations,
    required this.experience,
    required this.contact,
    required this.availability,
    required this.documents,
  });

  // Factory method to create a Mechanic object from a Firestore document
  factory Mechanic.fromMap(Map<String, dynamic> data) {
    return Mechanic(
      name: data['name'] ?? '',
      profilePic: data['profilePic'] ?? '',
      location: data['location'] ?? '',
      distance: (data['distance'] ?? 0).toDouble(),
      rating: data['rating'] != null ? (data['rating'] as num).toDouble() : null, // Handle nullable rating
      status: data['status'] ?? '',
      specializations: data['specializations'] ?? '',
      experience: data['experience'] ?? '',
      contact: data['contact'] ?? '',
      availability: data['availability'] ?? '',
      documents: List<String>.from(data['documents'] ?? []),
    );
  }

  // Method to convert Mechanic object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'location': location,
      'distance': distance,
      'rating': rating, // Include nullable rating
      'status': status,
      'specializations': specializations,
      'experience': experience,
      'contact': contact,
      'availability': availability,
      'documents': documents,
    };
  }
}

// Method to add mechanic data to Firestore
Future<void> addMechanic(Mechanic mechanic) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    await _firestore.collection('engineerDetails').add(mechanic.toMap());
    print('Mechanic added successfully!');
  } catch (e) {
    print('Error adding mechanic: $e');
  }
}
