import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentQuiz extends StatefulWidget {
  final String selectedField;

  const StudentQuiz({
    super.key,
    required this.selectedField,
  });

  @override
  State<StudentQuiz> createState() => _StudentQuizState();
}

class _StudentQuizState extends State<StudentQuiz> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> questions = [];

  int currentQuestion = 0;

  int score = 0;

  String? selectedAnswer;

  bool loading = true;

  bool submitting = false;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  // ==========================================================
  // LOAD QUESTIONS FROM FIREBASE
  // ==========================================================

  Future<void> loadQuestions() async {
    try {
      final snapshot = await _firestore
          .collection('quiz_questions')
          .where(
            'role',
            isEqualTo: 'student',
          )
          .where(
            'fields',
            arrayContains: widget.selectedField,
          )
          .get();

      final loadedQuestions = snapshot.docs.map((doc) {
        final data = doc.data();

        return {
          'id': doc.id,
          ...data,
        };
      }).toList();

      // Randomize questions
      loadedQuestions.shuffle();

      if (!mounted) return;

      setState(() {
        questions = loadedQuestions;
        loading = false;
      });
    } catch (e) {
      debugPrint("Quiz Error: $e");

      if (!mounted) return;

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to load quiz: $e",
          ),
        ),
      );
    }
  }

  // ==========================================================
  // SELECT ANSWER
  // ==========================================================

  void selectAnswer(String answer) {
    if (submitting) return;

    setState(() {
      selectedAnswer = answer;
    });
  }

  // ==========================================================
  // NEXT QUESTION
  // ==========================================================

  void nextQuestion() {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select an answer first.",
          ),
        ),
      );

      return;
    }

    final current = questions[currentQuestion];

    final correctAnswer =
        current['correctAnswer']?.toString() ?? '';

    if (selectedAnswer == correctAnswer) {
      score++;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
      });
    } else {
      finishQuiz();
    }
  }

  // ==========================================================
  // FINISH QUIZ
  // ==========================================================

  void finishQuiz() {
    setState(() {
      submitting = true;
    });

    final total = questions.length;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultScreen(
          field: widget.selectedField,
          score: score,
          total: total,
        ),
      ),
    );
  }

  // ==========================================================
  // FIELD NAME
  // ==========================================================

  String get fieldName {
    switch (widget.selectedField) {
      case 'computer':
        return 'Computer Science';

      case 'medical':
        return 'Medical';

      case 'engineering':
        return 'Engineering';

      default:
        return widget.selectedField;
    }
  }

  // ==========================================================
  // LOADING
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        backgroundColor: const Color(0xFF0B1220),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0B1220),
          elevation: 0,
          title: Text(
            "$fieldName Quiz",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF00C2FF),
          ),
        ),
      );
    }

    // ========================================================
    // NO QUESTIONS
    // ========================================================

    if (questions.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF0B1220),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0B1220),
          title: Text(
            "$fieldName Quiz",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: const Center(
          child: Text(
            "No questions found for this field.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      );
    }

    return _buildQuiz();
  }

  // ==========================================================
  // QUIZ UI
  // ==========================================================

  Widget _buildQuiz() {
    final question = questions[currentQuestion];

    final String questionText =
        question['question']?.toString() ?? '';

    final List<dynamic> options =
        question['options'] ?? [];

    final double progress =
        (currentQuestion + 1) / questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,

        title: Text(
          fieldName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            _showExitDialog();
          },
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =================================================
              // QUESTION NUMBER
              // =================================================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Question ${currentQuestion + 1}",
                    style: const TextStyle(
                      color: Color(0xFF00C2FF),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "${currentQuestion + 1} / ${questions.length}",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // =================================================
              // PROGRESS BAR
              // =================================================

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  backgroundColor: Colors.white10,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(
                    Color(0xFF00C2FF),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // =================================================
              // SUBJECT
              // =================================================

              Text(
                question['subject']?.toString() ?? '',
                style: const TextStyle(
                  color: Color(0xFF00C2FF),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              // =================================================
              // QUESTION
              // =================================================

              Text(
                questionText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 28),

              // =================================================
              // OPTIONS
              // =================================================

              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option =
                        options[index].toString();

                    final isSelected =
                        selectedAnswer == option;

                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: 13),
                      child: _optionCard(
                        option,
                        isSelected,
                      ),
                    );
                  },
                ),
              ),

              // =================================================
              // NEXT BUTTON
              // =================================================

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF00C2FF),
                    foregroundColor:
                        const Color(0xFF0B1220),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    currentQuestion ==
                            questions.length - 1
                        ? "Submit Quiz"
                        : "Next Question",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // OPTION CARD
  // ==========================================================

  Widget _optionCard(
    String option,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () => selectAnswer(option),
      borderRadius: BorderRadius.circular(15),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),

        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF00C2FF).withOpacity(0.12)
              : const Color(0xFF151F32),

          borderRadius: BorderRadius.circular(15),

          border: Border.all(
            color: isSelected
                ? const Color(0xFF00C2FF)
                : Colors.white.withOpacity(0.08),

            width: isSelected ? 2 : 1,
          ),
        ),

        child: Row(
          children: [

            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF00C2FF)
                      : Colors.white54,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF00C2FF),
                      ),
                    )
                  : null,
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xFF00C2FF)
                      : Colors.white,
                  fontSize: 15,
                  fontWeight: isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // EXIT DIALOG
  // ==========================================================

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151F32),

          title: const Text(
            "Exit Quiz?",
            style: TextStyle(
              color: Colors.white,
            ),
          ),

          content: const Text(
            "Your current quiz progress will be lost.",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                "Exit",
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


// ============================================================
// RESULT SCREEN
// ============================================================

class QuizResultScreen extends StatelessWidget {
  final String field;
  final int score;
  final int total;

  const QuizResultScreen({
    super.key,
    required this.field,
    required this.score,
    required this.total,
  });

  String get fieldName {
    switch (field) {
      case 'computer':
        return 'Computer Science';

      case 'medical':
        return 'Medical';

      case 'engineering':
        return 'Engineering';

      default:
        return field;
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentage =
        total == 0 ? 0 : ((score / total) * 100).round();

    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [

                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF00C2FF),
                  size: 90,
                ),

                const SizedBox(height: 25),

                const Text(
                  "Quiz Completed!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  fieldName,
                  style: const TextStyle(
                    color: Color(0xFF00C2FF),
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 35),

                Text(
                  "$score / $total",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "$percentage%",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF00C2FF),
                      foregroundColor:
                          const Color(0xFF0B1220),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Back to Dashboard",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}