// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class StudentProfileScreen extends StatefulWidget {
//   const StudentProfileScreen({super.key});

//   @override
//   State<StudentProfileScreen> createState() => _StudentProfileScreenState();
// }

// class _StudentProfileScreenState extends State<StudentProfileScreen> {
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController _educationController;
//   late TextEditingController _workExpController;
//   late TextEditingController _phoneController;

//   // FIX: interest field is now a fixed selector (matches the values
//   // used everywhere else in the app — dashboard, quiz, recommendation
//   // engine all expect exactly 'computer' | 'medical' | 'engineering').
//   // A free-text field here would silently break all of that.
//   String _selectedInterestField = "";

//   List<String> _skills = [];
//   List<String> _interests = [];

//   final TextEditingController _skillInputController = TextEditingController();
//   final TextEditingController _interestInputController = TextEditingController();

//   bool _isLoading = true;
//   bool _isSaving = false; // separate from _isLoading so the form
//                           // doesn't vanish behind a spinner while saving
//   String? _uid;

//   final List<Map<String, String>> _fieldOptions = const [
//     {"value": "computer", "label": "Computer"},
//     {"value": "medical", "label": "Medical"},
//     {"value": "engineering", "label": "Engineering"},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _educationController = TextEditingController();
//     _workExpController = TextEditingController();
//     _phoneController = TextEditingController();
//     _getCurrentUserAndLoadData();
//   }

//   @override
//   void dispose() {
//     _educationController.dispose();
//     _workExpController.dispose();
//     _phoneController.dispose();
//     _skillInputController.dispose();
//     _interestInputController.dispose();
//     super.dispose();
//   }

//   Future<void> _getCurrentUserAndLoadData() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         _uid = user.uid;
//         await _loadUserData(_uid!);
//       } else {
//         if (mounted) {
//           setState(() => _isLoading = false);
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('No authenticated user found.')),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) setState(() => _isLoading = false);
//       debugPrint("Error loading user: $e");
//     }
//   }

//   Future<void> _loadUserData(String uid) async {
//     try {
//       DocumentSnapshot doc =
//           await FirebaseFirestore.instance.collection('users').doc(uid).get();

//       if (doc.exists && doc.data() != null) {
//         var data = doc.data() as Map<String, dynamic>;
//         if (mounted) {
//           setState(() {
//             _educationController.text =
//                 data['education'] ?? data['educationLevel'] ?? '';
//             _workExpController.text =
//                 data['workExperience'] ?? data['work_experience'] ?? '';
//             _phoneController.text = data['phone'] ?? data['phoneNumber'] ?? '';

//             final String rawInterest = (data['interest_field'] ??
//                     data['interestField'] ??
//                     '')
//                 .toString()
//                 .trim()
//                 .toLowerCase();

//             // Only accept it if it's one of the 3 valid values — guards
//             // against any legacy/free-text value that snuck in before.
//             _selectedInterestField = _fieldOptions
//                     .any((f) => f['value'] == rawInterest)
//                 ? rawInterest
//                 : '';

//             _skills = List<String>.from(data['skills'] ?? []);
//             _interests = List<String>.from(data['interests'] ?? []);
//             _isLoading = false;
//           });
//         }
//       } else {
//         if (mounted) setState(() => _isLoading = false);
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => _isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error loading profile: $e')),
//         );
//       }
//     }
//   }

//   Future<void> _updateProfile() async {
//     if (!_formKey.currentState!.validate() || _uid == null) return;

//     setState(() => _isSaving = true);

//     try {
//       await FirebaseFirestore.instance.collection('users').doc(_uid).set({
//         'education': _educationController.text.trim(),
//         'educationLevel': _educationController.text.trim(),
//         if (_selectedInterestField.isNotEmpty)
//           'interest_field': _selectedInterestField,
//         'workExperience': _workExpController.text.trim(),
//         'phone': _phoneController.text.trim(),
//         'skills': _skills,
//         'interests': _interests,
//         'updatedAt': FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Profile updated successfully!')),
//         );
//         // Pass `true` back so the dashboard knows to refresh.
//         Navigator.pop(context, true);
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to update profile: $e')),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _isSaving = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0B1220),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0B1220),
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text(
//           'Student Profile Setup',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator(color: Color(0xFF00C2FF)),
//             )
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Complete your profile to personalize your Dashboard, Quiz, and Career Recommendations.',
//                       style: TextStyle(fontSize: 13, color: Colors.white60),
//                     ),
//                     const SizedBox(height: 20),

//                     _buildTextField(
//                       controller: _educationController,
//                       label:
//                           'Education Level (e.g., Undergraduate, Intermediate)',
//                       validator: (val) => val == null || val.isEmpty
//                           ? 'Please enter education'
//                           : null,
//                     ),
//                     const SizedBox(height: 16),

//                     _buildTextField(
//                       controller: _phoneController,
//                       label: 'Phone Number (optional)',
//                       keyboardType: TextInputType.phone,
//                     ),
//                     const SizedBox(height: 20),

//                     // -------- INTEREST FIELD (fixed selector, FIX) --------
//                     const Text(
//                       'Career Field',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     const Text(
//                       'This drives your quiz and career recommendations.',
//                       style: TextStyle(color: Colors.white38, fontSize: 12),
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       children: _fieldOptions.map((option) {
//                         final bool selected =
//                             _selectedInterestField == option['value'];
//                         return Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 8),
//                             child: InkWell(
//                               onTap: () => setState(
//                                 () => _selectedInterestField = option['value']!,
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(vertical: 12),
//                                 decoration: BoxDecoration(
//                                   color: selected
//                                       ? const Color(0xFF00C2FF).withOpacity(0.15)
//                                       : const Color(0xFF151F32),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: selected
//                                         ? const Color(0xFF00C2FF)
//                                         : Colors.white12,
//                                     width: selected ? 1.5 : 1,
//                                   ),
//                                 ),
//                                 child: Text(
//                                   option['label']!,
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: selected
//                                         ? const Color(0xFF00C2FF)
//                                         : Colors.white70,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                     const SizedBox(height: 20),

//                     _buildTextField(
//                       controller: _workExpController,
//                       label: 'Work Experience / Internships (optional)',
//                     ),
//                     const SizedBox(height: 24),

//                     // -------- SKILLS --------
//                     const Text(
//                       'Skills',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: _buildTextField(
//                             controller: _skillInputController,
//                             label: 'Add a skill (e.g., Flutter, Python)',
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         IconButton.filled(
//                           style: IconButton.styleFrom(
//                             backgroundColor: const Color(0xFF00C2FF),
//                             foregroundColor: const Color(0xFF0B1220),
//                             padding: const EdgeInsets.all(16),
//                           ),
//                           onPressed: () {
//                             final text = _skillInputController.text.trim();
//                             if (text.isNotEmpty && !_skills.contains(text)) {
//                               setState(() {
//                                 _skills.add(text);
//                                 _skillInputController.clear();
//                               });
//                             }
//                           },
//                           icon: const Icon(Icons.add),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Wrap(
//                       spacing: 8.0,
//                       runSpacing: 8.0,
//                       children: _skills
//                           .map(
//                             (skill) => Chip(
//                               backgroundColor: const Color(0xFF151F32),
//                               labelStyle: const TextStyle(color: Colors.white),
//                               deleteIconColor: Colors.white70,
//                               label: Text(skill),
//                               onDeleted: () =>
//                                   setState(() => _skills.remove(skill)),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                     const SizedBox(height: 24),

//                     // -------- INTERESTS --------
//                     const Text(
//                       'Specific Interests',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: _buildTextField(
//                             controller: _interestInputController,
//                             label: 'Add an interest (e.g., AI, App Dev)',
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         IconButton.filled(
//                           style: IconButton.styleFrom(
//                             backgroundColor: const Color(0xFF00C2FF),
//                             foregroundColor: const Color(0xFF0B1220),
//                             padding: const EdgeInsets.all(16),
//                           ),
//                           onPressed: () {
//                             final text = _interestInputController.text.trim();
//                             if (text.isNotEmpty && !_interests.contains(text)) {
//                               setState(() {
//                                 _interests.add(text);
//                                 _interestInputController.clear();
//                               });
//                             }
//                           },
//                           icon: const Icon(Icons.add),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Wrap(
//                       spacing: 8.0,
//                       runSpacing: 8.0,
//                       children: _interests
//                           .map(
//                             (interest) => Chip(
//                               backgroundColor: const Color(0xFF151F32),
//                               labelStyle: const TextStyle(color: Colors.white),
//                               deleteIconColor: Colors.white70,
//                               label: Text(interest),
//                               onDeleted: () =>
//                                   setState(() => _interests.remove(interest)),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                     const SizedBox(height: 32),

//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF00C2FF),
//                           disabledBackgroundColor: Colors.white12,
//                           foregroundColor: const Color(0xFF0B1220),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         onPressed: _isSaving ? null : _updateProfile,
//                         child: _isSaving
//                             ? const SizedBox(
//                                 height: 22,
//                                 width: 22,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2.5,
//                                   color: Color(0xFF0B1220),
//                                 ),
//                               )
//                             : const Text(
//                                 'Save Changes',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     TextInputType keyboardType = TextInputType.text,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       style: const TextStyle(color: Colors.white),
//       validator: validator,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.white60),
//         filled: true,
//         fillColor: const Color(0xFF151F32),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.white12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF00C2FF)),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.redAccent),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.redAccent),
//         ),
//       ),
//     );
//   }
// }




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _educationController;
  late TextEditingController _workExpController;
  late TextEditingController _phoneController;

  // FIX: interest field is now a fixed selector (matches the values
  // used everywhere else in the app — dashboard, quiz, recommendation
  // engine all expect exactly 'computer' | 'medical' | 'engineering').
  // A free-text field here would silently break all of that.
  String _selectedInterestField = "";

  List<String> _skills = [];
  List<String> _interests = [];

  final TextEditingController _skillInputController = TextEditingController();
  final TextEditingController _interestInputController = TextEditingController();

  bool _isLoading = true;
  bool _isSaving = false; // separate from _isLoading so the form
                          // doesn't vanish behind a spinner while saving
  String? _uid;

  final List<Map<String, String>> _fieldOptions = const [
    {"value": "computer", "label": "Computer"},
    {"value": "medical", "label": "Medical"},
    {"value": "engineering", "label": "Engineering"},
  ];

  @override
  void initState() {
    super.initState();
    _educationController = TextEditingController();
    _workExpController = TextEditingController();
    _phoneController = TextEditingController();
    _getCurrentUserAndLoadData();
  }

  @override
  void dispose() {
    _educationController.dispose();
    _workExpController.dispose();
    _phoneController.dispose();
    _skillInputController.dispose();
    _interestInputController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentUserAndLoadData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        _uid = user.uid;
        await _loadUserData(_uid!);
      } else {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No authenticated user found.')),
          );
        }
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
      debugPrint("Error loading user: $e");
    }
  }

  Future<void> _loadUserData(String uid) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (doc.exists && doc.data() != null) {
        var data = doc.data() as Map<String, dynamic>;
        if (mounted) {
          setState(() {
            _educationController.text =
                data['education'] ?? data['educationLevel'] ?? '';
            _workExpController.text =
                data['workExperience'] ?? data['work_experience'] ?? '';
            _phoneController.text = data['phone'] ?? data['phoneNumber'] ?? '';

            final String rawInterest = (data['interest_field'] ??
                    data['interestField'] ??
                    '')
                .toString()
                .trim()
                .toLowerCase();

            // Only accept it if it's one of the 3 valid values — guards
            // against any legacy/free-text value that snuck in before.
            _selectedInterestField = _fieldOptions
                    .any((f) => f['value'] == rawInterest)
                ? rawInterest
                : '';

            _skills = List<String>.from(data['skills'] ?? []);
            _interests = List<String>.from(data['interests'] ?? []);
            _isLoading = false;
          });
        }
      } else {
        if (mounted) setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading profile: $e')),
        );
      }
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate() || _uid == null) return;

    setState(() => _isSaving = true);

    try {
      await FirebaseFirestore.instance.collection('users').doc(_uid).set({
        'education': _educationController.text.trim(),
        'educationLevel': _educationController.text.trim(),
        if (_selectedInterestField.isNotEmpty)
          'interest_field': _selectedInterestField,
        'workExperience': _workExpController.text.trim(),
        'phone': _phoneController.text.trim(),
        'skills': _skills,
        'interests': _interests,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        // Pass `true` back so the dashboard knows to refresh.
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Student Profile Setup',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF00C2FF)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Complete your profile to personalize your Dashboard, Quiz, and Career Recommendations.',
                      style: TextStyle(fontSize: 13, color: Colors.white60),
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      controller: _educationController,
                      label:
                          'Education Level (e.g., Undergraduate, Intermediate)',
                      validator: (val) => val == null || val.isEmpty
                          ? 'Please enter education'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: _phoneController,
                      label: 'Phone Number (optional)',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),

                    // -------- INTEREST FIELD (fixed selector, FIX) --------
                    const Text(
                      'Career Field',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'This drives your quiz and career recommendations.',
                      style: TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: _fieldOptions.map((option) {
                        final bool selected =
                            _selectedInterestField == option['value'];
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () => setState(
                                () => _selectedInterestField = option['value']!,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? const Color(0xFF00C2FF).withOpacity(0.15)
                                      : const Color(0xFF151F32),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: selected
                                        ? const Color(0xFF00C2FF)
                                        : Colors.white12,
                                    width: selected ? 1.5 : 1,
                                  ),
                                ),
                                child: Text(
                                  option['label']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: selected
                                        ? const Color(0xFF00C2FF)
                                        : Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      controller: _workExpController,
                      label: 'Work Experience / Internships (optional)',
                    ),
                    const SizedBox(height: 24),

                    // -------- SKILLS --------
                    const Text(
                      'Skills',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _skillInputController,
                            label: 'Add a skill (e.g., Flutter, Python)',
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filled(
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFF00C2FF),
                            foregroundColor: const Color(0xFF0B1220),
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: () {
                            final text = _skillInputController.text.trim();
                            if (text.isNotEmpty && !_skills.contains(text)) {
                              setState(() {
                                _skills.add(text);
                                _skillInputController.clear();
                              });
                            }
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _skills
                          .map(
                            (skill) => Chip(
                              backgroundColor: const Color(0xFF151F32),
                              labelStyle: const TextStyle(color: Colors.white),
                              deleteIconColor: Colors.white70,
                              label: Text(skill),
                              onDeleted: () =>
                                  setState(() => _skills.remove(skill)),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 24),

                    // -------- INTERESTS --------
                    const Text(
                      'Specific Interests',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _interestInputController,
                            label: 'Add an interest (e.g., AI, App Dev)',
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filled(
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFF00C2FF),
                            foregroundColor: const Color(0xFF0B1220),
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: () {
                            final text = _interestInputController.text.trim();
                            if (text.isNotEmpty && !_interests.contains(text)) {
                              setState(() {
                                _interests.add(text);
                                _interestInputController.clear();
                              });
                            }
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _interests
                          .map(
                            (interest) => Chip(
                              backgroundColor: const Color(0xFF151F32),
                              labelStyle: const TextStyle(color: Colors.white),
                              deleteIconColor: Colors.white70,
                              label: Text(interest),
                              onDeleted: () =>
                                  setState(() => _interests.remove(interest)),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00C2FF),
                          disabledBackgroundColor: Colors.white12,
                          foregroundColor: const Color(0xFF0B1220),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _isSaving ? null : _updateProfile,
                        child: _isSaving
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Color(0xFF0B1220),
                                ),
                              )
                            : const Text(
                                'Save Changes',
                                style: TextStyle(
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
        filled: true,
        fillColor: const Color(0xFF151F32),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00C2FF)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}