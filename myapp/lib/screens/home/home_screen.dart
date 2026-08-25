// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';

// // import '../../core/constants/app_colors.dart';
// // import '../auth/login_screen.dart';

// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key});

// //   Future<void> logout(BuildContext context) async {
// //     await FirebaseAuth.instance.signOut();

// //     if (!context.mounted) return;

// //     Navigator.pushAndRemoveUntil(
// //       context,
// //       MaterialPageRoute(
// //         builder: (_) => const LoginScreen(),
// //       ),
// //       (route) => false,
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final user = FirebaseAuth.instance.currentUser;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('PathSeeker'),
// //         actions: [
// //           IconButton(
// //             onPressed: () => logout(context),
// //             icon: const Icon(Icons.logout),
// //           ),
// //         ],
// //       ),
// //       body: Center(
// //         child: Padding(
// //           padding: const EdgeInsets.all(24),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               const Icon(
// //                 Icons.explore_rounded,
// //                 size: 80,
// //                 color: AppColors.primary,
// //               ),

// //               const SizedBox(height: 20),

// //               const Text(
// //                 'Welcome to PathSeeker!',
// //                 style: TextStyle(
// //                   fontSize: 26,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),

// //               const SizedBox(height: 10),

// //               Text(
// //                 user?.email ?? '',
// //                 style: const TextStyle(
// //                   color: AppColors.textSecondary,
// //                 ),
// //               ),

// //               const SizedBox(height: 30),

// //               const Text(
// //                 'Your personalized career journey starts here.',
// //                 textAlign: TextAlign.center,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }











// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:myapp/screens/home/student_drawer.dart';

// import '../../core/constants/app_colors.dart';
// import '../auth/login_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   Future<void> logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();

//     if (!context.mounted) return;

//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//         builder: (_) => const LoginScreen(),
//       ),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//      backgroundColor: const Color(0xFF0B1220),
      

//       // ================= APP BAR =================

//   drawer: const StudentDrawer(),

//   appBar: AppBar(
//     backgroundColor: const Color(0xFF0B1220),
//     elevation: 0,
//     title: const Text(
//       "Student Dashboard",
//       style: TextStyle(
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   ),

//       // ================= BODY =================
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: user == null
//             ? null
//             : FirebaseFirestore.instance
//                 .collection('users')
//                 .doc(user.uid)
//                 .snapshots(),

//         builder: (context, snapshot) {
//           final data =
//               snapshot.data?.data() as Map<String, dynamic>?;

//           final userType =
//               data?['userType']?.toString() ?? 'student';

//           final name =
//               data?['name']?.toString() ??
//               data?['fullName']?.toString() ??
//               'Student';

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(20),

//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,

//               children: [

//                 // ================= WELCOME CARD =================
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(22),

//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [
//                         Color(0xFF3654E0),
//                         Color(0xFF6278E8),
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),

//                     borderRadius: BorderRadius.circular(24),
//                   ),

//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,

//                     children: [

//                       Row(
//                         children: [
//                           Container(
//                             height: 52,
//                             width: 52,

//                             decoration: BoxDecoration(
//                               color: Colors.white
//                                   .withOpacity(0.18),
//                               borderRadius:
//                                   BorderRadius.circular(16),
//                             ),

//                             child: const Icon(
//                               Icons.person_rounded,
//                               color: Colors.white,
//                               size: 30,
//                             ),
//                           ),

//                           const Spacer(),

//                           Container(
//                             padding:
//                                 const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 7,
//                             ),

//                             decoration: BoxDecoration(
//                               color: Colors.white
//                                   .withOpacity(0.15),
//                               borderRadius:
//                                   BorderRadius.circular(20),
//                             ),

//                             child: Text(
//                               userType.toUpperCase(),
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 18),

//                       Text(
//                         'Welcome, $name 👋',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 7),

//                       Text(
//                         user?.email ?? '',
//                         style: const TextStyle(
//                           color: Colors.white70,
//                           fontSize: 13,
//                         ),
//                       ),

//                       const SizedBox(height: 12),

//                       const Text(
//                         'Your personalized career journey starts here.',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 14,
//                           height: 1.4,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 28),

//                 // ================= CAREER PROGRESS =================
//                 const Text(
//                   'Career Progress',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF172033),
//                   ),
//                 ),

//                 const SizedBox(height: 14),

//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20),

//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),

//                     boxShadow: [
//                       BoxShadow(
//                         color:
//                             Colors.black.withOpacity(0.04),
//                         blurRadius: 12,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),

//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,

//                     children: [

//                       Row(
//                         mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,

//                         children: const [
//                           Text(
//                             'Profile Completion',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),

//                           Text(
//                             '65%',
//                             style: TextStyle(
//                               color: AppColors.primary,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 12),

//                       ClipRRect(
//                         borderRadius:
//                             BorderRadius.circular(20),

//                         child:
//                             const LinearProgressIndicator(
//                           value: 0.65,
//                           minHeight: 9,

//                           backgroundColor:
//                               Color(0xFFE7EAF2),

//                           valueColor:
//                               AlwaysStoppedAnimation(
//                             AppColors.primary,
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 12),

//                       const Text(
//                         'Complete your profile to unlock better career opportunities.',
//                         style: TextStyle(
//                           color: Color(0xFF697386),
//                           fontSize: 13,
//                           height: 1.4,
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       OutlinedButton(
//                         onPressed: () {},
//                         child:
//                             const Text('Complete Profile'),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 28),

//                 // ================= QUICK ACTIONS =================
//                 const Text(
//                   'Explore PathSeeker',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF172033),
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 GridView.count(
//                   crossAxisCount: 2,

//                   shrinkWrap: true,

//                   physics:
//                       const NeverScrollableScrollPhysics(),

//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,

//                   childAspectRatio: 1.2,

//                   children: [

//                     _actionCard(
//                       icon: Icons.explore_outlined,
//                       title: 'Explore Careers',
//                       subtitle:
//                           'Discover career paths',
//                       onTap: () {},
//                     ),

//                     _actionCard(
//                       icon: Icons.work_outline_rounded,
//                       title: 'Find Opportunities',
//                       subtitle:
//                           'Explore jobs & internships',
//                       onTap: () {},
//                     ),

//                     _actionCard(
//                       icon: Icons.psychology_outlined,
//                       title: 'Skills',
//                       subtitle:
//                           'Build useful skills',
//                       onTap: () {},
//                     ),

//                     _actionCard(
//                       icon: Icons.school_outlined,
//                       title: 'Learning',
//                       subtitle:
//                           'Learn something new',
//                       onTap: () {},
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 28),

//                 // ================= RECOMMENDED =================
//                 const Text(
//                   'Recommended For You',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF172033),
//                   ),
//                 ),

//                 const SizedBox(height: 14),

//                 _recommendationCard(
//                   icon: Icons.rocket_launch_rounded,
//                   title: 'Build Your Career Profile',
//                   subtitle:
//                       'Add your education, skills and interests to get personalized recommendations.',
//                 ),

//                 const SizedBox(height: 12),

//                 _recommendationCard(
//                   icon: Icons.trending_up_rounded,
//                   title: 'Improve Your Skills',
//                   subtitle:
//                       'Explore skills that can help you prepare for your future career.',
//                 ),

//                 const SizedBox(height: 25),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ================= ACTION CARD =================

//   static Widget _actionCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(18),
//       onTap: onTap,

//       child: Container(
//         padding: const EdgeInsets.all(16),

//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),

//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.035),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),

//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start,

//           mainAxisAlignment:
//               MainAxisAlignment.center,

//           children: [

//             Container(
//               padding: const EdgeInsets.all(10),

//               decoration: BoxDecoration(
//                 color: const Color(0xFFEEF2FF),
//                 borderRadius:
//                     BorderRadius.circular(12),
//               ),

//               child: Icon(
//                 icon,
//                 color: AppColors.primary,
//                 size: 25,
//               ),
//             ),

//             const SizedBox(height: 11),

//             Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//                 color: Color(0xFF172033),
//               ),
//             ),

//             const SizedBox(height: 4),

//             Text(
//               subtitle,
//               style: const TextStyle(
//                 fontSize: 11,
//                 color: Color(0xFF697386),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= RECOMMENDATION CARD =================

//   static Widget _recommendationCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),

//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),

//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.035),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),

//       child: Row(
//         crossAxisAlignment:
//             CrossAxisAlignment.start,

//         children: [

//           Container(
//             height: 50,
//             width: 50,

//             decoration: BoxDecoration(
//               color: const Color(0xFFEEF2FF),
//               borderRadius:
//                   BorderRadius.circular(14),
//             ),

//             child: Icon(
//               icon,
//               color: AppColors.primary,
//               size: 26,
//             ),
//           ),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,

//               children: [

//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                     color: Color(0xFF172033),
//                   ),
//                 ),

//                 const SizedBox(height: 6),

//                 Text(
//                   subtitle,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF697386),
//                     height: 1.4,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:myapp/screens/home/student_drawer.dart';

import '../../core/constants/app_colors.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  bool isLoading = true;
  bool isSavingInterest = false;

  String userName = "Student";
  String userType = "student";
  String interestField = "";

  bool _modalAlreadyShown = false;

  @override
  void initState() {
    super.initState();

    // Delay profile check until first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkStudentProfile();
    });
  }

  // ==========================================================
  // CHECK STUDENT PROFILE
  // ==========================================================

  Future<void> checkStudentProfile() async {
    try {
      final User? user = _auth.currentUser;

      // --------------------------------------------------------
      // NO AUTH USER
      // --------------------------------------------------------

      if (user == null) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        return;
      }

      // --------------------------------------------------------
      // GET FIRESTORE DOCUMENT
      // --------------------------------------------------------

      final DocumentReference userRef =
          _firestore.collection("users").doc(user.uid);

      final DocumentSnapshot snapshot =
          await userRef.get();

      // ========================================================
      // DOCUMENT DOES NOT EXIST
      // ========================================================

      if (!snapshot.exists) {
        debugPrint(
          "User document does not exist. Creating it...",
        );

        // Create the basic user document.
        // IMPORTANT:
        // interest_field is NOT given a fake value here.
        // It will be created by the modal after selection.

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
          userName =
              user.displayName ?? "Student";

          userType = "student";

          // Empty means modal must show.
          interestField = "";

          isLoading = false;
        });

        // ------------------------------------------------------
        // SHOW MODAL
        // ------------------------------------------------------

        _showInterestFieldAfterBuild();

        return;
      }

      // ========================================================
      // DOCUMENT EXISTS
      // ========================================================

      final dynamic rawData = snapshot.data();

      final Map<String, dynamic> data =
          rawData is Map<String, dynamic>
              ? rawData
              : {};

      // --------------------------------------------------------
      // USER NAME
      // --------------------------------------------------------

      String name = "Student";

      final String firestoreName =
          data["name"]?.toString().trim() ?? "";

      final String firestoreFullName =
          data["fullName"]?.toString().trim() ?? "";

      if (firestoreName.isNotEmpty) {
        name = firestoreName;
      } else if (firestoreFullName.isNotEmpty) {
        name = firestoreFullName;
      } else if ((user.displayName ?? "")
          .trim()
          .isNotEmpty) {
        name = user.displayName!.trim();
      }

      // --------------------------------------------------------
      // USER ROLE
      // --------------------------------------------------------

      String role = "student";

      final String firestoreRole =
          data["role"]?.toString().trim().toLowerCase() ??
              "";

      final String firestoreUserType =
          data["userType"]?.toString().trim().toLowerCase() ??
              "";

      if (firestoreRole.isNotEmpty) {
        role = firestoreRole;
      } else if (firestoreUserType.isNotEmpty) {
        role = firestoreUserType;
      }

      // --------------------------------------------------------
      // INTEREST FIELD
      //
      // IMPORTANT:
      //
      // Missing field:
      // data["interest_field"] == null
      //
      // Empty field:
      // ""
      //
      // Both should show the modal.
      // --------------------------------------------------------

      final dynamic rawInterest =
          data["interest_field"];

      final String field =
          rawInterest?.toString().trim().toLowerCase() ??
              "";

      debugPrint(
        "Firestore user exists: true",
      );

      debugPrint(
        "User role: $role",
      );

      debugPrint(
        "Interest field: '$field'",
      );

      if (!mounted) return;

      setState(() {
        userName = name;
        userType = role;
        interestField = field;
        isLoading = false;
      });

      // ========================================================
      // SHOW MODAL IF:
      //
      // 1. interest_field doesn't exist
      // 2. interest_field is empty
      //
      // ONLY STUDENT NEEDS THIS MODAL.
      // ========================================================

      if (role == "student" && field.isEmpty) {
        debugPrint(
          "Interest field missing/empty. Showing modal.",
        );

        _showInterestFieldAfterBuild();
      } else {
        debugPrint(
          "Interest field already exists. Modal will NOT show.",
        );
      }
    } catch (e, stackTrace) {
      debugPrint(
        "Student profile error: $e",
      );

      debugPrint(
        stackTrace.toString(),
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Unable to load your profile.",
          ),
        ),
      );
    }
  }

  // ==========================================================
  // SHOW MODAL AFTER BUILD
  // ==========================================================

  void _showInterestFieldAfterBuild() {
    if (_modalAlreadyShown) {
      return;
    }

    _modalAlreadyShown = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      // Extra safety:
      // Only show if interest field is STILL empty.
      if (interestField.trim().isEmpty) {
        _showInterestFieldModal();
      }
    });
  }

  // ==========================================================
  // INTEREST FIELD MODAL
  // ==========================================================

  Future<void> _showInterestFieldModal() async {
    String selectedField = "";

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (
            modalContext,
            setModalState,
          ) {
            return PopScope(
              canPop: false,

              child: AlertDialog(
                backgroundColor:
                    const Color(0xFF151F32),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(22),
                ),

                titlePadding:
                    const EdgeInsets.fromLTRB(
                  24,
                  24,
                  24,
                  8,
                ),

                contentPadding:
                    const EdgeInsets.fromLTRB(
                  24,
                  8,
                  24,
                  10,
                ),

                actionsPadding:
                    const EdgeInsets.fromLTRB(
                  20,
                  5,
                  20,
                  18,
                ),

                // ==================================================
                // TITLE
                // ==================================================

                title: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Container(
                      height: 50,
                      width: 50,

                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFF00C2FF,
                        ).withOpacity(0.12),

                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),

                      child:
                          const Icon(
                        Icons.explore_outlined,
                        color:
                            Color(0xFF00C2FF),
                        size: 27,
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    const Text(
                      "Choose Your Career Field",
                      style: TextStyle(
                        color:
                            Colors.white,
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 7,
                    ),

                    const Text(
                      "Select the field you are interested in. "
                      "This will personalize your career "
                      "recommendations and quizzes.",
                      style: TextStyle(
                        color:
                            Colors.white60,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),

                // ==================================================
                // OPTIONS
                // ==================================================

                content: Column(
                  mainAxisSize:
                      MainAxisSize.min,

                  children: [
                    const SizedBox(
                      height: 14,
                    ),

                    _fieldOption(
                      title: "Computer",
                      subtitle:
                          "Computer Science & IT careers",
                      icon:
                          Icons.computer_outlined,
                      value: "computer",
                      selectedField:
                          selectedField,
                      onSelect: () {
                        setModalState(() {
                          selectedField =
                              "computer";
                        });
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    _fieldOption(
                      title: "Medical",
                      subtitle:
                          "Medicine & healthcare careers",
                      icon:
                          Icons.medical_services_outlined,
                      value: "medical",
                      selectedField:
                          selectedField,
                      onSelect: () {
                        setModalState(() {
                          selectedField =
                              "medical";
                        });
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    _fieldOption(
                      title: "Engineering",
                      subtitle:
                          "Engineering & technical careers",
                      icon:
                          Icons.engineering_outlined,
                      value: "engineering",
                      selectedField:
                          selectedField,
                      onSelect: () {
                        setModalState(() {
                          selectedField =
                              "engineering";
                        });
                      },
                    ),
                  ],
                ),

                // ==================================================
                // CONTINUE
                // ==================================================

                actions: [
                  SizedBox(
                    width:
                        double.infinity,

                    height: 48,

                    child:
                        ElevatedButton(
                      onPressed:
                          selectedField
                                  .isEmpty ||
                              isSavingInterest
                          ? null
                          : () async {
                              setModalState(() {
                                isSavingInterest =
                                    true;
                              });

                              final bool
                                  success =
                                  await _saveInterestField(
                                selectedField,
                              );

                              if (!mounted) {
                                return;
                              }

                              if (success) {
                                Navigator.of(
                                  dialogContext,
                                ).pop();
                              } else {
                                setModalState(() {
                                  isSavingInterest =
                                      false;
                                });
                              }
                            },

                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            const Color(
                          0xFF00C2FF,
                        ),

                        disabledBackgroundColor:
                            Colors.white12,

                        foregroundColor:
                            const Color(
                          0xFF0B1220,
                        ),

                        disabledForegroundColor:
                            Colors.white30,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),

                      child:
                          isSavingInterest
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,

                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth:
                                        2.5,
                                    color:
                                        Color(
                                      0xFF0B1220,
                                    ),
                                  ),
                                )
                              : const Text(
                                  "Continue",
                                  style:
                                      TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .bold,
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

    // ------------------------------------------------------------
    // AFTER MODAL CLOSE
    // ------------------------------------------------------------

    if (mounted) {
      setState(() {
        isSavingInterest = false;
      });
    }
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
    final bool selected =
        selectedField == value;

    return InkWell(
      onTap: onSelect,

      borderRadius:
          BorderRadius.circular(15),

      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 180,
        ),

        width:
            double.infinity,

        padding:
            const EdgeInsets.all(14),

        decoration:
            BoxDecoration(
          color: selected
              ? const Color(
                  0xFF00C2FF,
                ).withOpacity(0.12)
              : const Color(
                  0xFF0B1220,
                ),

          borderRadius:
              BorderRadius.circular(15),

          border:
              Border.all(
            color: selected
                ? const Color(
                    0xFF00C2FF,
                  )
                : Colors.white12,

            width:
                selected ? 1.5 : 1,
          ),
        ),

        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,

              decoration:
                  BoxDecoration(
                color: selected
                    ? const Color(
                        0xFF00C2FF,
                      ).withOpacity(0.15)
                    : Colors.white10,

                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),

              child: Icon(
                icon,

                color: selected
                    ? const Color(
                        0xFF00C2FF,
                      )
                    : Colors.white70,

                size: 24,
              ),
            ),

            const SizedBox(
              width: 13,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    title,

                    style: TextStyle(
                      color: selected
                          ? const Color(
                              0xFF00C2FF,
                            )
                          : Colors.white,

                      fontSize: 15,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 3,
                  ),

                  Text(
                    subtitle,

                    style:
                        const TextStyle(
                      color:
                          Colors.white54,

                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              selected
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,

              color: selected
                  ? const Color(
                      0xFF00C2FF,
                    )
                  : Colors.white24,

              size: 23,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SAVE INTEREST FIELD
  // ==========================================================

  Future<bool> _saveInterestField(
    String field,
  ) async {
    try {
      final User? user =
          _auth.currentUser;

      if (user == null) {
        return false;
      }

      final String normalizedField =
          field.trim().toLowerCase();

      // ========================================================
      // THIS CREATES interest_field AUTOMATICALLY
      //
      // Even if interest_field did not previously exist,
      // Firestore creates it here.
      // ========================================================

      await _firestore
          .collection("users")
          .doc(user.uid)
          .set(
        {
          "interest_field":
              normalizedField,
        },
        SetOptions(
          merge: true,
        ),
      );

      debugPrint(
        "interest_field created/saved: $normalizedField",
      );

      if (!mounted) {
        return true;
      }

      setState(() {
        interestField =
            normalizedField;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            "Career field saved: ${_formatField(normalizedField)}",
          ),
        ),
      );

      return true;
    } catch (e) {
      debugPrint(
        "Interest field save error: $e",
      );

      if (!mounted) {
        return false;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to save career field. Please try again.",
          ),
        ),
      );

      return false;
    }
  }

  // ==========================================================
  // FORMAT FIELD
  // ==========================================================

  String _formatField(
    String field,
  ) {
    switch (
        field.toLowerCase()) {
      case "computer":
        return "Computer";

      case "medical":
        return "Medical";

      case "engineering":
        return "Engineering";

      default:
        return field;
    }
  }

  // ==========================================================
  // FIELD ICON
  // ==========================================================

  IconData _fieldIcon(
    String field,
  ) {
    switch (
        field.toLowerCase()) {
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

  // ==========================================================
  // LOGOUT
  // ==========================================================

  Future<void> logout(
    BuildContext context,
  ) async {
    await _auth.signOut();

    if (!context.mounted) {
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,

      MaterialPageRoute(
        builder: (_) =>
            const LoginScreen(),
      ),

      (route) => false,
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    final User? user =
        _auth.currentUser;

    return Scaffold(
      backgroundColor:
          const Color(0xFF0B1220),

      // ========================================================
      // DRAWER
      // ========================================================

      drawer:
          const StudentDrawer(),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar:
          AppBar(
        backgroundColor:
            const Color(0xFF0B1220),

        elevation: 0,

        title:
            const Text(
          "Student Dashboard",

          style:
              TextStyle(
            color:
                Colors.white,

            fontWeight:
                FontWeight.bold,
          ),
        ),

        iconTheme:
            const IconThemeData(
          color:
              Colors.white,
        ),

        actions: [
          IconButton(
            onPressed:
                () => logout(
              context,
            ),

            icon:
                const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(
                color:
                    Color(0xFF00C2FF),
              ),
            )
          : RefreshIndicator(
              onRefresh:
                  checkStudentProfile,

              child:
                  SingleChildScrollView(
                physics:
                    const AlwaysScrollableScrollPhysics(),

                padding:
                    const EdgeInsets.all(
                  20,
                ),

                child:
                    Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    // ==================================================
                    // WELCOME CARD
                    // ==================================================

                    Container(
                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets
                              .all(22),

                      decoration:
                          BoxDecoration(
                        gradient:
                            const LinearGradient(
                          colors: [
                            Color(
                              0xFF3654E0,
                            ),
                            Color(
                              0xFF6278E8,
                            ),
                          ],

                          begin:
                              Alignment
                                  .topLeft,

                          end:
                              Alignment
                                  .bottomRight,
                        ),

                        borderRadius:
                            BorderRadius
                                .circular(
                          24,
                        ),
                      ),

                      child:
                          Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          Row(
                            children: [
                              Container(
                                height:
                                    52,

                                width:
                                    52,

                                decoration:
                                    BoxDecoration(
                                  color: Colors
                                      .white
                                      .withOpacity(
                                    0.18,
                                  ),

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    16,
                                  ),
                                ),

                                child:
                                    const Icon(
                                  Icons
                                      .person_rounded,

                                  color:
                                      Colors
                                          .white,

                                  size:
                                      30,
                                ),
                              ),

                              const Spacer(),

                              Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal:
                                      12,

                                  vertical:
                                      7,
                                ),

                                decoration:
                                    BoxDecoration(
                                  color: Colors
                                      .white
                                      .withOpacity(
                                    0.15,
                                  ),

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    20,
                                  ),
                                ),

                                child:
                                    Text(
                                  userType
                                      .toUpperCase(),

                                  style:
                                      const TextStyle(
                                    color:
                                        Colors
                                            .white,

                                    fontSize:
                                        11,

                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height:
                                18,
                          ),

                          Text(
                            "Welcome, $userName 👋",

                            style:
                                const TextStyle(
                              color:
                                  Colors
                                      .white,

                              fontSize:
                                  25,

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          const SizedBox(
                            height:
                                7,
                          ),

                          Text(
                            user?.email ??
                                "",

                            style:
                                const TextStyle(
                              color:
                                  Colors
                                      .white70,

                              fontSize:
                                  13,
                            ),
                          ),

                          const SizedBox(
                            height:
                                12,
                          ),

                          const Text(
                            "Your personalized career journey starts here.",

                            style:
                                TextStyle(
                              color:
                                  Colors
                                      .white70,

                              fontSize:
                                  14,

                              height:
                                  1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height:
                          22,
                    ),

                    // ==================================================
                    // CAREER FIELD
                    // ==================================================

                    Container(
                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets
                              .all(18),

                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFF151F32,
                        ),

                        borderRadius:
                            BorderRadius
                                .circular(
                          20,
                        ),

                        border:
                            Border.all(
                          color:
                              const Color(
                            0xFF00C2FF,
                          ).withOpacity(
                            0.12,
                          ),
                        ),
                      ),

                      child:
                          Row(
                        children: [
                          Container(
                            height:
                                50,

                            width:
                                50,

                            decoration:
                                BoxDecoration(
                              color:
                                  const Color(
                                0xFF00C2FF,
                              ).withOpacity(
                                0.12,
                              ),

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                14,
                              ),
                            ),

                            child:
                                Icon(
                              _fieldIcon(
                                interestField,
                              ),

                              color:
                                  const Color(
                                0xFF00C2FF,
                              ),

                              size:
                                  27,
                            ),
                          ),

                          const SizedBox(
                            width:
                                14,
                          ),

                          Expanded(
                            child:
                                Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [
                                const Text(
                                  "Your Career Field",

                                  style:
                                      TextStyle(
                                    color:
                                        Colors
                                            .white54,

                                    fontSize:
                                        12,
                                  ),
                                ),

                                const SizedBox(
                                  height:
                                      5,
                                ),

                                Text(
                                  interestField
                                          .isEmpty
                                      ? "Not selected"
                                      : _formatField(
                                          interestField,
                                        ),

                                  style:
                                      const TextStyle(
                                    color:
                                        Colors
                                            .white,

                                    fontSize:
                                        18,

                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),

                                if (interestField
                                    .isNotEmpty)
                                  const Padding(
                                    padding:
                                        EdgeInsets
                                            .only(
                                      top:
                                          4,
                                    ),

                                    child:
                                        Text(
                                      "Used for your career recommendations and quiz.",

                                      style:
                                          TextStyle(
                                        color:
                                            Colors
                                                .white38,

                                        fontSize:
                                            10,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height:
                          28,
                    ),

                    // ==================================================
                    // CAREER PROGRESS
                    // ==================================================

                    const Text(
                      "Career Progress",

                      style:
                          TextStyle(
                        fontSize:
                            20,

                        fontWeight:
                            FontWeight
                                .bold,

                        color:
                            Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height:
                          14,
                    ),

                    Container(
                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets
                              .all(20),

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius
                                .circular(
                          20,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors
                                .black
                                .withOpacity(
                              0.04,
                            ),

                            blurRadius:
                                12,

                            offset:
                                const Offset(
                              0,
                              5,
                            ),
                          ),
                        ],
                      ),

                      child:
                          Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,

                            children:
                                const [
                              Text(
                                "Profile Completion",

                                style:
                                    TextStyle(
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),

                              Text(
                                "65%",

                                style:
                                    TextStyle(
                                  color:
                                      AppColors
                                          .primary,

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height:
                                12,
                          ),

                          ClipRRect(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              20,
                            ),

                            child:
                                const LinearProgressIndicator(
                              value:
                                  0.65,

                              minHeight:
                                  9,

                              backgroundColor:
                                  Color(
                                0xFFE7EAF2,
                              ),

                              valueColor:
                                  AlwaysStoppedAnimation(
                                AppColors
                                    .primary,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height:
                                12,
                          ),

                          const Text(
                            "Complete your profile to unlock better career opportunities.",

                            style:
                                TextStyle(
                              color:
                                  Color(
                                0xFF697386,
                              ),

                              fontSize:
                                  13,

                              height:
                                  1.4,
                            ),
                          ),

                          const SizedBox(
                            height:
                                15,
                          ),

                          OutlinedButton(
                            onPressed:
                                () {},

                            child:
                                const Text(
                              "Complete Profile",
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height:
                          28,
                    ),

                    // ==================================================
                    // QUICK ACTIONS
                    // ==================================================

                    const Text(
                      "Explore PathSeeker",

                      style:
                          TextStyle(
                        fontSize:
                            20,

                        fontWeight:
                            FontWeight
                                .bold,

                        color:
                            Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height:
                          15,
                    ),

                    GridView.count(
                      crossAxisCount:
                          2,

                      shrinkWrap:
                          true,

                      physics:
                          const NeverScrollableScrollPhysics(),

                      crossAxisSpacing:
                          12,

                      mainAxisSpacing:
                          12,

                      childAspectRatio:
                          1.2,

                      children: [
                        _actionCard(
                          icon:
                              Icons
                                  .explore_outlined,

                          title:
                              "Explore Careers",

                          subtitle:
                              "Discover career paths",

                          onTap: () {},
                        ),

                        _actionCard(
                          icon:
                              Icons
                                  .work_outline_rounded,

                          title:
                              "Find Opportunities",

                          subtitle:
                              "Explore jobs & internships",

                          onTap: () {},
                        ),

                        _actionCard(
                          icon:
                              Icons
                                  .psychology_outlined,

                          title:
                              "Skills",

                          subtitle:
                              "Build useful skills",

                          onTap: () {},
                        ),

                        _actionCard(
                          icon:
                              Icons
                                  .school_outlined,

                          title:
                              "Learning",

                          subtitle:
                              "Learn something new",

                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(
                      height:
                          28,
                    ),

                    // ==================================================
                    // RECOMMENDED
                    // ==================================================

                    const Text(
                      "Recommended For You",

                      style:
                          TextStyle(
                        fontSize:
                            20,

                        fontWeight:
                            FontWeight
                                .bold,

                        color:
                            Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height:
                          14,
                    ),

                    _recommendationCard(
                      icon:
                          Icons
                              .rocket_launch_rounded,

                      title:
                          "Build Your Career Profile",

                      subtitle:
                          "Add your education, skills and interests to get personalized recommendations.",
                    ),

                    const SizedBox(
                      height:
                          12,
                    ),

                    _recommendationCard(
                      icon:
                          Icons
                              .trending_up_rounded,

                      title:
                          "Improve Your Skills",

                      subtitle:
                          "Explore skills that can help you prepare for your future career.",
                    ),

                    const SizedBox(
                      height:
                          25,
                    ),
                  ],
                ),
              ),
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
      borderRadius:
          BorderRadius.circular(
        18,
      ),

      onTap:
          onTap,

      child:
          Container(
        padding:
            const EdgeInsets.all(
          16,
        ),

        decoration:
            BoxDecoration(
          color:
              Colors.white,

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(
                0.035,
              ),

              blurRadius:
                  10,

              offset:
                  const Offset(
                0,
                4,
              ),
            ),
          ],
        ),

        child:
            Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          mainAxisAlignment:
              MainAxisAlignment
                  .center,

          children: [
            Container(
              padding:
                  const EdgeInsets
                      .all(
                10,
              ),

              decoration:
                  BoxDecoration(
                color:
                    const Color(
                  0xFFEEF2FF,
                ),

                borderRadius:
                    BorderRadius
                        .circular(
                  12,
                ),
              ),

              child:
                  Icon(
                icon,

                color:
                    AppColors
                        .primary,

                size:
                    25,
              ),
            ),

            const SizedBox(
              height:
                  11,
            ),

            Text(
              title,

              style:
                  const TextStyle(
                fontWeight:
                    FontWeight
                        .bold,

                fontSize:
                    14,

                color:
                    Color(
                  0xFF172033,
                ),
              ),
            ),

            const SizedBox(
              height:
                  4,
            ),

            Text(
              subtitle,

              style:
                  const TextStyle(
                fontSize:
                    11,

                color:
                    Color(
                  0xFF697386,
                ),
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
      width:
          double.infinity,

      padding:
          const EdgeInsets.all(
        18,
      ),

      decoration:
          BoxDecoration(
        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(
              0.035,
            ),

            blurRadius:
                10,

            offset:
                const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child:
          Row(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [
          Container(
            height:
                50,

            width:
                50,

            decoration:
                BoxDecoration(
              color:
                  const Color(
                0xFFEEF2FF,
              ),

              borderRadius:
                  BorderRadius.circular(
                14,
              ),
            ),

            child:
                Icon(
              icon,

              color:
                  AppColors
                      .primary,

              size:
                  26,
            ),
          ),

          const SizedBox(
            width:
                14,
          ),

          Expanded(
            child:
                Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                Text(
                  title,

                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight
                            .bold,

                    fontSize:
                        15,

                    color:
                        Color(
                      0xFF172033,
                    ),
                  ),
                ),

                const SizedBox(
                  height:
                      6,
                ),

                Text(
                  subtitle,

                  style:
                      const TextStyle(
                    fontSize:
                        12,

                    color:
                        Color(
                      0xFF697386,
                    ),

                    height:
                        1.4,
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