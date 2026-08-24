// lib/screens/AdminDashboard/manage_careers_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageCareersScreen extends StatelessWidget {
  const ManageCareersScreen({super.key});

  void _showCareerForm(BuildContext context, {DocumentSnapshot? existing}) {
    final titleCtrl = TextEditingController(
        text: existing != null ? existing['title'] : '');
    final descCtrl = TextEditingController(
        text: existing != null ? existing['description'] : '');
    final domainCtrl = TextEditingController(
        text: existing != null ? existing['domain'] : '');
    final skillsCtrl = TextEditingController(
        text: existing != null
            ? (existing['required_skills'] as List).join(', ')
            : '');
    final eduCtrl = TextEditingController(
        text: existing != null ? existing['education_path'] : '');
    final salaryCtrl = TextEditingController(
        text: existing != null ? existing['expected_salary'] : '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existing == null ? 'Add Career' : 'Edit Career'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: 'Title')),
              TextField(
                  controller: descCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Description')),
              TextField(
                  controller: domainCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Domain (Tech/Business/etc)')),
              TextField(
                  controller: skillsCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Skills (comma separated)')),
              TextField(
                  controller: eduCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Education Path')),
              TextField(
                  controller: salaryCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Expected Salary')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final data = {
                'title': titleCtrl.text.trim(),
                'description': descCtrl.text.trim(),
                'domain': domainCtrl.text.trim(),
                'required_skills': skillsCtrl.text
                    .split(',')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .toList(),
                'education_path': eduCtrl.text.trim(),
                'expected_salary': salaryCtrl.text.trim(),
              };

              if (existing == null) {
                await FirebaseFirestore.instance
                    .collection('careers')
                    .add(data);
              } else {
                await FirebaseFirestore.instance
                    .collection('careers')
                    .doc(existing.id)
                    .update(data);
              }

              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteCareer(BuildContext context, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Career'),
        content: const Text('Are you sure you want to delete this career?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Delete',
                  style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseFirestore.instance.collection('careers').doc(id).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Careers')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCareerForm(context),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('careers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No careers yet. Add one!'));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(doc['title'] ?? ''),
                  subtitle: Text(doc['domain'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () =>
                            _showCareerForm(context, existing: doc),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteCareer(context, doc.id),
                      ),
                    ],
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