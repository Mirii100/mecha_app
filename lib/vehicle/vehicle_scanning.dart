import 'package:flutter/material.dart';

class VehicleScanningScreen extends StatefulWidget {
  @override
  _VehicleScanningScreenState createState() => _VehicleScanningScreenState();
}

class _VehicleScanningScreenState extends State<VehicleScanningScreen> {
  bool isScanning = false;
  String? scanResult;

  Future<void> scanVehicle() async {
    setState(() {
      isScanning = true;
    });

    // Simulate a vehicle scan
    await Future.delayed(Duration(seconds: 3));

    // Here, you'll get data from your backend or diagnostics API
    setState(() {
      scanResult = 'Potential issue found: Low Engine Oil';
      isScanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Vehicle'),
      ),
      body: Center(
        child: isScanning
            ? CircularProgressIndicator()
            : scanResult == null
            ? ElevatedButton(
          onPressed: scanVehicle,
          child: Text('Start Vehicle Scan'),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Scan Result:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              scanResult!,
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  scanResult = null;
                });
              },
              child: Text('Scan Again'),
            ),
          ],
        ),
      ),
    );
  }
}
