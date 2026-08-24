// lib/screens/Resources/resource_library_screen.dart
//
// NOTE: requires the url_launcher package in pubspec.yaml:
//   url_launcher: ^6.3.1
// then run: flutter pub get

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/resource_model.dart';

class ResourceLibraryScreen extends StatelessWidget {
  const ResourceLibraryScreen({super.key});

  Future<void> _openResource(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || !await canLaunchUrl(uri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open this resource.')),
        );
      }
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resource Library')),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('resources').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No resources available.'));
          }

          final resources = snapshot.data!.docs
              .map((doc) => ResourceModel.fromMap(
                  doc.id, doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: resources.length,
            itemBuilder: (context, index) {
              final r = resources[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.picture_as_pdf_outlined,
                      color: Colors.redAccent),
                  title: Text(r.title,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Wrap(
                    spacing: 6,
                    children: [
                      Chip(
                        label: Text(r.category,
                            style: const TextStyle(fontSize: 11)),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                      ),
                      Chip(
                        label: Text(r.tag,
                            style: const TextStyle(fontSize: 11)),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.download_outlined),
                  onTap: () => _openResource(context, r.fileUrl),
                ),
              );
            },
          );
        },
      ),
    );
  }
}