import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF0A4DA2),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Username: John Doe', style: TextStyle(fontSize: 18, color: Color(0xFF333333))),
            subtitle: Text('Age: 25', style: TextStyle(fontSize: 16, color: Color(0xFF333333))),
          ),
          ListTile(
            title: Text('Email: john.doe@example.com', style: TextStyle(fontSize: 18, color: Color(0xFF333333))),
          ),
          Divider(),
          ListTile(
            title: Text('Past Scans', style: TextStyle(fontSize: 18, color: Color(0xFF0A4DA2))),
            subtitle: Text('Scan on 23 Oct 2024: Acne 85%', style: TextStyle(fontSize: 16, color: Color(0xFF333333))),
          ),
          Divider(),
          ListTile(
            title: Text('Privacy Policy', style: TextStyle(fontSize: 18, color: Color(0xFF0A4DA2))),
            onTap: () {
              // Open privacy policy
            },
          ),
        ],
      ),
    );
  }
}
