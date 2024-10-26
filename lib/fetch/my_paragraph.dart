import 'package:flutter/material.dart';

class ParagraphWidget extends StatelessWidget {
  final String text;

  ParagraphWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add padding for better readability
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16, // Font size for the paragraph
          color: Colors.black, // Text color
          height: 1.5, // Line height for better spacing
        ),
        textAlign: TextAlign.justify, // Justify the text for a clean look
      ),
    );
  }
}
