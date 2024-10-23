import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class NearbyMechanicsScreen extends StatefulWidget {
  @override
  _NearbyMechanicsScreenState createState() => _NearbyMechanicsScreenState();
}

// Define the _GeoQueryCondition class
class _GeoQueryCondition {
  final double radiusInKm;
  final CameraPosition cameraPosition;

  _GeoQueryCondition({
    required this.radiusInKm,
    required this.cameraPosition,
  });
}

class _NearbyMechanicsScreenState extends State<NearbyMechanicsScreen> {
  Set<Marker> _markers = {};

  // Initialize _geoQueryCondition properly
  final _geoQueryCondition = BehaviorSubject<_GeoQueryCondition>.seeded(
    _GeoQueryCondition(
      radiusInKm: 10, // Example radius in km
      cameraPosition: CameraPosition(target: LatLng(35.0, 139.0), zoom: 12), // Example camera position
    ),
  );

  late final Stream<List<DocumentSnapshot<Map<String, dynamic>>>> _stream =
  _geoQueryCondition.switchMap(
        (geoQueryCondition) =>
        GeoCollectionReference(FirebaseFirestore.instance.collection('mechanics'))
            .subscribeWithin(
          center: GeoFirePoint(GeoPoint(
            geoQueryCondition.cameraPosition.target.latitude,
            geoQueryCondition.cameraPosition.target.longitude,
          )),
          radiusInKm: geoQueryCondition.radiusInKm,
          field: 'geo',
          geopointFrom: (data) =>
          (data['geo'] as Map<String, dynamic>)['geopoint'] as GeoPoint,
          strictMode: true,
        ),
  );

  void _updateMarkersByDocumentSnapshots(
      List<DocumentSnapshot<Map<String, dynamic>>> documentSnapshots) {
    final markers = <Marker>{};
    for (final ds in documentSnapshots) {
      final id = ds.id;
      final data = ds.data();
      if (data == null) {
        continue;
      }
      final geoPoint = (data['geo'] as Map<String, dynamic>)['geopoint'] as GeoPoint;
      markers.add(Marker(
        markerId: MarkerId(id),
        position: LatLng(geoPoint.latitude, geoPoint.longitude),
        infoWindow: InfoWindow(title: data['name']),
      ));
    }
    setState(() {
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: _markers,
            initialCameraPosition: CameraPosition(target: LatLng(35.0, 139.0), zoom: 12),
            onMapCreated: (_) => _stream.listen(_updateMarkersByDocumentSnapshots),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _geoQueryCondition.close();
    super.dispose();
  }
}
