import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io'; // Needed for File

class AIProblemDetectionScreen extends StatefulWidget {
  @override
  _AIProblemDetectionScreenState createState() => _AIProblemDetectionScreenState();
}

class _AIProblemDetectionScreenState extends State<AIProblemDetectionScreen> {
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;
  String _problemDescription = '';
  List<Mechanic> _nearbyMechanics = [];

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
      _detectProblem(_imagePath!);
    }
  }

  Future<void> _detectProblem(String imagePath) async {
    final problem = await AiService.detectProblem(imagePath);
    setState(() {
      _problemDescription = problem;
    });
    _fetchNearbyMechanics();
  }

  Future<void> _fetchNearbyMechanics() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _nearbyMechanics = await MechanicsService.getMechanicsNearLocation(position.latitude, position.longitude);
    setState(() {}); // Update UI with the fetched mechanics
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Problem Detection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Upload/Scan Vehicle Image'),
            ),
            if (_imagePath != null)
              Image.file(File(_imagePath!)), // Display the selected image
            SizedBox(height: 20),
            if (_problemDescription.isNotEmpty)
              Text('Detected Problem: $_problemDescription', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Nearby Mechanics:', style: TextStyle(fontSize: 20)),
            Expanded(
              child: ListView.builder(
                itemCount: _nearbyMechanics.length,
                itemBuilder: (context, index) {
                  final mechanic = _nearbyMechanics[index];
                  return ListTile(
                    title: Text(mechanic.name),
                    subtitle: Text(mechanic.location),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// AI Service
class AiService {
  static Future<String> detectProblem(String imagePath) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay
    return "Detected issue: Engine overheating"; // Sample output
  }
}

// Mechanics Service
class MechanicsService {
  static Future<List<Mechanic>> getMechanicsNearLocation(double latitude, double longitude) async {
    return [
      Mechanic(name: "John's Garage", location: "123 Main St"),
      Mechanic(name: "Doe Motors", location: "456 Elm St"),
    ];
  }
}

// Mechanic Class
class Mechanic {
  final String name;
  final String location;

  Mechanic({required this.name, required this.location});
}
