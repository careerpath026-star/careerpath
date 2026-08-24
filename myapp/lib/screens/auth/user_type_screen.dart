import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../auth/verify_email_screen.dart';

class UserTypeScreen extends StatefulWidget {
  final String uid;
  final String name;
  final String email;

  const UserTypeScreen({
    super.key,
    required this.uid,
    required this.name,
    required this.email,
  });

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  String? selectedType;
  bool isLoading = false;

  final List<Map<String, dynamic>> userTypes = [
    {
      'title': 'Student',
      'description': 'I am currently studying.',
      'icon': Icons.school_outlined,
    },
    {
      'title': 'Graduate',
      'description': 'I have completed my studies.',
      'icon': Icons.workspace_premium_outlined,
    },
    {
      'title': 'Professional',
      'description': 'I am currently working.',
      'icon': Icons.work_outline,
    },
  ];

  Future<void> saveUserType() async {
    if (selectedType == null) {
      showMessage('Please select your user type.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Direct Firestore database operation
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update({
        'userType': selectedType,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VerifyEmailScreen(
            email: widget.email,
          ),
        ),
      );
    } catch (e) {
      showMessage('Unable to save user type.');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Path'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What describes you?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'We will personalize your career experience.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: ListView.builder(
                itemCount: userTypes.length,
                itemBuilder: (context, index) {
                  final type = userTypes[index];
                  final isSelected = selectedType == type['title'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedType = type['title'];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.08)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : const Color(0xFFE4E7EC),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(
                                alpha: 0.10,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              type['icon'],
                              color: AppColors.primary,
                              size: 28,
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  type['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  type['description'],
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : saveUserType,
                child: isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}