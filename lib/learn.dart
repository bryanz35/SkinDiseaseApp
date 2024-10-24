import 'package:flutter/material.dart';

class LearnPage extends StatelessWidget {
  final List<Map<String, String>> diseases = [
    {
      'title': 'Acne',
      'description':
          'Acne occurs when hair follicles are clogged with oil and dead skin cells. Common symptoms include pimples, blackheads, and cysts, often affecting the face, chest, and back.',
      'riskLevel': 'Moderate',
      'advice':
          'Consider topical creams, oral medications, and lifestyle adjustments. If it worsens, see a dermatologist to avoid scarring.'
    },
    {
      'title': 'Eczema',
      'description':
          'Eczema is a condition that makes your skin red, inflamed, and itchy. It is common in children but can occur at any age.',
      'riskLevel': 'Moderate',
      'advice':
          'Use moisturizers and avoid irritants. Consult a healthcare provider for stronger topical medications if needed.'
    },
    // Other diseases...
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: diseases.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Learn'),
          backgroundColor: Color(0xFF0A4DA2), // Deep Blue
          bottom: TabBar(
            isScrollable: true,
            tabs: diseases.map((disease) => Tab(text: disease['title'])).toList(),
          ),
        ),
        body: TabBarView(
          children: diseases.map((disease) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    disease['title']!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    disease['description']!,
                    style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Risk Level: ${disease['riskLevel']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0A4DA2)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    disease['advice']!,
                    style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

