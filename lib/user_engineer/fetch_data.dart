import 'package:cloud_firestore/cloud_firestore.dart';
import '../infor/my_engineer.dart'; // Ensure this imports the Mechanic class

class MechanicsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream to get real-time updates from Firestore
  Stream<List<Mechanic>> getMechanicsStream() {
    return _firestore.collection('mechanics').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Mechanic.fromMap(data); // Convert Firestore data to Mechanic object
      }).toList();
    });
  }
}
