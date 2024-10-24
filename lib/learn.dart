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
    {
      'title': 'Melanoma',
      'description':
          'Melanoma is the most dangerous form of skin cancer, characterized by unusual moles or dark pigmented lesions. Early detection is crucial.',
      'riskLevel': 'Severe',
      'advice':
          'Consult a doctor immediately if you notice changes in moles or new pigmented spots. Early treatment can prevent cancer spread.'
    },
    {
      'title': 'Nail Fungus',
      'description':
          'Nail fungus causes thick, discolored nails that may become brittle or crumbly. It can start as a yellow or white spot under the nail.',
      'riskLevel': 'Moderate',
      'advice':
          'Use antifungal creams or oral medication. If persistent, consult a doctor for potential laser treatment or nail removal.'
    },
    {
      'title': 'Psoriasis',
      'description':
          'Psoriasis causes red, scaly patches on the skin due to an overactive immune system. It commonly affects elbows, knees, and the scalp.',
      'riskLevel': 'Chronic',
      'advice':
          'Moisturizers, topical treatments, and lifestyle changes may help. Consult a dermatologist if symptoms persist or worsen.'
    },
    {
      'title': 'Seborrheic Keratoses',
      'description':
          'Seborrheic Keratoses are benign growths, usually brown or black, that appear on the skin as people age. They are harmless.',
      'riskLevel': 'Low',
      'advice':
          'No treatment is necessary unless irritated. If you find the growth bothersome, a doctor can remove it through cryotherapy or other methods.'
    },
    {
      'title': 'Bullous Disease',
      'description':
          'Bullous diseases are skin conditions characterized by large blisters or bullae. These can be itchy or painful and are often autoimmune.',
      'riskLevel': 'Severe',
      'advice':
          'Consult a dermatologist immediately. Treatment typically involves corticosteroids or immunosuppressants to manage symptoms.'
    },
    {
      'title': 'Hair Loss (Alopecia)',
      'description':
          'Alopecia refers to hair loss from the scalp or body. It may result from genetics, stress, or autoimmune disorders.',
      'riskLevel': 'Chronic',
      'advice':
          'Consider consulting a dermatologist. Treatments may include topical medications, oral drugs, or lifestyle changes.'
    },
    {
      'title': 'Vascular Tumor',
      'description':
          'Vascular tumors are abnormal growths of blood vessels and can be benign or malignant. They often appear as red or purple lumps.',
      'riskLevel': 'Varies',
      'advice':
          'See a healthcare provider for evaluation. Treatment depends on the type and severity of the tumor.'
    },
    {
      'title': 'Lyme Disease',
      'description':
          'A bacterial infection caused by the bite of an infected tick, Lyme disease can cause fever, fatigue, and a distinctive bullseye rash.',
      'riskLevel': 'Severe',
      'advice':
          'See a doctor immediately for antibiotics. Early treatment is key to preventing long-term complications.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: diseases.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Learn'),
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    disease['description']!,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Risk Level: ${disease['riskLevel']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    disease['advice']!,
                    style: TextStyle(fontSize: 16),
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
