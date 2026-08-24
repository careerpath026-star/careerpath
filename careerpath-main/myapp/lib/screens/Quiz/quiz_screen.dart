// lib/screens/Quiz/quiz_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/quiz_question_model.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuizQuestionModel> questions = [];
  int currentIndex = 0;
  bool loading = true;

  // domain -> count of matching answers
  final Map<String, int> domainScores = {};

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('quizQuestions')
        .get();

    setState(() {
      questions = snapshot.docs
          .map((doc) =>
              QuizQuestionModel.fromMap(doc.id, doc.data()))
          .toList();
      loading = false;
    });
  }

  void _answerQuestion(String selectedOption) {
    final question = questions[currentIndex];

    // If the user picks the "positive" answer, count it toward that domain
    if (selectedOption == question.correctAnswer) {
      domainScores[question.domainTag] =
          (domainScores[question.domainTag] ?? 0) + 1;
    }

    if (currentIndex < questions.length - 1) {
      setState(() => currentIndex++);
    } else {
      _finishQuiz();
    }
  }

  Future<void> _finishQuiz() async {
    // Find domain with highest score
    String resultDomain = 'Tech';
    int maxScore = -1;
    domainScores.forEach((domain, score) {
      if (score > maxScore) {
        maxScore = score;
        resultDomain = domain;
      }
    });

    // Save result to Firestore under the user's document
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('quizResults')
          .add({
        'result_domain': resultDomain,
        'domain_scores': domainScores,
        'taken_at': FieldValue.serverTimestamp(),
      });

      // Also update a quick-access field on the user doc for dashboard use
      await FirebaseFirestore.instance.collection('users').doc(uid).set(
        {'last_quiz_result': resultDomain},
        SetOptions(merge: true),
      );
    }

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => QuizResultScreen(resultDomain: resultDomain),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No quiz questions available.')),
      );
    }

    final question = questions[currentIndex];
    final progress = (currentIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Interest Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 8),
            Text('Question ${currentIndex + 1} of ${questions.length}',
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            Text(
              question.questionText,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...question.options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => _answerQuestion(option),
                    child: Text(option),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}