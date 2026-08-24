// lib/screens/CareerBank/career_bank_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/career_model.dart';
import 'career_detail_screen.dart';

class CareerBankScreen extends StatefulWidget {
  const CareerBankScreen({super.key});

  @override
  State<CareerBankScreen> createState() => _CareerBankScreenState();
}

class _CareerBankScreenState extends State<CareerBankScreen> {
  String selectedDomain = 'All';
  final List<String> domains = [
    'All',
    'Tech',
    'Healthcare',
    'Business',
    'Creative',
    'Engineering',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Career Bank')),
      body: Column(
        children: [
          // ---- Domain filter dropdown ----
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Text('Filter by domain: ',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedDomain,
                    items: domains
                        .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                        .toList(),
                    onChanged: (value) {
                      setState(() => selectedDomain = value!);
                    },
                  ),
                ),
              ],
            ),
          ),

          // ---- Career list from Firestore ----
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('careers')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No careers found.'));
                }

                final careers = snapshot.data!.docs
                    .map((doc) => CareerModel.fromMap(
                        doc.id, doc.data() as Map<String, dynamic>))
                    .where((c) =>
                        selectedDomain == 'All' || c.domain == selectedDomain)
                    .toList();

                if (careers.isEmpty) {
                  return const Center(
                      child: Text('No careers in this domain.'));
                }

                return ListView.builder(
                  itemCount: careers.length,
                  itemBuilder: (context, index) {
                    final career = careers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(career.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(career.domain),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CareerDetailScreen(career: career),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}