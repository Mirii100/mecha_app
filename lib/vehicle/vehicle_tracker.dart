import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class VehicleTrackingScreen extends StatefulWidget {
  @override
  _VehicleTrackingScreenState createState() => _VehicleTrackingScreenState();
}

class _VehicleTrackingScreenState extends State<VehicleTrackingScreen> {
  GoogleMapController? _mapController;
  LatLng? _userLocation;
  LatLng? _vehicleLocation;
  Location _location = Location();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    // Fetch vehicle location from your backend or real-time tracking API.
    _vehicleLocation = LatLng(12.9716, 77.5946); // Dummy vehicle location
  }

  Future<void> _getUserLocation() async {
    var locData = await _location.getLocation();
    setState(() {
      _userLocation = LatLng(locData.latitude!, locData.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Vehicle'),
      ),
      body: _userLocation == null || _vehicleLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _userLocation!,
          zoom: 14,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
        },
        markers: {
          Marker(
            markerId: MarkerId('userLocation'),
            position: _userLocation!,
            infoWindow: InfoWindow(title: 'Your Location'),
          ),
          Marker(
            markerId: MarkerId('vehicleLocation'),
            position: _vehicleLocation!,
            infoWindow: InfoWindow(title: 'Vehicle Location'),
          ),
        },
      ),
    );
  }
}
