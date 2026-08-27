import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminQuizPage extends StatefulWidget {
  const AdminQuizPage({super.key});

  @override
  State<AdminQuizPage> createState() => _AdminQuizPageState();
}

class _AdminQuizPageState extends State<AdminQuizPage> {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final TextEditingController _searchController =
      TextEditingController();

  String _searchQuery = '';
  String _selectedRole = 'All';
  String _selectedCategory = 'All';

  final List<String> roles = [
    'student',
    'graduate',
    'professional',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showMessage(String message, Color color) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  Future<void> _deleteQuestion(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Question'),
          content: const Text(
            'Are you sure you want to delete this question?',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      await _firestore
          .collection('quiz_questions')
          .doc(id)
          .delete();

      _showMessage(
        'Question deleted successfully',
        Colors.green,
      );
    } catch (e) {
      _showMessage(
        'Failed to delete question',
        Colors.red,
      );
    }
  }

  Future<void> _showQuestionForm({
    DocumentSnapshot<Map<String, dynamic>>? document,
  }) async {
    final data = document?.data();

    final questionController = TextEditingController(
      text: data?['question'] ?? '',
    );

    final categoryController = TextEditingController(
      text: data?['category'] ?? '',
    );

    final subjectController = TextEditingController(
      text: data?['subject'] ?? '',
    );

    final marksController = TextEditingController(
      text: (data?['marks'] ?? 1).toString(),
    );

    final options = List<String>.from(
      data?['options'] ?? ['', '', '', ''],
    );

    while (options.length < 4) {
      options.add('');
    }

    final optionControllers = List.generate(
      4,
      (index) => TextEditingController(
        text: options[index],
      ),
    );

    String role = data?['role'] ?? 'graduate';

    String difficulty =
        data?['difficulty'] ?? 'advanced';

    String correctAnswer =
        data?['correctAnswer'] ??
        optionControllers.first.text;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                document == null
                    ? 'Add Question'
                    : 'Edit Question',
              ),
              content: SizedBox(
                width: 550,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _field(
                        questionController,
                        'Question',
                        Icons.help_outline,
                        maxLines: 3,
                      ),

                      _field(
                        categoryController,
                        'Category',
                        Icons.category_outlined,
                      ),

                      _field(
                        subjectController,
                        'Subject',
                        Icons.book_outlined,
                      ),

                      const SizedBox(height: 6),

                      DropdownButtonFormField<String>(
                        value: role,
                        decoration: InputDecoration(
                          labelText: 'Role',
                          prefixIcon: const Icon(
                            Icons.person_outline,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        items: roles.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item[0].toUpperCase() +
                                  item.substring(1),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value == null) return;

                          setDialogState(() {
                            role = value;
                          });
                        },
                      ),

                      const SizedBox(height: 12),

                      DropdownButtonFormField<String>(
                        value: difficulty,
                        decoration: InputDecoration(
                          labelText: 'Difficulty',
                          prefixIcon: const Icon(
                            Icons.speed_outlined,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'easy',
                            child: Text('Easy'),
                          ),
                          DropdownMenuItem(
                            value: 'medium',
                            child: Text('Medium'),
                          ),
                          DropdownMenuItem(
                            value: 'advanced',
                            child: Text('Advanced'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;

                          setDialogState(() {
                            difficulty = value;
                          });
                        },
                      ),

                      const SizedBox(height: 12),

                      _field(
                        marksController,
                        'Marks',
                        Icons.star_outline,
                        keyboardType:
                            TextInputType.number,
                      ),

                      const SizedBox(height: 10),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Options',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      ...List.generate(4, (index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: TextField(
                            controller:
                                optionControllers[index],
                            onChanged: (_) {
                              setDialogState(() {});
                            },
                            decoration: InputDecoration(
                              labelText:
                                  'Option ${index + 1}',
                              prefixIcon: const Icon(
                                Icons.radio_button_off,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  12,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),

                      DropdownButtonFormField<String>(
                        value: optionControllers
                                .map((e) => e.text)
                                .contains(correctAnswer)
                            ? correctAnswer
                            : null,
                        decoration: InputDecoration(
                          labelText: 'Correct Answer',
                          prefixIcon: const Icon(
                            Icons.check_circle_outline,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        items: optionControllers
                            .map((controller) {
                          final text =
                              controller.text.trim();

                          if (text.isEmpty) {
                            return null;
                          }

                          return DropdownMenuItem<String>(
                            value: text,
                            child: Text(
                              text,
                              overflow:
                                  TextOverflow.ellipsis,
                            ),
                          );
                        })
                            .whereType<
                                DropdownMenuItem<String>>()
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;

                          setDialogState(() {
                            correctAnswer = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final question =
                        questionController.text.trim();

                    final category =
                        categoryController.text.trim();

                    final subject =
                        subjectController.text.trim();

                    final finalOptions =
                        optionControllers
                            .map(
                              (controller) =>
                                  controller.text.trim(),
                            )
                            .toList();

                    if (question.isEmpty ||
                        category.isEmpty ||
                        subject.isEmpty ||
                        finalOptions.any(
                          (option) => option.isEmpty,
                        )) {
                      _showMessage(
                        'Please fill all fields',
                        Colors.red,
                      );
                      return;
                    }

                    if (!finalOptions
                        .contains(correctAnswer)) {
                      _showMessage(
                        'Select a valid correct answer',
                        Colors.red,
                      );
                      return;
                    }

                    final marks =
                        int.tryParse(
                              marksController.text
                                  .trim(),
                            ) ??
                            1;

                    final quizData = {
                      'category': category,
                      'correctAnswer': correctAnswer,
                      'difficulty': difficulty,
                      'marks': marks,
                      'options': finalOptions,
                      'question': question,
                      'role': role,
                      'subject': subject,
                      'updatedAt':
                          FieldValue.serverTimestamp(),
                    };

                    try {
                      if (document == null) {
                        quizData['createdAt'] =
                            FieldValue.serverTimestamp();

                        await _firestore
                            .collection('quiz_questions')
                            .add(quizData);

                        _showMessage(
                          'Question added successfully',
                          Colors.green,
                        );
                      } else {
                        await _firestore
                            .collection('quiz_questions')
                            .doc(document.id)
                            .update(quizData);

                        _showMessage(
                          'Question updated successfully',
                          Colors.green,
                        );
                      }

                      if (mounted) {
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      _showMessage(
                        'Failed to save question',
                        Colors.red,
                      );
                    }
                  },
                  child: Text(
                    document == null ? 'Add Question' : 'Update',
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    questionController.dispose();
    categoryController.dispose();
    subjectController.dispose();
    marksController.dispose();

    for (final controller in optionControllers) {
      controller.dispose();
    }
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  bool _matchesSearch(Map<String, dynamic> data) {
    if (_searchQuery.isEmpty) return true;

    final values = [
      data['question'],
      data['category'],
      data['subject'],
      data['correctAnswer'],
    ];

    return values.any(
      (value) => value
          .toString()
          .toLowerCase()
          .contains(_searchQuery),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(
          'Quiz Management',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF172033),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF172033),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showQuestionForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Question'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              18,
              18,
              10,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery =
                      value.trim().toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search questions...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedRole,
                    decoration: InputDecoration(
                      labelText: 'Role',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 'All',
                        child: Text('All Roles'),
                      ),
                      ...roles.map(
                        (role) => DropdownMenuItem(
                          value: role,
                          child: Text(
                            role[0].toUpperCase() +
                                role.substring(1),
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        _selectedRole = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: StreamBuilder<
                QuerySnapshot<Map<String, dynamic>>>(
              stream: _firestore
                  .collection('quiz_questions')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading questions:\n${snapshot.error}',
                    ),
                  );
                }

                final docs = snapshot.data?.docs ?? [];

                final questions = docs.where((doc) {
                  final data = doc.data();

                  final roleMatches =
                      _selectedRole == 'All' ||
                      data['role'] == _selectedRole;

                  return roleMatches &&
                      _matchesSearch(data);
                }).toList();

                if (questions.isEmpty) {
                  return const Center(
                    child: Text('No questions found'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    18,
                    0,
                    18,
                    90,
                  ),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final doc = questions[index];
                    final data = doc.data();

                    final question =
                        data['question'] ??
                            'No question';

                    final category =
                        data['category'] ?? '';

                    final subject =
                        data['subject'] ?? '';

                    final role =
                        data['role'] ?? '';

                    final difficulty =
                        data['difficulty'] ?? '';

                    return Card(
                      margin: const EdgeInsets.only(
                        bottom: 12,
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    question.toString(),
                                    style:
                                        const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      _showQuestionForm(
                                    document: doc,
                                  ),
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      _deleteQuestion(
                                    doc.id,
                                  ),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                _chip(
                                  category.toString(),
                                  Colors.blue,
                                ),
                                _chip(
                                  subject.toString(),
                                  Colors.green,
                                ),
                                _chip(
                                  role.toString(),
                                  Colors.orange,
                                ),
                                _chip(
                                  difficulty.toString(),
                                  Colors.purple,
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Text(
                              'Correct Answer: ${data['correctAnswer'] ?? ''}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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

  Widget _chip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}