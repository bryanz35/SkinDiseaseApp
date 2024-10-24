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
                SurveyQuestion(label: "How long has the rash been present?", options: ["Acute (days to weeks)", "Chronic (months to years)"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Have you had a recent illness, fever, or infection before the rash started?", options: ["Yes", "No"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Have you come into contact with anyone who has a similar rash or skin condition?", options: ["Yes", "No"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Have you recently traveled, been outdoors in wooded areas, or had insect bites?", options: ["Yes", "No"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Where is the rash located?", options: ["Face and Scalp", "Hands and Feet", "Trunk and Back", "Sun-exposed areas"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "What does the rash look like?", options: ["Red bumps, pustules, or nodules", "Scaly, dry, and thickened skin", "Blisters or bullae", "Wart-like growths", "Dark, moles, or pigmented lesions"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Does the rash itch, burn, or cause pain?", options: ["Intense itching", "Burning or painful lesions"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Have you used any new skin products, medications, or been exposed to chemicals?", options: ["Yes", "No"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Have you had prolonged sun exposure or used tanning beds?", options: ["Yes", "No"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Have you noticed hair loss or scalp changes?", options: ["Yes", "No"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Do you have any changes in your nails (discoloration, thickening, cracking)?", options: ["Yes", "No"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Are you experiencing joint pain, fatigue, or systemic symptoms?", options: ["Yes", "No"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Have you had a history of skin cancer or precancerous lesions?", options: ["Yes", "No"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Do you have a history of allergies or asthma?", options: ["Yes", "No"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Does anyone in your family have similar skin conditions or autoimmune diseases?", options: ["Yes", "No"]),
                SizedBox(height: 10),
                SurveyQuestion(label: "Has the rash changed over time (spread, darkened, crusted)?", options: ["Yes", "No"]),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
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
        Text(widget.label),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: widget.options.map((option) {
            return ChoiceChip(
              label: Text(option),
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

