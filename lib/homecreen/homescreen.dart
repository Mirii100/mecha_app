import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  Location _location = Location();
  List<Map<String, dynamic>> nearbyMechanics = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchNearbyMechanics();
  }

  Future<void> _getCurrentLocation() async {
    var locData = await _location.getLocation();
    setState(() {
      _currentLocation = LatLng(locData.latitude!, locData.longitude!);
    });
  }

  Future<void> _fetchNearbyMechanics() async {
    FirebaseFirestore.instance.collection('mechanics').get().then((snapshot) {
      setState(() {
        nearbyMechanics = snapshot.docs
            .map((doc) => {
          'name': doc['name'],
          'location': LatLng(doc['lat'], doc['lng']),
          'skills': doc['skills'],
          'experience': doc['experience'],
        })
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Stack(
        children: [
          _currentLocation == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentLocation!,
              zoom: 14,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            myLocationEnabled: true,
            markers: {
              if (_currentLocation != null)
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: _currentLocation!,
                  infoWindow: InfoWindow(title: 'Your Location'),
                ),
              ...nearbyMechanics.map(
                    (mechanic) => Marker(
                  markerId: MarkerId(mechanic['name']),
                  position: mechanic['location'],
                  infoWindow: InfoWindow(
                    title: mechanic['name'],
                    snippet: mechanic['skills'],
                  ),
                ),
              ),
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/scanVehicle');
              },
              child: Icon(Icons.car_repair),
              tooltip: 'Scan Vehicle',
            ),
          ),
          Positioned(
            bottom: 80,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                // Request help logic or navigate to help screen
              },
              child: Icon(Icons.engineering),
              tooltip: 'Find Engineer',
            ),
          ),
        ],
      ),
    );
  }
}
