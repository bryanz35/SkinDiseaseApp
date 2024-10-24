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
      ClassificationModel classificationModel =
          await FlutterPytorch.loadClassificationModel(
        "assets/models/model_classification.pt",
        128,
        128,
      );

      // Ensure the model is not null
      if (classificationModel != null) {
        // Get the image file
        File imageFile = File(widget.imagePath);

        // Perform prediction
        List<double?>? predictionListProbabilities =
            await classificationModel.getImagePredictionListProbabilities(
          await imageFile.readAsBytes(),
        );

        if (predictionListProbabilities != null) {
          // Process the predictions to get the top 3
          topThreePredictions =
              _getTopThreePredictions(predictionListProbabilities);
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
    'Acne',
    'Skin Cancer (Melanoma)',
    'Dermatitis',
    'Blisters',
    'Bacterial Infections',
    'Eczema',
    'Rashes',
    'Hair Loss',
    'Herpes',
    'Pigmentation Issues',
    'Lupus',
    'Melanoma',
    'Nail Fungus',
    'Poison Ivy',
    'Psoriasis',
    'Scabies',
    'Benign Tumors',
    'Systemic Disease',
    'Fungal Infections',
    'Hives',
    'Vascular Tumors',
    'Vasculitis',
    'Warts and Viral Infections'
  ];
  List<String> diseaseAdvice = [
    'Keep the skin clean, avoid touching your face, and consider over-the-counter treatments with benzoyl peroxide or salicylic acid.', // Acne
    'Regularly check your skin for changes, use sunscreen daily, and see a dermatologist for a skin exam.', // Skin Cancer (Melanoma)
    'Identify and avoid triggers, use moisturizers, and consider topical corticosteroids for inflammation.', // Dermatitis
    'Avoid popping blisters; keep them clean and covered to prevent infection. If they burst, clean gently and apply a bandage.', // Blisters
    'Consult a healthcare professional for appropriate antibiotics, and keep affected areas clean and dry.', // Bacterial Infections
    'Use moisturizers regularly, avoid irritants, and consider topical treatments prescribed by a doctor.', // Eczema
    'Identify the cause (allergic reaction, infection, etc.), and use antihistamines or topical creams as needed.', // Rashes
    'Consult a dermatologist for potential treatments, consider a balanced diet, and manage stress.', // Hair Loss
    'Practice safe sex, use antiviral medications as prescribed, and avoid outbreaks by managing stress.', // Herpes
    'Use sunscreen daily, consult a dermatologist for treatments like creams or laser therapy.', // Pigmentation Issues
    'Early detection is crucial; monitor skin changes and consult a healthcare professional immediately if changes occur.', // Lupus
    'Monitor skin changes and consult a healthcare professional immediately if changes occur.', // Melanoma
    'Keep nails trimmed and clean, use antifungal treatments, and consider seeing a doctor for persistent cases.', // Nail Fungus
    'Wash the affected area immediately with soap and water, use topical steroids for itching, and avoid scratching.', // Poison Ivy
    'Use moisturizing creams, consider phototherapy, and discuss systemic treatments with a dermatologist.', // Psoriasis
    'Seek medical treatment for scabicide medications, and wash all clothing and bedding to prevent re-infestation.', // Scabies
    'Monitor any changes and consult with a healthcare professional if they grow or cause discomfort.', // Benign Tumors
    'Follow the treatment plan prescribed by a healthcare provider and maintain regular check-ups.', // Systemic Disease
    'Keep the affected area dry, use antifungal treatments as directed, and avoid sharing personal items.', // Fungal Infections
    'Identify and avoid triggers, and use antihistamines for relief.', // Hives
    'Consult a specialist for diagnosis and potential treatments, including observation or surgical options.', // Vascular Tumors
    'Follow your doctor’s treatment plan, which may include immunosuppressive drugs, and monitor symptoms closely.', // Vasculitis
    'Use over-the-counter treatments, avoid picking at warts, and consider professional removal if necessary.' // Warts and Viral Infections
  ];
  // List of indices to exclude (diseases that should be labeled as unclassifiable)
  List<int> excludeList = [
    2,
    3,
    4,
    6,
    8,
    9,
    10,
    13,
    15,
    17,
    19,
    20,
    21
  ]; // Example: Exclude "Rashes", "Lupus", "Systemic Disease", etc.

  // Method to get top three predictions, checking against the excludeList
  List<Map<String, dynamic>> _getTopThreePredictions(
      List<double?> probabilities) {
    // Create a list of predictions with their indices

    List<Map<String, dynamic>> predictions = [];
    for (int i = 0; i < probabilities.length; i++) {
      String diseaseName = diseaseNames[i];
      String description = diseaseAdvice[i];

      // Check if the disease index is in the exclude list
      if (excludeList.contains(i)) {
        diseaseName = "Unclassifiable or No Skin Disease";
        description =
            "This condition is not recognized or not classified as a skin disease.";
      }

      predictions.add({
        'name': diseaseName,
        'probability': probabilities[i],
        'description': description,
      });
    }

    // Sort predictions by probability in descending order and take the top 3
    predictions.sort(
        (a, b) => (b['probability'] ?? 0).compareTo(a['probability'] ?? 0));
    return predictions.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Results"),
        backgroundColor: Color(0xFF0A4DA2),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
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
                      '${prediction['name']}:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
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
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              foregroundColor: Color(0xFF0A4DA2), // Button color
              textStyle: TextStyle(fontSize: 16.0),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              // Logic to contact a doctor
            },
            icon: Icon(Icons.local_hospital),
            label: Text('Contact Doctor'),
          ),
        ],
      ),
    );
  }
}
