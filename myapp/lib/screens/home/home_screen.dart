

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:myapp/screens/home/student_drawer.dart';

// import '../../core/constants/app_colors.dart';
// import '../auth/login_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   bool isLoading = true;
//   bool isSavingProfile = false;

//   String userName = "Student";
//   String userType = "student";
//   String interestField = "";
//   String phoneNumber = "";
//   String educationLevel = "";

//   bool _modalAlreadyShown = false;

//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       checkStudentProfile();
//     });
//   }

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }

//   // ==========================================================
//   // CHECK STUDENT PROFILE
//   // ==========================================================

//   Future<void> checkStudentProfile() async {
//     try {
//       final User? user = _auth.currentUser;

//       if (user == null) {
//         if (!mounted) return;
//         setState(() {
//           isLoading = false;
//         });
//         return;
//       }

//       final DocumentReference userRef =
//           _firestore.collection("users").doc(user.uid);

//       final DocumentSnapshot snapshot = await userRef.get();

//       // ========================================================
//       // DOCUMENT DOES NOT EXIST
//       // ========================================================

//       if (!snapshot.exists) {
//         debugPrint("User document does not exist. Creating basic record...");

//         await userRef.set(
//           {
//             "name": user.displayName ?? "Student",
//             "email": user.email ?? "",
//             "role": "student",
//             "userType": "student",
//             "createdAt": FieldValue.serverTimestamp(),
//           },
//           SetOptions(merge: true),
//         );

//         if (!mounted) return;

//         setState(() {
//           userName = user.displayName ?? "Student";
//           userType = "student";
//           interestField = "";
//           phoneNumber = "";
//           educationLevel = "";
//           isLoading = false;
//         });

//         _showCompleteProfileAfterBuild();
//         return;
//       }

//       // ========================================================
//       // DOCUMENT EXISTS
//       // ========================================================

//       final dynamic rawData = snapshot.data();
//       final Map<String, dynamic> data =
//           rawData is Map<String, dynamic> ? rawData : {};

//       String name = "Student";
//       final String firestoreName = data["name"]?.toString().trim() ?? "";
//       final String firestoreFullName = data["fullName"]?.toString().trim() ?? "";

//       if (firestoreName.isNotEmpty) {
//         name = firestoreName;
//       } else if (firestoreFullName.isNotEmpty) {
//         name = firestoreFullName;
//       } else if ((user.displayName ?? "").trim().isNotEmpty) {
//         name = user.displayName!.trim();
//       }

//       String role = "student";
//       final String firestoreRole =
//           data["role"]?.toString().trim().toLowerCase() ?? "";
//       final String firestoreUserType =
//           data["userType"]?.toString().trim().toLowerCase() ?? "";

//       if (firestoreRole.isNotEmpty) {
//         role = firestoreRole;
//       } else if (firestoreUserType.isNotEmpty) {
//         role = firestoreUserType;
//       }

//       final String field =
//           data["interest_field"]?.toString().trim().toLowerCase() ?? "";
//       final String phone = data["phone"]?.toString().trim() ?? "";
//       final String eduLevel =
//           data["educationLevel"]?.toString().trim().toLowerCase() ?? "";

//       if (!mounted) return;

//       setState(() {
//         userName = name;
//         userType = role;
//         interestField = field;
//         phoneNumber = phone;
//         educationLevel = eduLevel;
//         isLoading = false;
//       });

//       // Show profile setup modal if profile details (interest, phone, or education) are missing/incomplete
//       if (role == "student" &&
//           (field.isEmpty || phone.isEmpty || eduLevel.isEmpty)) {
//         debugPrint("Student profile incomplete. Showing setup modal.");
//         _showCompleteProfileAfterBuild();
//       } else {
//         debugPrint("Student profile is fully complete.");
//       }
//     } catch (e, stackTrace) {
//       debugPrint("Student profile error: $e");
//       debugPrint(stackTrace.toString());

//       if (!mounted) return;

//       setState(() {
//         isLoading = false;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Unable to load your profile."),
//         ),
//       );
//     }
//   }

//   // ==========================================================
//   // SHOW MODAL AFTER BUILD
//   // ==========================================================

//   void _showCompleteProfileAfterBuild() {
//     if (_modalAlreadyShown) {
//       return;
//     }

//     _modalAlreadyShown = true;

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (!mounted) return;
//       _showProfileSetupModal();
//     });
//   }

//   // ==========================================================
//   // PROFILE SETUP MODAL (Multi-field: Name, Phone, Education, Interest)
//   // ==========================================================

//   Future<void> _showProfileSetupModal() async {
//     String tempFullName = userName != "Student" ? userName : "";
//     String tempPhone = phoneNumber;
//     String tempEducation = educationLevel;
//     String tempInterest = interestField;

//     _fullNameController.text = tempFullName;
//     _phoneController.text = tempPhone;

//     await showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (dialogContext) {
//         return StatefulBuilder(
//           builder: (modalContext, setModalState) {
//             return PopScope(
//               canPop: false,
//               child: AlertDialog(
//                 backgroundColor: const Color(0xFF151F32),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(22),
//                 ),
//                 titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
//                 contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 10),
//                 actionsPadding: const EdgeInsets.fromLTRB(20, 5, 20, 18),
//                 title: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 50,
//                       width: 50,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF00C2FF).withOpacity(0.12),
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       child: const Icon(
//                         Icons.person_add_outlined,
//                         color: Color(0xFF00C2FF),
//                         size: 27,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     const Text(
//                       "Complete Your Profile",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 7),
//                     const Text(
//                       "Please provide your details right after logging in to personalize your dashboard.",
//                       style: TextStyle(
//                         color: Colors.white60,
//                         fontSize: 13,
//                         height: 1.4,
//                       ),
//                     ),
//                   ],
//                 ),
//                 content: SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.85,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 10),
//                         // Full Name Input
//                         TextField(
//                           controller: _fullNameController,
//                           style: const TextStyle(color: Colors.white),
//                           onChanged: (val) => tempFullName = val,
//                           decoration: InputDecoration(
//                             labelText: "Full Name",
//                             labelStyle: const TextStyle(color: Colors.white60),
//                             prefixIcon: const Icon(Icons.person_outline,
//                                 color: Color(0xFF00C2FF)),
//                             filled: true,
//                             fillColor: const Color(0xFF0B1220),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: const BorderSide(color: Colors.white12),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: const BorderSide(color: Colors.white12),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide:
//                                   const BorderSide(color: Color(0xFF00C2FF)),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 14),
//                         // Phone Number Input
//                         TextField(
//                           controller: _phoneController,
//                           keyboardType: TextInputType.phone,
//                           style: const TextStyle(color: Colors.white),
//                           onChanged: (val) => tempPhone = val,
//                           decoration: InputDecoration(
//                             labelText: "Phone Number",
//                             labelStyle: const TextStyle(color: Colors.white60),
//                             prefixIcon: const Icon(Icons.phone_outlined,
//                                 color: Color(0xFF00C2FF)),
//                             filled: true,
//                             fillColor: const Color(0xFF0B1220),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: const BorderSide(color: Colors.white12),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: const BorderSide(color: Colors.white12),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide:
//                                   const BorderSide(color: Color(0xFF00C2FF)),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         const Text(
//                           "Education Level",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             _buildChoiceChip(
//                               label: "Matric / O-Level",
//                               selected: tempEducation == "matric",
//                               onSelected: (selected) {
//                                 setModalState(() => tempEducation = "matric");
//                               },
//                             ),
//                             const SizedBox(width: 8),
//                             _buildChoiceChip(
//                               label: "Intermediate / A-Level",
//                               selected: tempEducation == "intermediate",
//                               onSelected: (selected) {
//                                 setModalState(
//                                     () => tempEducation = "intermediate");
//                               },
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             _buildChoiceChip(
//                               label: "Undergraduate",
//                               selected: tempEducation == "undergraduate",
//                               onSelected: (selected) {
//                                 setModalState(
//                                     () => tempEducation = "undergraduate");
//                               },
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         const Text(
//                           "Choose Career Field",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         _fieldOption(
//                           title: "Computer",
//                           subtitle: "Computer Science & IT careers",
//                           icon: Icons.computer_outlined,
//                           value: "computer",
//                           selectedField: tempInterest,
//                           onSelect: () {
//                             setModalState(() => tempInterest = "computer");
//                           },
//                         ),
//                         const SizedBox(height: 8),
//                         _fieldOption(
//                           title: "Medical",
//                           subtitle: "Medicine & healthcare careers",
//                           icon: Icons.medical_services_outlined,
//                           value: "medical",
//                           selectedField: tempInterest,
//                           onSelect: () {
//                             setModalState(() => tempInterest = "medical");
//                           },
//                         ),
//                         const SizedBox(height: 8),
//                         _fieldOption(
//                           title: "Engineering",
//                           subtitle: "Engineering & technical careers",
//                           icon: Icons.engineering_outlined,
//                           value: "engineering",
//                           selectedField: tempInterest,
//                           onSelect: () {
//                             setModalState(() => tempInterest = "engineering");
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 actions: [
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: tempFullName.trim().isEmpty ||
//                               tempPhone.trim().isEmpty ||
//                               tempEducation.isEmpty ||
//                               tempInterest.isEmpty ||
//                               isSavingProfile
//                           ? null
//                           : () async {
//                               setModalState(() {
//                                 isSavingProfile = true;
//                               });

//                               final bool success = await _saveStudentProfileData(
//                                 fullName: tempFullName.trim(),
//                                 phone: tempPhone.trim(),
//                                 education: tempEducation,
//                                 field: tempInterest,
//                               );

//                               if (!mounted) return;

//                               if (success) {
//                                 Navigator.of(dialogContext).pop();
//                               } else {
//                                 setModalState(() {
//                                   isSavingProfile = false;
//                                 });
//                               }
//                             },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF00C2FF),
//                         disabledBackgroundColor: Colors.white12,
//                         foregroundColor: const Color(0xFF0B1220),
//                         disabledForegroundColor: Colors.white30,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: isSavingProfile
//                           ? const SizedBox(
//                               height: 22,
//                               width: 22,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2.5,
//                                 color: Color(0xFF0B1220),
//                               ),
//                             )
//                           : const Text(
//                               "Save & Continue",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );

//     if (mounted) {
//       setState(() {
//         isSavingProfile = false;
//       });
//     }
//   }

//   Widget _buildChoiceChip({
//     required String label,
//     required bool selected,
//     required ValueChanged<bool> onSelected,
//   }) {
//     return ChoiceChip(
//       label: Text(label),
//       selected: selected,
//       onSelected: onSelected,
//       selectedColor: const Color(0xFF00C2FF).withOpacity(0.2),
//       backgroundColor: const Color(0xFF0B1220),
//       labelStyle: TextStyle(
//         color: selected ? const Color(0xFF00C2FF) : Colors.white70,
//         fontSize: 12,
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(
//           color: selected ? const Color(0xFF00C2FF) : Colors.white24,
//         ),
//       ),
//     );
//   }

//   // ==========================================================
//   // FIELD OPTION
//   // ==========================================================

//   Widget _fieldOption({
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required String value,
//     required String selectedField,
//     required VoidCallback onSelect,
//   }) {
//     final bool selected = selectedField == value;

//     return InkWell(
//       onTap: onSelect,
//       borderRadius: BorderRadius.circular(15),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 180),
//         width: double.infinity,
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: selected
//               ? const Color(0xFF00C2FF).withOpacity(0.12)
//               : const Color(0xFF0B1220),
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(
//             color: selected ? const Color(0xFF00C2FF) : Colors.white12,
//             width: selected ? 1.5 : 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                 color: selected
//                     ? const Color(0xFF00C2FF).withOpacity(0.15)
//                     : Colors.white10,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(
//                 icon,
//                 color: selected ? const Color(0xFF00C2FF) : Colors.white70,
//                 size: 20,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: selected ? const Color(0xFF00C2FF) : Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     subtitle,
//                     style: const TextStyle(
//                       color: Colors.white54,
//                       fontSize: 10,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               selected ? Icons.check_circle : Icons.radio_button_unchecked,
//               color: selected ? const Color(0xFF00C2FF) : Colors.white24,
//               size: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ==========================================================
//   // SAVE STUDENT PROFILE DATA
//   // ==========================================================

//   Future<bool> _saveStudentProfileData({
//     required String fullName,
//     required String phone,
//     required String education,
//     required String field,
//   }) async {
//     try {
//       final User? user = _auth.currentUser;
//       if (user == null) return false;

//       final String normalizedField = field.trim().toLowerCase();

//       await _firestore.collection("users").doc(user.uid).set(
//         {
//           "name": fullName,
//           "fullName": fullName,
//           "phone": phone,
//           "educationLevel": education,
//           "interest_field": normalizedField,
//         },
//         SetOptions(merge: true),
//       );

//       debugPrint("Student profile saved successfully.");

//       if (!mounted) return true;

//       setState(() {
//         userName = fullName;
//         phoneNumber = phone;
//         educationLevel = education;
//         interestField = normalizedField;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Profile completed successfully!"),
//         ),
//       );

//       return true;
//     } catch (e) {
//       debugPrint("Profile save error: $e");

//       if (!mounted) return false;

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Failed to save profile. Please try again."),
//         ),
//       );

//       return false;
//     }
//   }

//   // ==========================================================
//   // FORMAT HELPERS
//   // ==========================================================

//   String _formatField(String field) {
//     switch (field.toLowerCase()) {
//       case "computer":
//         return "Computer";
//       case "medical":
//         return "Medical";
//       case "engineering":
//         return "Engineering";
//       default:
//         return field;
//     }
//   }

//   // ==========================================================
//   // LOGOUT
//   // ==========================================================

//   Future<void> logout(BuildContext context) async {
//     await _auth.signOut();

//     if (!context.mounted) return;

//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//         builder: (_) => const LoginScreen(),
//       ),
//       (route) => false,
//     );
//   }

//   // ==========================================================
//   // BUILD
//   // ==========================================================

//   @override
//   Widget build(BuildContext context) {
//     final User? user = _auth.currentUser;

//     return Scaffold(
//       backgroundColor: const Color(0xFF0B1220),
//       drawer: const StudentDrawer(),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0B1220),
//         elevation: 0,
//         title: const Text(
//           "Student Dashboard",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//         actions: [
//           IconButton(
//             onPressed: () => logout(context),
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(
//                 color: Color(0xFF00C2FF),
//               ),
//             )
//           : RefreshIndicator(
//               onRefresh: checkStudentProfile,
//               child: SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // ==================================================
//                     // WELCOME CARD
//                     // ==================================================
//                     Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(22),
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [
//                             Color(0xFF3654E0),
//                             Color(0xFF6278E8),
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 height: 52,
//                                 width: 52,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.18),
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                                 child: const Icon(
//                                   Icons.person_rounded,
//                                   color: Colors.white,
//                                   size: 30,
//                                 ),
//                               ),
//                               const Spacer(),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 12,
//                                   vertical: 7,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.15),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Text(
//                                   userType.toUpperCase(),
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 11,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 18),
//                           Text(
//                             "Welcome, $userName 👋",
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 7),
//                           Text(
//                             user?.email ?? "",
//                             style: const TextStyle(
//                               color: Colors.white70,
//                               fontSize: 14,
//                             ),
//                           ),
//                           if (interestField.isNotEmpty) ...[
//                             const SizedBox(height: 14),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 10,
//                                 vertical: 5,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.black26,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 "Interest: ${_formatField(interestField)}",
//                                 style: const TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/home/notifications_screen.dart';

import 'package:myapp/screens/home/student_drawer.dart';
import 'package:myapp/screens/home/career_bank_screen.dart';
import 'package:myapp/screens/home/career_quiz_screen.dart';

import '../../core/constants/app_colors.dart';
import '../auth/login_screen.dart';

// ==============================================================
// NOTE ON FILE PATHS
//
// Adjust the two imports above (career_bank_screen.dart,
// career_quiz_screen.dart) if your actual file names/paths differ.
// They should point at CareerBankScreen and CareerQuizScreen.
// ==============================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = true;
  bool isSavingProfile = false;

  String userName = "Student";
  String userType = "student";
  String interestField = "";
  String phoneNumber = "";
  String educationLevel = "";

  // --------------------------------------------------------
  // Dynamic dashboard data (loaded separately from the profile
  // check so a slow query here never blocks the profile modal).
  // --------------------------------------------------------
  bool extrasLoading = true;
  Map<String, dynamic>? latestQuizResult;
  List<Map<String, dynamic>> trendingCareers = [];
  List<Map<String, dynamic>> recentBookmarks = [];
  List<Map<String, dynamic>> recentQuizHistory = [];

  bool _modalAlreadyShown = false;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final PageController _bannerController = PageController();
  int _bannerIndex = 0;
  Timer? _bannerTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkStudentProfile();
      _loadDashboardExtras();
    });

    // Auto-scroll the banner carousel every 4 seconds.
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted || !_bannerController.hasClients) return;

      final int nextPage = (_bannerIndex + 1) % _banners.length;

      _bannerController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _bannerController.dispose();
    _bannerTimer?.cancel();
    super.dispose();
  }

  // ==========================================================
  // CHECK STUDENT PROFILE
  // ==========================================================

  Future<void> checkStudentProfile() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
        return;
      }

      final DocumentReference userRef =
          _firestore.collection("users").doc(user.uid);

      final DocumentSnapshot snapshot = await userRef.get();

      // ========================================================
      // DOCUMENT DOES NOT EXIST
      // ========================================================

      if (!snapshot.exists) {
        debugPrint("User document does not exist. Creating basic record...");

        await userRef.set(
          {
            "name": user.displayName ?? "Student",
            "email": user.email ?? "",
            "role": "student",
            "userType": "student",
            "createdAt": FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        );

        if (!mounted) return;

        setState(() {
          userName = user.displayName ?? "Student";
          userType = "student";
          interestField = "";
          phoneNumber = "";
          educationLevel = "";
          isLoading = false;
        });

        _showCompleteProfileAfterBuild();
        return;
      }

      // ========================================================
      // DOCUMENT EXISTS
      // ========================================================

      final dynamic rawData = snapshot.data();
      final Map<String, dynamic> data =
          rawData is Map<String, dynamic> ? rawData : {};

      String name = "Student";
      final String firestoreName = data["name"]?.toString().trim() ?? "";
      final String firestoreFullName =
          data["fullName"]?.toString().trim() ?? "";

      if (firestoreName.isNotEmpty) {
        name = firestoreName;
      } else if (firestoreFullName.isNotEmpty) {
        name = firestoreFullName;
      } else if ((user.displayName ?? "").trim().isNotEmpty) {
        name = user.displayName!.trim();
      }

      String role = "student";
      final String firestoreRole =
          data["role"]?.toString().trim().toLowerCase() ?? "";
      final String firestoreUserType =
          data["userType"]?.toString().trim().toLowerCase() ?? "";

      if (firestoreRole.isNotEmpty) {
        role = firestoreRole;
      } else if (firestoreUserType.isNotEmpty) {
        role = firestoreUserType;
      }

      final String field =
          data["interest_field"]?.toString().trim().toLowerCase() ?? "";
      final String phone = data["phone"]?.toString().trim() ?? "";
      final String eduLevel =
          data["educationLevel"]?.toString().trim().toLowerCase() ?? "";

      final Map<String, dynamic>? quizResult =
          data["latestQuizResult"] is Map
              ? Map<String, dynamic>.from(data["latestQuizResult"] as Map)
              : null;

      if (!mounted) return;

      setState(() {
        userName = name;
        userType = role;
        interestField = field;
        phoneNumber = phone;
        educationLevel = eduLevel;
        latestQuizResult = quizResult;
        isLoading = false;
      });

      // Show profile setup modal if profile details are missing/incomplete
      if (role == "student" &&
          (field.isEmpty || phone.isEmpty || eduLevel.isEmpty)) {
        debugPrint("Student profile incomplete. Showing setup modal.");
        _showCompleteProfileAfterBuild();
      } else {
        debugPrint("Student profile is fully complete.");
      }
    } catch (e, stackTrace) {
      debugPrint("Student profile error: $e");
      debugPrint(stackTrace.toString());

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Unable to load your profile."),
        ),
      );
    }
  }

  // ==========================================================
  // LOAD DASHBOARD EXTRAS
  //
  // Trending Careers (careerBank), recent Bookmarks, and recent
  // Quiz History — run in parallel, independent of the profile
  // check above so neither blocks the other.
  // ==========================================================

  Future<void> _loadDashboardExtras() async {
    final User? user = _auth.currentUser;

    if (user == null) {
      if (mounted) setState(() => extrasLoading = false);
      return;
    }

    try {
      final results = await Future.wait([
        _firestore.collection('careerBank').limit(6).get(),
        _firestore
            .collection('users')
            .doc(user.uid)
            .collection('bookmarks')
            .orderBy('timestamp', descending: true)
            .limit(4)
            .get(),
        _firestore
            .collection('users')
            .doc(user.uid)
            .collection('quiz_history')
            .orderBy('takenAt', descending: true)
            .limit(3)
            .get(),
      ]);

      final careerDocs = results[0].docs;
      final bookmarkDocs = results[1].docs;
      final historyDocs = results[2].docs;

      if (!mounted) return;

      setState(() {
        trendingCareers = careerDocs.map((d) => d.data()).toList();

        recentBookmarks =
            bookmarkDocs.map((d) => {'id': d.id, ...d.data()}).toList();

        recentQuizHistory = historyDocs.map((d) => d.data()).toList();

        extrasLoading = false;
      });
    } catch (e) {
      debugPrint("Dashboard extras load error: $e");

      if (!mounted) return;

      setState(() {
        extrasLoading = false;
      });
    }
  }

  Future<void> _refreshEverything() async {
    await Future.wait([
      checkStudentProfile(),
      _loadDashboardExtras(),
    ]);
  }

  // ==========================================================
  // SHOW MODAL AFTER BUILD
  // ==========================================================

  void _showCompleteProfileAfterBuild() {
    if (_modalAlreadyShown) {
      return;
    }

    _modalAlreadyShown = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _showProfileSetupModal();
    });
  }

  // ==========================================================
  // PROFILE SETUP MODAL (Multi-field: Name, Phone, Education, Interest)
  // ==========================================================

  Future<void> _showProfileSetupModal() async {
    String tempFullName = userName != "Student" ? userName : "";
    String tempPhone = phoneNumber;
    String tempEducation = educationLevel;
    String tempInterest = interestField;

    _fullNameController.text = tempFullName;
    _phoneController.text = tempPhone;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (modalContext, setModalState) {
            return PopScope(
              canPop: false,
              child: AlertDialog(
                backgroundColor: const Color(0xFF151F32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 10),
                actionsPadding: const EdgeInsets.fromLTRB(20, 5, 20, 18),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C2FF).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.person_add_outlined,
                        color: Color(0xFF00C2FF),
                        size: 27,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Complete Your Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      "Please provide your details right after logging in to personalize your dashboard.",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        // Full Name Input
                        TextField(
                          controller: _fullNameController,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (val) => tempFullName = val,
                          decoration: InputDecoration(
                            labelText: "Full Name",
                            labelStyle:
                                const TextStyle(color: Colors.white60),
                            prefixIcon: const Icon(Icons.person_outline,
                                color: Color(0xFF00C2FF)),
                            filled: true,
                            fillColor: const Color(0xFF0B1220),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.white12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.white12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Color(0xFF00C2FF)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        // Phone Number Input
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (val) => tempPhone = val,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            labelStyle:
                                const TextStyle(color: Colors.white60),
                            prefixIcon: const Icon(Icons.phone_outlined,
                                color: Color(0xFF00C2FF)),
                            filled: true,
                            fillColor: const Color(0xFF0B1220),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.white12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.white12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Color(0xFF00C2FF)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Education Level",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildChoiceChip(
                              label: "Matric / O-Level",
                              selected: tempEducation == "matric",
                              onSelected: (selected) {
                                setModalState(() => tempEducation = "matric");
                              },
                            ),
                            const SizedBox(width: 8),
                            _buildChoiceChip(
                              label: "Intermediate / A-Level",
                              selected: tempEducation == "intermediate",
                              onSelected: (selected) {
                                setModalState(
                                    () => tempEducation = "intermediate");
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildChoiceChip(
                              label: "Undergraduate",
                              selected: tempEducation == "undergraduate",
                              onSelected: (selected) {
                                setModalState(
                                    () => tempEducation = "undergraduate");
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Choose Career Field",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _fieldOption(
                          title: "Computer",
                          subtitle: "Computer Science & IT careers",
                          icon: Icons.computer_outlined,
                          value: "computer",
                          selectedField: tempInterest,
                          onSelect: () {
                            setModalState(() => tempInterest = "computer");
                          },
                        ),
                        const SizedBox(height: 8),
                        _fieldOption(
                          title: "Medical",
                          subtitle: "Medicine & healthcare careers",
                          icon: Icons.medical_services_outlined,
                          value: "medical",
                          selectedField: tempInterest,
                          onSelect: () {
                            setModalState(() => tempInterest = "medical");
                          },
                        ),
                        const SizedBox(height: 8),
                        _fieldOption(
                          title: "Engineering",
                          subtitle: "Engineering & technical careers",
                          icon: Icons.engineering_outlined,
                          value: "engineering",
                          selectedField: tempInterest,
                          onSelect: () {
                            setModalState(() => tempInterest = "engineering");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: tempFullName.trim().isEmpty ||
                              tempPhone.trim().isEmpty ||
                              tempEducation.isEmpty ||
                              tempInterest.isEmpty ||
                              isSavingProfile
                          ? null
                          : () async {
                              setModalState(() {
                                isSavingProfile = true;
                              });

                              final bool success =
                                  await _saveStudentProfileData(
                                fullName: tempFullName.trim(),
                                phone: tempPhone.trim(),
                                education: tempEducation,
                                field: tempInterest,
                              );

                              if (!mounted) return;

                              if (success) {
                                Navigator.of(dialogContext).pop();
                              } else {
                                setModalState(() {
                                  isSavingProfile = false;
                                });
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C2FF),
                        disabledBackgroundColor: Colors.white12,
                        foregroundColor: const Color(0xFF0B1220),
                        disabledForegroundColor: Colors.white30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isSavingProfile
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Color(0xFF0B1220),
                              ),
                            )
                          : const Text(
                              "Save & Continue",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (mounted) {
      setState(() {
        isSavingProfile = false;
      });
    }
  }

  Widget _buildChoiceChip({
    required String label,
    required bool selected,
    required ValueChanged<bool> onSelected,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: const Color(0xFF00C2FF).withOpacity(0.2),
      backgroundColor: const Color(0xFF0B1220),
      labelStyle: TextStyle(
        color: selected ? const Color(0xFF00C2FF) : Colors.white70,
        fontSize: 12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: selected ? const Color(0xFF00C2FF) : Colors.white24,
        ),
      ),
    );
  }

  // ==========================================================
  // FIELD OPTION
  // ==========================================================

  Widget _fieldOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required String selectedField,
    required VoidCallback onSelect,
  }) {
    final bool selected = selectedField == value;

    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(15),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF00C2FF).withOpacity(0.12)
              : const Color(0xFF0B1220),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selected ? const Color(0xFF00C2FF) : Colors.white12,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF00C2FF).withOpacity(0.15)
                    : Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: selected ? const Color(0xFF00C2FF) : Colors.white70,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color:
                          selected ? const Color(0xFF00C2FF) : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: selected ? const Color(0xFF00C2FF) : Colors.white24,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SAVE STUDENT PROFILE DATA
  // ==========================================================

  Future<bool> _saveStudentProfileData({
    required String fullName,
    required String phone,
    required String education,
    required String field,
  }) async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) return false;

      final String normalizedField = field.trim().toLowerCase();

      await _firestore.collection("users").doc(user.uid).set(
        {
          "name": fullName,
          "fullName": fullName,
          "phone": phone,
          "educationLevel": education,
          "interest_field": normalizedField,
        },
        SetOptions(merge: true),
      );

      debugPrint("Student profile saved successfully.");

      if (!mounted) return true;

      setState(() {
        userName = fullName;
        phoneNumber = phone;
        educationLevel = education;
        interestField = normalizedField;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile completed successfully!"),
        ),
      );

      return true;
    } catch (e) {
      debugPrint("Profile save error: $e");

      if (!mounted) return false;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to save profile. Please try again."),
        ),
      );

      return false;
    }
  }

  // ==========================================================
  // FORMAT HELPERS
  // ==========================================================

  String _formatField(String field) {
    switch (field.toLowerCase()) {
      case "computer":
        return "Computer";
      case "medical":
        return "Medical";
      case "engineering":
        return "Engineering";
      default:
        return field.isEmpty ? "General" : field;
    }
  }

  IconData _fieldIcon(String field) {
    switch (field.toLowerCase()) {
      case "computer":
        return Icons.computer_outlined;
      case "medical":
        return Icons.medical_services_outlined;
      case "engineering":
        return Icons.engineering_outlined;
      default:
        return Icons.explore_outlined;
    }
  }

  String _timeAgo(dynamic timestamp) {
    if (timestamp is! Timestamp) return "";

    final DateTime date = timestamp.toDate();
    final Duration diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    if (diff.inDays < 7) return "${diff.inDays}d ago";

    return "${date.day}/${date.month}/${date.year}";
  }

  // ==========================================================
  // LOGOUT
  // ==========================================================

  Future<void> logout(BuildContext context) async {
    await _auth.signOut();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  // ==========================================================
  // BANNER DATA
  // ==========================================================

  List<Map<String, dynamic>> get _banners => [
        {
          "title": "Take the Career Quiz",
          "subtitle": "Discover your ideal stream in under 3 minutes",
          "icon": Icons.quiz_rounded,
          "colors": const [Color(0xFF3654E0), Color(0xFF6278E8)],
          "onTap": () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CareerQuizScreen(),
              ),
            );
          },
        },
        {
          "title": "Explore the Career Bank",
          "subtitle": "Browse careers by domain, skills & salary",
          "icon": Icons.work_rounded,
          "colors": const [Color(0xFF00A9C2), Color(0xFF00E0C2)],
          "onTap": () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CareerBankScreen(),
              ),
            );
          },
        },
        {
          "title": "Resource Library",
          "subtitle": "PDFs, checklists & infographics — coming soon",
          "icon": Icons.menu_book_rounded,
          "colors": const [Color(0xFFE0A836), Color(0xFFE86278)],
          "onTap": () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Resource Library coming soon."),
              ),
            );
          },
        },
      ];

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      drawer: const StudentDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        title: const Text(
          "Student Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // ----- NOTIFICATIONS (always available, parallel to flow) -----
        IconButton(
  tooltip: "Notifications",
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationsScreen(),
      ),
    );
  },
  icon: const Icon(Icons.notifications_outlined),
),

          // ----- SETTINGS (always available, parallel to flow) -----
          IconButton(
            tooltip: "Settings",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text("Settings (dark mode, font size) coming soon."),
                ),
              );
            },
            icon: const Icon(Icons.settings_outlined),
          ),

          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF00C2FF),
              ),
            )
          : RefreshIndicator(
              onRefresh: _refreshEverything,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==================================================
                    // WELCOME CARD
                    // ==================================================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF3654E0),
                            Color(0xFF6278E8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  userType.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Text(
                            "Welcome, $userName 👋",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            user?.email ?? "",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          if (interestField.isNotEmpty) ...[
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Interest: ${_formatField(interestField)}",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ==================================================
                    // BANNER CAROUSEL
                    // ==================================================

                    _bannerCarousel(),

                    const SizedBox(height: 28),

                    // ==================================================
                    // QUIZ RESULTS (dynamic)
                    // ==================================================

                    const Text(
                      "Quiz Results",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _quizResultsCard(),

                    const SizedBox(height: 28),

                    // ==================================================
                    // RECENT ACTIVITY (dynamic — quiz_history)
                    // ==================================================

                    const Text(
                      "Recent Activity",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _recentActivitySection(),

                    const SizedBox(height: 28),

                    // ==================================================
                    // BOOKMARKS (dynamic)
                    // ==================================================

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Bookmarks",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Bookmarks screen coming soon."),
                              ),
                            );
                          },
                          child: const Text("View All"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _bookmarksSection(),

                    const SizedBox(height: 28),

                    // ==================================================
                    // TRENDING CAREERS (dynamic — careerBank)
                    // ==================================================

                    const Text(
                      "Trending Careers",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _trendingCareersSection(),

                    const SizedBox(height: 28),

                    // ==================================================
                    // CAREER PROGRESS
                    // ==================================================

                    const Text(
                      "Career Progress",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _careerProgressCard(),

                    const SizedBox(height: 28),

                    // ==================================================
                    // QUICK ACTIONS
                    // ==================================================

                    const Text(
                      "Explore PathSeeker",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      children: [
                        _actionCard(
                          icon: Icons.quiz_outlined,
                          title: "Take a Quiz",
                          subtitle: "Discover career paths",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CareerQuizScreen(),
                              ),
                            );
                          },
                        ),
                        _actionCard(
                          icon: Icons.work_outline_rounded,
                          title: "Career Bank",
                          subtitle: "Explore careers & roles",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CareerBankScreen(),
                              ),
                            );
                          },
                        ),
                        _actionCard(
                          icon: Icons.psychology_outlined,
                          title: "Skills",
                          subtitle: "Build useful skills",
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Skills section coming soon."),
                              ),
                            );
                          },
                        ),
                        _actionCard(
                          icon: Icons.school_outlined,
                          title: "Learning",
                          subtitle: "Videos & podcasts",
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Learning Center coming soon."),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ==================================================
                    // TOP PICKS FOR YOU (dynamic — from latest quiz)
                    // ==================================================

                    const Text(
                      "Top Picks For You",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ..._topPicksWidgets(),

                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
    );
  }

  // ==========================================================
  // BANNER CAROUSEL WIDGET
  // ==========================================================

  Widget _bannerCarousel() {
    final banners = _banners;

    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: banners.length,
            onPageChanged: (index) => setState(() => _bannerIndex = index),
            itemBuilder: (context, index) {
              final banner = banners[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: banner["onTap"] as VoidCallback,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: banner["colors"] as List<Color>,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            banner["icon"] as IconData,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                banner["title"] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                banner["subtitle"] as String,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 12,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white70,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
            final bool active = index == _bannerIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 6,
              width: active ? 18 : 6,
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xFF00C2FF)
                    : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        ),
      ],
    );
  }

  // ==========================================================
  // QUIZ RESULTS CARD
  // ==========================================================

  Widget _quizResultsCard() {
    if (extrasLoading && latestQuizResult == null) {
      return _skeletonCard(height: 90);
    }

    final result = latestQuizResult;

    if (result == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF151F32),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                color: const Color(0xFF00C2FF).withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.quiz_outlined,
                color: Color(0xFF00C2FF),
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "No quiz attempted yet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Take the Career Quiz to get personalized recommendations.",
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final String field = result['field']?.toString() ?? '';
    final int percentage = (result['percentage'] as num?)?.toInt() ?? 0;
    final String stream = result['recommendedStream']?.toString() ?? '';
    final String summary = result['summary']?.toString() ?? '';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF151F32),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00C2FF).withOpacity(0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_fieldIcon(field), color: const Color(0xFF00C2FF), size: 22),
              const SizedBox(width: 10),
              Text(
                _formatField(field),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF00C2FF).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "$percentage%",
                  style: const TextStyle(
                    color: Color(0xFF00C2FF),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          if (stream.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              "Recommended stream: $stream",
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
          if (summary.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              summary,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ==========================================================
  // RECENT ACTIVITY SECTION
  // ==========================================================

  Widget _recentActivitySection() {
    if (extrasLoading && recentQuizHistory.isEmpty) {
      return _skeletonCard(height: 70);
    }

    if (recentQuizHistory.isEmpty) {
      return _emptyStateCard(
        icon: Icons.history,
        text: "No recent activity yet — your quiz attempts will show up here.",
      );
    }

    return Column(
      children: recentQuizHistory.map((entry) {
        final String field = entry['field']?.toString() ?? '';
        final int percentage = (entry['percentage'] as num?)?.toInt() ?? 0;
        final String when = _timeAgo(entry['takenAt']);

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF151F32),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              Icon(_fieldIcon(field), color: const Color(0xFF00C2FF), size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "${_formatField(field)} Quiz — $percentage%",
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              if (when.isNotEmpty)
                Text(
                  when,
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ==========================================================
  // BOOKMARKS SECTION
  // ==========================================================

  Widget _bookmarksSection() {
    if (extrasLoading && recentBookmarks.isEmpty) {
      return _skeletonCard(height: 70);
    }

    if (recentBookmarks.isEmpty) {
      return _emptyStateCard(
        icon: Icons.bookmark_border,
        text: "No bookmarks yet — save careers you like from the Career Bank.",
      );
    }

    return Column(
      children: recentBookmarks.map((entry) {
        final String title = entry['title']?.toString() ?? 'Untitled';
        final String note = entry['note']?.toString() ?? '';

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF151F32),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              const Icon(Icons.bookmark, color: Color(0xFF00C2FF), size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (note.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        note,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ==========================================================
  // TRENDING CAREERS SECTION
  // ==========================================================

  Widget _trendingCareersSection() {
    if (extrasLoading && trendingCareers.isEmpty) {
      return _skeletonCard(height: 130);
    }

    if (trendingCareers.isEmpty) {
      return _emptyStateCard(
        icon: Icons.trending_up_rounded,
        text: "No careers published yet — check back soon.",
      );
    }

    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: trendingCareers.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final data = trendingCareers[index];
          final String name = data['careerName']?.toString() ?? 'Career';
          final String category = data['categoryName']?.toString() ?? '';
          final List skills = data['skills'] ?? [];

          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CareerBankScreen(),
                ),
              );
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF151F32),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (category.isNotEmpty)
                    Text(
                      category,
                      style: const TextStyle(
                        color: Color(0xFF00C2FF),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const Spacer(),
                  if (skills.isNotEmpty)
                    Text(
                      skills.take(2).join(" • "),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ==========================================================
  // TOP PICKS FOR YOU
  // ==========================================================

  List<Widget> _topPicksWidgets() {
    final result = latestQuizResult;

    final List<String> careers =
        result != null && result['recommendedCareers'] is List
            ? List<String>.from(
                (result['recommendedCareers'] as List).map((e) => e.toString()))
            : <String>[];

    if (careers.isEmpty) {
      return [
        _recommendationCard(
          icon: Icons.rocket_launch_rounded,
          title: "Build Your Career Profile",
          subtitle:
              "Add your education, skills and interests to get personalized recommendations.",
        ),
        const SizedBox(height: 12),
        _recommendationCard(
          icon: Icons.quiz_outlined,
          title: "Take the Career Quiz",
          subtitle:
              "Attempt the quiz to unlock stream and career recommendations here.",
        ),
      ];
    }

    final widgets = <Widget>[];
    final String field = result!['field']?.toString() ?? '';

    for (int i = 0; i < careers.length; i++) {
      widgets.add(
        _recommendationCard(
          icon: Icons.trending_up_rounded,
          title: careers[i],
          subtitle:
              "Suggested based on your latest quiz result in ${_formatField(field)}.",
        ),
      );

      if (i != careers.length - 1) {
        widgets.add(const SizedBox(height: 12));
      }
    }

    return widgets;
  }

  // ==========================================================
  // CAREER PROGRESS (Profile Completion)
  // ==========================================================

  Widget _careerProgressCard() {
    int filled = 0;
    const int totalChecks = 4;

    if (userName.trim().isNotEmpty && userName != "Student") filled++;
    if (interestField.isNotEmpty) filled++;
    if (educationLevel.isNotEmpty) filled++;
    if (phoneNumber.isNotEmpty) filled++;

    final int percent = ((filled / totalChecks) * 100).round();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Profile Completion",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                "$percent%",
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: percent / 100,
              minHeight: 9,
              backgroundColor: const Color(0xFFE7EAF2),
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            percent == 100
                ? "Your profile is complete."
                : "Complete your profile to unlock better career opportunities.",
            style: const TextStyle(
              color: Color(0xFF697386),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SHARED HELPERS: skeleton / empty-state cards
  // ==========================================================

  Widget _skeletonCard({required double height}) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF151F32),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: const Center(
        child: SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: Color(0xFF00C2FF),
          ),
        ),
      ),
    );
  }

  Widget _emptyStateCard({required IconData icon, required String text}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151F32),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white38, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ACTION CARD
  // ==========================================================

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 25),
            ),
            const SizedBox(height: 11),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF172033),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF697386),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // RECOMMENDATION CARD
  // ==========================================================

  Widget _recommendationCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primary, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF172033),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF697386),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}