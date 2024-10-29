import 'package:flutter/material.dart';
import '../user_engineer/fetch_data.dart';
import 'engineers_details.dart';
import 'my_engineer.dart'; // Ensure this imports the Mechanic class

class MechanicsListScreen extends StatefulWidget {
  @override
  _MechanicsListScreenState createState() => _MechanicsListScreenState();
}

class _MechanicsListScreenState extends State<MechanicsListScreen> {
  final MechanicsService mechanicsService = MechanicsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Mechanics"),
      ),
      body: StreamBuilder<List<Mechanic>>(
        stream: mechanicsService.getMechanicsStream(), // Use stream to listen for updates
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Fetching mechanics...")); // Optionally display text while waiting
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}")); // Handle errors
          }

          final mechanics = snapshot.data ?? []; // Get the list of mechanics

          return ListView.builder(
            itemCount: mechanics.length,
            itemBuilder: (context, index) {
              final mechanic = mechanics[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(mechanic.profilePic),
                ),
                title: Text(
                  mechanic.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("${mechanic.distance} km away - ${mechanic.status}"),
                trailing: mechanic.rating != null
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(mechanic.rating.toString()),
                  ],
                )
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MechanicProfileScreen(mechanic: mechanic),
                    ),
                  );
                },
              );
            },
          );
        },
      ),

    );
  }
}
