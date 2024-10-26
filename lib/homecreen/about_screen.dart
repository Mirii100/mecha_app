import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  // Sample data for demonstration
  final List<Map<String, String>> members = [
    {"name": "Member 1", "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBIn3MRy5Zbm3g-0vbNUfGaH1voHhZSJ75ug&s", "info": "Additional information about Member 1"},
    {"name": "Member 2", "image": "data:image/jpeg;base64,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", "info": "Additional information about Member 2"},
    {"name": "Member 3", "image": "https://via.placeholder.com/150", "info": "Additional information about Member 3"},
    {"name": "Member 4", "image": "https://via.placeholder.com/150", "info": "Additional information about Member 4"},
    {"name": "Member 5", "image": "https://via.placeholder.com/150", "info": "Additional information about Member 5"},
    {"name": "Member 6", "image": "https://via.placeholder.com/150", "info": "Additional information about Member 6"},
    {"name": "Member 7", "image": "https://via.placeholder.com/150", "info": "Additional information about Member 7"},
    {"name": "Member 8", "image": "https://via.placeholder.com/150", "info": "Additional information about Member 8"},
    {"name": "Member 9", "image": "https://via.placeholder.com/150", "info": "Additional information about Member 9"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Page")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: members.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2 / 2.5, // Adjusts the height/width of each container
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(members[index]["name"]!),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: Image.network(
                              members[index]["image"]!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(members[index]["info"]!),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(16.0), // Rounded corners
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          members[index]["image"]!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        members[index]["name"]!,
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
