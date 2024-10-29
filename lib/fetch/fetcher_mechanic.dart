import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

class NearbyMechanicsScreen extends StatefulWidget {
  @override
  _NearbyMechanicsScreenState createState() => _NearbyMechanicsScreenState();
}

class _NearbyMechanicsScreenState extends State<NearbyMechanicsScreen> {
  final geo = GeoCollectionReference(FirebaseFirestore.instance.collection('mechanics'));
  List<DocumentSnapshot> nearbyMechanics = [];

  @override
  void initState() {
    super.initState();
    fetchNearbyMechanics(12.9716, 77.5946); // Example coordinates for location (Bangalore)
  }

  Future<void> fetchNearbyMechanics(double latitude, double longitude) async {
    GeoFirePoint center = GeoFirePoint(GeoPoint(latitude, longitude));

    Stream<List<DocumentSnapshot<Map<String, dynamic>>>> stream = geo.subscribeWithin(
      center: center,
      radiusInKm: 10, // Radius in kilometers
      field: 'location', // Firestore field storing the GeoPoint
      geopointFrom: (data) => (data['location'] as GeoPoint), // Extract GeoPoint from Firestore document
      strictMode: true,
    );

    // Listen to the stream and update the list of nearby mechanics
    stream.listen((List<DocumentSnapshot<Map<String, dynamic>>> documentList) {
      setState(() {
        nearbyMechanics = documentList; // Update the state with nearby mechanics
      });
    }, onError: (error) {
      print("Error fetching nearby mechanics: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nearby Mechanics')),
      body: nearbyMechanics.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading indicator if no mechanics
          : ListView.builder(
        itemCount: nearbyMechanics.length,
        itemBuilder: (context, index) {
          final mechanicData = nearbyMechanics[index].data() as Map<String, dynamic>?;

          if (mechanicData == null) {
            return ListTile(
              title: Text('Unknown mechanic'),
              subtitle: Text('Location: Unknown'),
            );
          }

          return ListTile(
            title: Text(mechanicData['name'] ?? 'No Name'),
            subtitle: Text('Location: ${mechanicData['location'].latitude}, ${mechanicData['location'].longitude}'),
          );
        },
      ),
    );
  }
}
