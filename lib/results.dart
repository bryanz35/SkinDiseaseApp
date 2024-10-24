import 'dart:io';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String imagePath;

  ResultsScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Results"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Logic to save the result to profile
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Image.file(File(imagePath)),
          SizedBox(height: 20),
          // Display the list of possible diseases with percentages
          ListTile(
            title: Text('Acne: 85%'),
          ),
          ListTile(
            title: Text('Eczema: 10%'),
          ),
          // More results here...
          Spacer(),
          ElevatedButton(
            onPressed: () {
              // Logic to contact a doctor
            },
            child: Text('Contact Doctor'),
          ),
        ],
      ),
    );
  }
}
