import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Username: John Doe'),
            subtitle: Text('Age: 25'),
          ),
          ListTile(
            title: Text('Email: john.doe@example.com'),
          ),
          Divider(),
          ListTile(
            title: Text('Past Scans'),
            subtitle: Text('Scan on 23 Oct 2024: Acne 85%'),
          ),
          // Add more past scans...
          Divider(),
          ListTile(
            title: Text('Privacy Policy'),
            onTap: () {
              // Open privacy policy
            },
          ),
        ],
      ),
    );
  }
}