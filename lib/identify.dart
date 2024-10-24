import 'package:flutter/material.dart';
import 'camera.dart'; // Camera functionality
// Result screen after scanning

class IdentifyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _showSurveyDialog(context);
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(50),
          backgroundColor: Colors.blue, // Button color
        ),
        child: Icon(Icons.camera_alt, size: 50),
      ),
    );
  }

  void _showSurveyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Questionnaire"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text("How long has the rash been present?"),
                SurveyQuestion(),
                SizedBox(height: 10),
                Text("Have you had a recent illness?"),
                SurveyQuestion(),
                // Add more questions here...
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _openCamera(context); // Proceed to camera after survey
              },
              child: Text("Submit"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _openCamera(context); // Skip questionnaire
              },
              child: Text("Skip"),
            ),
          ],
        );
      },
    );
  }

  void _openCamera(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen()),
    );
  }
}

class SurveyQuestion extends StatefulWidget {
  @override
  _SurveyQuestionState createState() => _SurveyQuestionState();
}

class _SurveyQuestionState extends State<SurveyQuestion> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(_value ? "Yes" : "No"),
      value: _value,
      onChanged: (bool newValue) {
        setState(() {
          _value = newValue;
        });
      },
    );
  }
}

