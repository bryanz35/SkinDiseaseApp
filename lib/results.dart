import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';

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
            onPressed: () async {
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
                  File imageFile = File(imagePath);

                  // Perform prediction
                  List<double?>? predictionListProbabilities = await classificationModel.getImagePredictionListProbabilities(
                    await imageFile.readAsBytes(),
                  );

                  // Handle the prediction result (e.g., display or save)
                  print(predictionListProbabilities);
                }
              } catch (e) {
                // Handle errors
                print("Error during model loading or prediction: $e");
              }
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
