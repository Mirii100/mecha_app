import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VehicleTrackingScreen extends StatefulWidget {
  @override
  _VehicleTrackingScreenState createState() => _VehicleTrackingScreenState();
}

class _VehicleTrackingScreenState extends State<VehicleTrackingScreen> {
  LatLng? _vehicleLocation; // State variable to hold the vehicle's location

  @override
  void initState() {
    super.initState();
    _updateVehicleMarker('YOUR_VEHICLE_ID'); // Replace with actual vehicle ID
  }

  Future<void> updateVehicleLocation(String vehicleId, double latitude, double longitude) async {
    await FirebaseFirestore.instance.collection('vehicles').doc(vehicleId).set({
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<DocumentSnapshot> getVehicleLocation(String vehicleId) {
    return FirebaseFirestore.instance.collection('vehicles').doc(vehicleId).snapshots();
  }

  void _updateVehicleMarker(String vehicleId) {
    getVehicleLocation(vehicleId).listen((snapshot) {
      if (snapshot.exists) {
        double latitude = snapshot['latitude'];
        double longitude = snapshot['longitude'];
        setState(() {
          _vehicleLocation = LatLng(latitude, longitude); // Update vehicle location
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vehicle Tracking')),
      body: Center(
        child: _vehicleLocation != null
            ? GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _vehicleLocation!,
            zoom: 14,
          ),
          markers: {
            Marker(
              markerId: MarkerId('vehicle'),
              position: _vehicleLocation!,
            ),
          },
        )
            : CircularProgressIndicator(), // Show loading indicator if location is not available
      ),
    );
  }
}
