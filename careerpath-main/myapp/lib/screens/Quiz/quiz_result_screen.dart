// lib/screens/Quiz/quiz_result_screen.dart

import 'package:flutter/material.dart';

class QuizResultScreen extends StatelessWidget {
  final String resultDomain;
  const QuizResultScreen({super.key, required this.resultDomain});

  String _messageFor(String domain) {
    switch (domain) {
      case 'Tech':
        return 'You show strong potential in Technology roles — software, data, and design-driven careers suit you well.';
      case 'Healthcare':
        return 'You show strong potential in Healthcare roles — caring, service-driven careers suit you well.';
      case 'Business':
        return 'You show strong potential in Business roles — management, marketing, and finance suit you well.';
      case 'Creative':
        return 'You show strong potential in Creative roles — design, media, and content careers suit you well.';
      case 'Engineering':
        return 'You show strong potential in Engineering roles — technical, hands-on careers suit you well.';
      default:
        return 'Explore the Career Bank to find roles that match your interests.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Result')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, size: 72, color: Colors.amber),
            const SizedBox(height: 16),
            Text(
              'Recommended Domain: $resultDomain',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              _messageFor(resultDomain),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}