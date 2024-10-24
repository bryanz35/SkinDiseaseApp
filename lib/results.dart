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
        128,
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

  List<Map<String, dynamic>> _getTopThreePredictions(List<double?> probabilities) {
    // Create a list of predictions with their indices
    List<Map<String, dynamic>> predictions = [];
    for (int i = 0; i < probabilities.length; i++) {
      predictions.add({
        'name': 'Disease ${i + 1}', // Replace with actual disease names if available
        'probability': probabilities[i],
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
        backgroundColor: Color(0xFF0A4DA2),
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
        padding: EdgeInsets.all(16.0),
        children: [
          Image.file(File(widget.imagePath)),
          SizedBox(height: 20),
          // Display the top 3 prediction results
          if (topThreePredictions != null) ...[
            for (var prediction in topThreePredictions!)
              ListTile(
                title: Text('${prediction['name']}: ${prediction['probability']?.toStringAsFixed(2)}%'),
              ),
          ] else ...[
            // Placeholder while predictions are loading
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Loading predictions...'),
          ],
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              primary: Color(0xFF0A4DA2), // Button color
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              // Logic to contact a doctor
            },
            child: Text('Contact Doctor', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
