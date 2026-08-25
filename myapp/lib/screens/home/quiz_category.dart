import 'package:flutter/material.dart';
import 'student_quiz.dart';

class QuizCategory extends StatelessWidget {
  const QuizCategory({super.key});

  void startQuiz(BuildContext context, String field) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentQuiz(
          selectedField: field,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        title: const Text(
          "Choose Your Field",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              const Text(
                "Select Your Career Field",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Choose the field you want to take the quiz for.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 30),

              _fieldCard(
                context: context,
                title: "Computer Science",
                subtitle: "Computer, programming & technology",
                icon: Icons.computer,
                field: "computer",
              ),

              const SizedBox(height: 18),

              _fieldCard(
                context: context,
                title: "Medical",
                subtitle: "Biology, chemistry & medical sciences",
                icon: Icons.medical_services,
                field: "medical",
              ),

              const SizedBox(height: 18),

              _fieldCard(
                context: context,
                title: "Engineering",
                subtitle: "Mathematics, physics & engineering",
                icon: Icons.engineering,
                field: "engineering",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required String field,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => startQuiz(context, field),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF151F32),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 58,
              width: 58,
              decoration: BoxDecoration(
                color: const Color(0xFF00C2FF).withOpacity(0.12),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF00C2FF),
                size: 30,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}