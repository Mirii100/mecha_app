import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VehicleScanScreen extends StatefulWidget {
  @override
  _VehicleScanScreenState createState() => _VehicleScanScreenState();
}

class _VehicleScanScreenState extends State<VehicleScanScreen> {
  bool isScanning = false; // State variable to track scanning status
  String scanResult = ''; // State variable to store scan result

  Future<Map<String, dynamic>> fetchVehicleDiagnostics(String vehicleVIN) async {
    final String apiUrl = 'https://example-api.com/diagnostics/$vehicleVIN';
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': 'Bearer YOUR_API_KEY',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load vehicle diagnostics');
    }
  }

  Future<void> scanVehicle(String vehicleVIN) async {
    setState(() {
      isScanning = true; // Update scanning status
    });

    try {
      var diagnostics = await fetchVehicleDiagnostics(vehicleVIN);
      setState(() {
        scanResult = 'Issue: ${diagnostics['issue']}'; // Update scan result
      });
    } catch (e) {
      setState(() {
        scanResult = 'Error scanning vehicle: $e'; // Handle errors
      });
    }

    setState(() {
      isScanning = false; // Reset scanning status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vehicle Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(scanResult), // Display scan result
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => scanVehicle('YOUR_VEHICLE_VIN'), // Call scanVehicle
              child: isScanning ? CircularProgressIndicator() : Text('Scan Vehicle'),
            ),
          ],
        ),
      ),
    );
  }
}
