import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';

class ResultsScreen extends StatefulWidget {
  final String imagePath;

  ResultsScreen({required this.imagePath});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<Map<String, dynamic>>? topThreePredictions;

  @override
  void initState() {
    super.initState();
    _loadModelAndPredict();
  }

  Future<void> _loadModelAndPredict() async {
    try {
      // Load the model asynchronously
      ClassificationModel classificationModel = await FlutterPytorch.loadClassificationModel(
          "assets/models/model_classification.pt",
          128,
          128
      );

      // Ensure the model is not null
      if (classificationModel != null) {
        // Get the image file
        File imageFile = File(widget.imagePath);

        // Perform prediction
        List<double?>? predictionListProbabilities = await classificationModel.getImagePredictionListProbabilities(
          await imageFile.readAsBytes(),
        );

        if (predictionListProbabilities != null) {
          // Process the predictions to get the top 3
          topThreePredictions = _getTopThreePredictions(predictionListProbabilities);
        }

        // Trigger a rebuild with the predictions
        setState(() {});
      }
    } catch (e) {
      // Handle errors
      print("Error during model loading or prediction: $e");
    }
  }

  // List of diseases with simplified names
  List<String> diseaseNames = [
    'Acne', 'Skin Cancer (Melanoma)', 'Dermatitis', 'Blisters', 'Bacterial Infections',
    'Eczema', 'Rashes', 'Hair Loss', 'Herpes', 'Pigmentation Issues',
    'Lupus', 'Melanoma', 'Nail Fungus', 'Poison Ivy', 'Psoriasis',
    'Scabies', 'Benign Tumors', 'Systemic Disease', 'Fungal Infections',
    'Hives', 'Vascular Tumors', 'Vasculitis', 'Warts and Viral Infections'
  ];

  // List of indices to exclude (diseases that should be labeled as unclassifiable)
  List<int> excludeList =             [2, 3, 4, 6,8,9,10,13,15,17,19,20,21]; // Example: Exclude "Rashes", "Lupus", "Systemic Disease", etc.

  // Method to get top three predictions, checking against the excludeList
  List<Map<String, dynamic>> _getTopThreePredictions(List<double?> probabilities) {
    // Create a list of predictions with their actual disease names
    List<Map<String, dynamic>> predictions = [];
    for (int i = 0; i < probabilities.length; i++) {
      String diseaseName = diseaseNames[i];
      String description = "This is a brief description of $diseaseName.";

      // Check if the disease index is in the exclude list
      if (excludeList.contains(i)) {
        diseaseName = "Unclassifiable or No Skin Disease";
        description = "This condition is not recognized or not classified as a skin disease.";
      }

      predictions.add({
        'name': diseaseName,
        'probability': probabilities[i],
        'description': description,
      });
    }

    // Sort predictions by probability in descending order and take the top 3
    predictions.sort((a, b) => (b['probability'] ?? 0).compareTo(a['probability'] ?? 0));
    return predictions.take(3).toList();
  }

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
      body: ListView(
        children: [
          Image.file(File(widget.imagePath)),
          SizedBox(height: 20),
          // Display the top 3 prediction results
          if (topThreePredictions != null) ...[
            for (var prediction in topThreePredictions!)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${prediction['name']}: ${prediction['probability']?.toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '${prediction['description']}',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
          ] else ...[
            // Placeholder while predictions are loading
            Center(child: CircularProgressIndicator()),
            SizedBox(height: 20),
            Center(child: Text('Loading predictions...')),
          ],
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Logic to contact a doctor
            },
            icon: Icon(Icons.local_hospital),
            label: Text('Contact Doctor'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              textStyle: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
