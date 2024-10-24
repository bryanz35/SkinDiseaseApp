import 'package:flutter/material.dart';
import 'camera.dart'; // Camera functionality

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
          backgroundColor: Color(0xFF0A4DA2), // Button color (Deep Blue)
        ),
        child: Icon(Icons.camera_alt, size: 50, color: Colors.white),
      ),
    );
  }

  void _showSurveyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Questionnaire", style: TextStyle(color: Color(0xFF0A4DA2))),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SurveyQuestion(label: "How long has the rash been present?", options: ["Acute (days to weeks)", "Chronic (months to years)"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Have you had a recent illness, fever, or infection before the rash started?", options: ["Yes", "No"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Have you come into contact with anyone who has a similar rash or skin condition?", options: ["Yes", "No"]),
                // More survey questions...
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                _openCamera(context);
              },
              child: Text("Submit", style: TextStyle(color: Color(0xFF0A4DA2))),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _openCamera(context);
              },
              child: Text("Skip", style: TextStyle(color: Color(0xFF0A4DA2))),
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
  final String label;
  final List<String> options;

  SurveyQuestion({required this.label, required this.options});

  @override
  _SurveyQuestionState createState() => _SurveyQuestionState();
}

class _SurveyQuestionState extends State<SurveyQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(fontSize: 16, color: Color(0xFF333333))),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: widget.options.map((option) {
            return ChoiceChip(
              label: Text(option, style: TextStyle(color: _selectedOption == option ? Colors.white : Color(0xFF0A4DA2))),
              selectedColor: Color(0xFF0A4DA2),
              selected: _selectedOption == option,
              onSelected: (selected) {
                setState(() {
                  _selectedOption = selected ? option : null;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
