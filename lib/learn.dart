import 'package:flutter/material.dart';

class LearnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Lyme Disease'),
            onTap: () {
              // Navigate to detailed page about Lyme Disease
            },
          ),
          ListTile(
            title: Text('Acne'),
            onTap: () {
              // Navigate to detailed page about Acne
            },
          ),
          // Add more conditions...
        ],
      ),
    );
  }
}