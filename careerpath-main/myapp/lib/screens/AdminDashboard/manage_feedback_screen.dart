// lib/screens/AdminDashboard/manage_feedback_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageFeedbackScreen extends StatelessWidget {
  const ManageFeedbackScreen({super.key});

  Color _statusColor(String status) {
    switch (status) {
      case 'resolved':
        return Colors.green;
      case 'in progress':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Feedback')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('feedback')
            .orderBy('submitted_at', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No feedback submitted yet.'));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;
              final status = data['status'] ?? 'pending';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text(data['message'] ?? ''),
                  subtitle: Text('Category: ${data['category'] ?? ''}'),
                  trailing: DropdownButton<String>(
                    value: status,
                    underline: const SizedBox(),
                    items: ['pending', 'in progress', 'resolved']
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text(
                                s,
                                style: TextStyle(color: _statusColor(s)),
                              ),
                            ))
                        .toList(),
                    onChanged: (newStatus) {
                      FirebaseFirestore.instance
                          .collection('feedback')
                          .doc(doc.id)
                          .update({'status': newStatus});
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}