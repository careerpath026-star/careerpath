// lib/screens/CareerBank/career_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/career_model.dart';

class CareerDetailScreen extends StatefulWidget {
  final CareerModel career;
  const CareerDetailScreen({super.key, required this.career});

  @override
  State<CareerDetailScreen> createState() => _CareerDetailScreenState();
}

class _CareerDetailScreenState extends State<CareerDetailScreen> {
  bool isBookmarked = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _checkIfBookmarked();
  }

  Future<void> _checkIfBookmarked() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('bookmarks')
        .doc(widget.career.id)
        .get();

    setState(() {
      isBookmarked = doc.exists;
      loading = false;
    });
  }

  Future<void> _toggleBookmark() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final bookmarkRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('bookmarks')
        .doc(widget.career.id);

    if (isBookmarked) {
      await bookmarkRef.delete();
    } else {
      await bookmarkRef.set({
        'career_id': widget.career.id,
        'title': widget.career.title,
        'domain': widget.career.domain,
        'saved_at': FieldValue.serverTimestamp(),
      });
    }

    setState(() => isBookmarked = !isBookmarked);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isBookmarked ? 'Bookmarked!' : 'Bookmark removed.'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final career = widget.career;

    return Scaffold(
      appBar: AppBar(
        title: Text(career.title),
        actions: [
          if (!loading)
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              ),
              onPressed: _toggleBookmark,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(career.title,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Chip(label: Text(career.domain)),
            const SizedBox(height: 16),

            const Text('Description',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(career.description),
            const SizedBox(height: 16),

            const Text('Required Skills',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: career.requiredSkills
                  .map((skill) => Chip(label: Text(skill)))
                  .toList(),
            ),
            const SizedBox(height: 16),

            const Text('Education Path',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(career.educationPath),
            const SizedBox(height: 16),

            const Text('Expected Salary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(career.expectedSalary),
          ],
        ),
      ),
    );
  }
}