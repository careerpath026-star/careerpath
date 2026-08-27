import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GraduateQuizAttemptPage extends StatefulWidget {
  const GraduateQuizAttemptPage({super.key});

  @override
  State<GraduateQuizAttemptPage> createState() =>
      _GraduateQuizAttemptPageState();
}

class _GraduateQuizAttemptPageState
    extends State<GraduateQuizAttemptPage> {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // ==========================================================
  // STATE
  // ==========================================================

  bool _loadingCategories = true;
  bool _loadingQuestions = false;

  String? _selectedCategory;

  List<String> _categories = [];

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _questions = [];

  int _currentQuestionIndex = 0;

  final Map<int, String> _selectedAnswers = {};

  bool _quizStarted = false;
  bool _quizFinished = false;

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  // ==========================================================
  // LOAD CATEGORIES
  // ==========================================================

  Future<void> _loadCategories() async {
    try {
      final snapshot = await _firestore
          .collection('quiz_questions')
          .where(
            'role',
            isEqualTo: 'graduate',
          )
          .get();

      final Set<String> categorySet = {};

      for (final doc in snapshot.docs) {
        final data = doc.data();

        final category =
            (data['category'] ?? '').toString().trim();

        if (category.isNotEmpty) {
          categorySet.add(category);
        }
      }

      final categories = categorySet.toList();

      categories.sort();

      if (!mounted) return;

      setState(() {
        _categories = categories;
        _loadingCategories = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingCategories = false;
      });

      _showMessage(
        'Unable to load quiz categories.\n$e',
        Colors.red,
      );
    }
  }

  // ==========================================================
  // START QUIZ
  // ==========================================================

  Future<void> _startQuiz() async {
    if (_selectedCategory == null ||
        _selectedCategory!.trim().isEmpty) {
      _showMessage(
        'Please select a category first.',
        Colors.orange,
      );
      return;
    }

    setState(() {
      _loadingQuestions = true;
    });

    try {
      final snapshot = await _firestore
          .collection('quiz_questions')
          .where(
            'role',
            isEqualTo: 'graduate',
          )
          .where(
            'category',
            isEqualTo: _selectedCategory,
          )
          .get();

      final questions = snapshot.docs.toList();

      // Shuffle questions so order is not always the same.
      questions.shuffle();

      if (!mounted) return;

      if (questions.isEmpty) {
        setState(() {
          _loadingQuestions = false;
        });

        _showMessage(
          'No questions found for this category.',
          Colors.red,
        );

        return;
      }

      setState(() {
        _questions = questions;

        _currentQuestionIndex = 0;

        _selectedAnswers.clear();

        _quizStarted = true;

        _quizFinished = false;

        _loadingQuestions = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loadingQuestions = false;
      });

      _showMessage(
        'Unable to start quiz.\n$e',
        Colors.red,
      );
    }
  }

  // ==========================================================
  // SELECT ANSWER
  // ==========================================================

  void _selectAnswer(String answer) {
    if (_quizFinished) return;

    setState(() {
      _selectedAnswers[_currentQuestionIndex] = answer;
    });
  }

  // ==========================================================
  // NEXT
  // ==========================================================

  void _nextQuestion() {
    if (_currentQuestionIndex <
        _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _finishQuiz();
    }
  }

  // ==========================================================
  // PREVIOUS
  // ==========================================================

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  // ==========================================================
  // FINISH QUIZ
  // ==========================================================

  void _finishQuiz() {
    final unanswered =
        _questions.length - _selectedAnswers.length;

    if (unanswered > 0) {
      _showFinishConfirmation(unanswered);
      return;
    }

    _calculateResult();
  }

  // ==========================================================
  // FINISH CONFIRMATION
  // ==========================================================

  void _showFinishConfirmation(int unanswered) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Finish Quiz?'),
          content: Text(
            'You still have $unanswered '
            'unanswered question${unanswered == 1 ? '' : 's'}.\n\n'
            'Do you want to submit the quiz?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Continue Quiz'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _calculateResult();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // CALCULATE RESULT
  // ==========================================================

  void _calculateResult() {
    int score = 0;

    for (int i = 0; i < _questions.length; i++) {
      final data = _questions[i].data();

      final correctAnswer =
          (data['correctAnswer'] ?? '')
              .toString()
              .trim();

      final selectedAnswer =
          (_selectedAnswers[i] ?? '').trim();

      if (selectedAnswer == correctAnswer) {
        score++;
      }
    }

    setState(() {
      _quizFinished = true;
    });
  }

  // ==========================================================
  // RESTART
  // ==========================================================

  void _restartQuiz() {
    setState(() {
      _selectedCategory = null;

      _questions = [];

      _currentQuestionIndex = 0;

      _selectedAnswers.clear();

      _quizStarted = false;

      _quizFinished = false;
    });
  }

  // ==========================================================
  // MESSAGE
  // ==========================================================

  void _showMessage(
    String message,
    Color color,
  ) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  // ==========================================================
  // CATEGORY SCREEN
  // ==========================================================

  Widget _categoryScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),

          const Text(
            'Graduate Career Quiz',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172033),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Select a category to start your advanced '
            'career assessment.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(18),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(0.03),
                  blurRadius: 12,
                  offset:
                      const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose Category',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'The quiz questions will be loaded '
                  'according to your selected category.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    prefixIcon: const Icon(
                      Icons.category_outlined,
                    ),
                    filled: true,
                    fillColor:
                        const Color(0xFFF7F8FC),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color:
                            Colors.grey.shade200,
                      ),
                    ),
                    enabledBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color:
                            Colors.grey.shade200,
                      ),
                    ),
                  ),
                  items: _categories.map(
                    (category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          overflow:
                              TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),

                const SizedBox(height: 22),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed:
                        _loadingQuestions
                            ? null
                            : _startQuiz,
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF2563EB),
                      foregroundColor:
                          Colors.white,
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                    icon: _loadingQuestions
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.play_arrow,
                          ),
                    label: Text(
                      _loadingQuestions
                          ? 'Loading Quiz...'
                          : 'Start Quiz',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade700,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    'Select one category. Only graduate '
                    'questions belonging to that category '
                    'will be included in your quiz.',
                    style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // QUIZ SCREEN
  // ==========================================================

  Widget _quizScreen() {
    final question =
        _questions[_currentQuestionIndex];

    final data = question.data();

    final questionText =
        (data['question'] ?? '').toString();

    final options =
        List<String>.from(
      data['options'] ?? [],
    );

    final selectedAnswer =
        _selectedAnswers[_currentQuestionIndex];

    final progress =
        (_currentQuestionIndex + 1) /
            _questions.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // ---------------------------------------------------
          // HEADER
          // ---------------------------------------------------

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _selectedCategory ?? 'Graduate Quiz',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),
              ),

              Text(
                '${_currentQuestionIndex + 1}/${_questions.length}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor:
                  Colors.grey.shade200,
              valueColor:
                  const AlwaysStoppedAnimation(
                Color(0xFF2563EB),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ---------------------------------------------------
          // QUESTION CARD
          // ---------------------------------------------------

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(18),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(0.03),
                  blurRadius: 12,
                  offset:
                      const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${_currentQuestionIndex + 1}',
                  style: const TextStyle(
                    color: Color(0xFF2563EB),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  questionText,
                  style: const TextStyle(
                    fontSize: 19,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 25),

                ...options.asMap().entries.map(
                  (entry) {
                    final index = entry.key;
                    final option = entry.value;

                    final optionLetter =
                        String.fromCharCode(
                      65 + index,
                    );

                    final isSelected =
                        selectedAnswer == option;

                    return _optionCard(
                      optionLetter,
                      option,
                      isSelected,
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ---------------------------------------------------
          // NAVIGATION
          // ---------------------------------------------------

          Row(
            children: [
              if (_currentQuestionIndex > 0)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed:
                        _previousQuestion,
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    label:
                        const Text('Previous'),
                    style:
                        OutlinedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

              if (_currentQuestionIndex > 0)
                const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton.icon(
                  onPressed:
                      _selectedAnswers[
                              _currentQuestionIndex] ==
                          null
                      ? null
                      : _nextQuestion,
                  icon: Icon(
                    _currentQuestionIndex ==
                            _questions.length - 1
                        ? Icons.check
                        : Icons.arrow_forward,
                  ),
                  label: Text(
                    _currentQuestionIndex ==
                            _questions.length - 1
                        ? 'Submit Quiz'
                        : 'Next',
                  ),
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF2563EB),
                    foregroundColor:
                        Colors.white,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // OPTION CARD
  // ==========================================================

  Widget _optionCard(
    String letter,
    String option,
    bool selected,
  ) {
    return GestureDetector(
      onTap: () {
        _selectAnswer(option);
      },
      child: Container(
        width: double.infinity,
        margin:
            const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selected
              ? Colors.blue.shade50
              : Colors.white,
          borderRadius:
              BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xFF2563EB)
                : Colors.grey.shade200,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF2563EB)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Text(
                letter,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selected
                      ? Colors.white
                      : Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color:
                      const Color(0xFF172033),
                ),
              ),
            ),

            if (selected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF2563EB),
              ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // RESULT SCREEN
  // ==========================================================

  Widget _resultScreen() {
    int score = 0;

    for (int i = 0; i < _questions.length; i++) {
      final data = _questions[i].data();

      final correctAnswer =
          (data['correctAnswer'] ?? '')
              .toString()
              .trim();

      final selectedAnswer =
          (_selectedAnswers[i] ?? '').trim();

      if (selectedAnswer == correctAnswer) {
        score++;
      }
    }

    final total = _questions.length;

    final percentage =
        total == 0 ? 0 : (score / total) * 100;

    String message;

    if (percentage >= 80) {
      message = 'Excellent performance!';
    } else if (percentage >= 60) {
      message = 'Good performance. Keep improving!';
    } else if (percentage >= 40) {
      message = 'You have room for improvement.';
    } else {
      message = 'Keep practicing and try again.';
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset:
                    const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events_outlined,
                  size: 45,
                  color: Color(0xFF2563EB),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Quiz Completed',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172033),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _selectedCategory ?? '',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 25),

              Text(
                '$score / $total',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2563EB),
                ),
              ),

              Text(
                '${percentage.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _restartQuiz,
                  icon: const Icon(
                    Icons.restart_alt,
                  ),
                  label:
                      const Text('Try Another Category'),
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF2563EB),
                    foregroundColor:
                        Colors.white,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
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
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF6F8FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF172033),
        ),
        title: const Text(
          'Graduate Quiz',
          style: TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: _loadingCategories
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _quizFinished
                ? _resultScreen()
                : _quizStarted
                    ? _quizScreen()
                    : _categoryScreen(),
      ),
    );
  }
}