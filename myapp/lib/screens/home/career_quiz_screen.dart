// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class CareerQuizScreen extends StatefulWidget {
//   const CareerQuizScreen({super.key});

//   @override
//   State<CareerQuizScreen> createState() => _CareerQuizScreenState();
// }

// class _CareerQuizScreenState extends State<CareerQuizScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   bool isSubmitting = false;

//   int selectedStreamChoice = 0;
//   double technicalSliderVal = 5.0;
//   double creativeRating = 3.0;
//   double teamworkRating = 3.0;
//   double leadershipRating = 3.0;

//   final List<Map<String, dynamic>> streamOptions = [
//     {
//       "title": "Software & Tech Development",
//       "subtitle": "Building apps, solving logic puzzles, and coding systems",
//       "category": "computer",
//     },
//     {
//       "title": "Healthcare & Life Sciences",
//       "subtitle": "Clinical research, patient care, and biological sciences",
//       "category": "medical",
//     },
//     {
//       "title": "Core Engineering & Systems",
//       "subtitle": "Hardware design, mechanics, and physical architecture",
//       "category": "engineering",
//     },
//   ];

//   Future<void> _submitQuizAndGetRecommendations() async {
//     setState(() {
//       isSubmitting = true;
//     });

//     try {
//       final User? user = _auth.currentUser;
//       if (user == null) return;

//       final DocumentSnapshot userDoc =
//           await _firestore.collection("users").doc(user.uid).get();

//       final Map<String, dynamic> userData =
//           userDoc.exists ? (userDoc.data() as Map<String, dynamic>) : {};

//       final String educationLevel = userData["educationLevel"] ?? "undergraduate";
//       final String baseInterest = userData["interest_field"] ?? "computer";

//       final Map<String, dynamic> evaluationResult = _evaluateCareerMatch(
//         selectedCategory: streamOptions[selectedStreamChoice]["category"],
//         techSlider: technicalSliderVal,
//         creative: creativeRating,
//         teamwork: teamworkRating,
//         leadership: leadershipRating,
//         baseInterest: baseInterest,
//         education: educationLevel,
//       );

//       final List<String> recommendedRoles =
//           List<String>.from(evaluationResult["roles"]);
//       final String primaryMatch = evaluationResult["primaryStream"];

//       final quizData = {
//         "timestamp": FieldValue.serverTimestamp(),
//         "selectedStreamIndex": selectedStreamChoice,
//         "technicalPreference": technicalSliderVal,
//         "creativeScore": creativeRating,
//         "teamworkScore": teamworkRating,
//         "leadershipScore": leadershipRating,
//         "recommendedRoles": recommendedRoles,
//         "primaryStreamMatch": primaryMatch,
//       };

//       await _firestore
//           .collection("users")
//           .doc(user.uid)
//           .collection("quiz_history")
//           .add(quizData);

//       if (!mounted) return;

//       setState(() {
//         isSubmitting = false;
//       });

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => CareerResultsScreen(
//             recommendedRoles: recommendedRoles,
//             primaryStream: primaryMatch,
//             evaluationSummary: evaluationResult["summary"],
//           ),
//         ),
//       );
//     } catch (e) {
//       debugPrint("Quiz submission error: $e");
//       if (!mounted) return;
//       setState(() {
//         isSubmitting = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Failed to generate recommendations. Try again."),
//         ),
//       );
//     }
//   }

//   Map<String, dynamic> _evaluateCareerMatch({
//     required String selectedCategory,
//     required double techSlider,
//     required double creative,
//     required double teamwork,
//     required double leadership,
//     required String baseInterest,
//     required String education,
//   }) {
//     List<String> roles = [];
//     String primaryStream = "";
//     String summary = "";

//     if (selectedCategory == "computer" || baseInterest == "computer") {
//       primaryStream = "Computer & Software Systems";
//       if (techSlider >= 7.0) {
//         roles = [
//           "Full Stack Software Engineer",
//           "Backend & Cloud Architect",
//           "AI/ML Developer",
//         ];
//         summary =
//             "Aapka technical झुकाव bohot strong hai. High-scale backend systems aur AI development aapke liye perfect rahenge.";
//       } else {
//         roles = [
//           "UI/UX Product Designer",
//           "Frontend Developer",
//           "Digital Product Manager",
//         ];
//         summary =
//             "Aapka balance technical aur creative dono sides par hai. Product design aur frontend development ideal match hain.";
//       }
//     } else if (selectedCategory == "medical" || baseInterest == "medical") {
//       primaryStream = "Healthcare & Life Sciences";
//       if (leadership >= 4.0) {
//         roles = [
//           "Healthcare Administration Manager",
//           "Clinical Research Lead",
//           "Biomedical Project Coordinator",
//         ];
//         summary =
//             "Aap medical field ke sath-sath leadership qualities bhi rakhte hain, jo management roles ke liye behtareen hain.";
//       } else {
//         roles = [
//           "Clinical Data Analyst",
//           "Medical Researcher",
//           "Healthcare Software Specialist",
//         ];
//         summary =
//             "Aapki analytical approach medical diagnostics aur healthcare tech ke liye bilkul fit hai.";
//       }
//     } else {
//       primaryStream = "Core Engineering & Technical Systems";
//       if (techSlider >= 6.0) {
//         roles = [
//           "Robotics Systems Engineer",
//           "IoT & Automation Specialist",
//           "Mechanical Design Analyst",
//         ];
//         summary =
//             "Aapka focus physical systems aur automated hardware design par bohot strong hai.";
//       } else {
//         roles = [
//           "Technical Operations Manager",
//           "Quality Assurance Engineer",
//           "Systems Integration Lead",
//         ];
//         summary =
//             "Aapki structured approach engineering operations ko optimize karne ke liye ideal hai.";
//       }
//     }

//     return {
//       "primaryStream": primaryStream,
//       "roles": roles,
//       "summary": summary,
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0B1220),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0B1220),
//         elevation: 0,
//         title: const Text(
//           "Career Assessment Quiz",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Discover Your Ideal Career Path",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 6),
//             const Text(
//               "Complete this interactive questionnaire to calibrate your personalized stream and role recommendations.",
//               style: TextStyle(
//                 color: Colors.white60,
//                 fontSize: 13,
//                 height: 1.4,
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               "1. Core Domain Preference",
//               style: TextStyle(
//                 color: Color(0xFF00C2FF),
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             ...List.generate(streamOptions.length, (index) {
//               final bool isSelected = selectedStreamChoice == index;
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: InkWell(
//                   onTap: () => setState(() => selectedStreamChoice = index),
//                   borderRadius: BorderRadius.circular(12),
//                   child: Container(
//                     padding: const EdgeInsets.all(14),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? const Color(0xFF00C2FF).withOpacity(0.15)
//                           : const Color(0xFF151F32),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: isSelected
//                             ? const Color(0xFF00C2FF)
//                             : Colors.white12,
//                         width: isSelected ? 1.5 : 1,
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 streamOptions[index]["title"]!,
//                                 style: TextStyle(
//                                   color: isSelected
//                                       ? const Color(0xFF00C2FF)
//                                       : Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               const SizedBox(height: 3),
//                               Text(
//                                 streamOptions[index]["subtitle"]!,
//                                 style: const TextStyle(
//                                   color: Colors.white60,
//                                   fontSize: 11,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Icon(
//                           isSelected
//                               ? Icons.check_circle
//                               : Icons.radio_button_unchecked,
//                           color: isSelected
//                               ? const Color(0xFF00C2FF)
//                               : Colors.white24,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }),
//             const SizedBox(height: 20),
//             const Text(
//               "2. Technical Complexity Comfort (1 to 10)",
//               style: TextStyle(
//                 color: Color(0xFF00C2FF),
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               "Current Value: ${technicalSliderVal.toInt()}/10",
//               style: const TextStyle(
//                 color: Colors.white70,
//                 fontSize: 12,
//               ),
//             ),
//             Slider(
//               value: technicalSliderVal,
//               min: 1.0,
//               max: 10.0,
//               divisions: 9,
//               activeColor: const Color(0xFF00C2FF),
//               inactiveColor: Colors.white12,
//               onChanged: (val) => setState(() => technicalSliderVal = val),
//             ),
//             const SizedBox(height: 15),
//             const Text(
//               "3. Skill Weight Ratings (1 to 5 Stars)",
//               style: TextStyle(
//                 color: Color(0xFF00C2FF),
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             _buildRatingRow(
//               "Creative Expression",
//               creativeRating,
//               (val) => setState(() => creativeRating = val),
//             ),
//             _buildRatingRow(
//               "Team Collaboration",
//               teamworkRating,
//               (val) => setState(() => teamworkRating = val),
//             ),
//             _buildRatingRow(
//               "Leadership & Management",
//               leadershipRating,
//               (val) => setState(() => leadershipRating = val),
//             ),
//             const SizedBox(height: 30),
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed:
//                     isSubmitting ? null : _submitQuizAndGetRecommendations,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF00C2FF),
//                   disabledBackgroundColor: Colors.white12,
//                   foregroundColor: const Color(0xFF0B1220),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: isSubmitting
//                     ? const SizedBox(
//                         height: 22,
//                         width: 22,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2.5,
//                           color: Color(0xFF0B1220),
//                         ),
//                       )
//                     : const Text(
//                         "Generate My Recommendations",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                         ),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRatingRow(
//       String label, double rating, ValueChanged<double> onChanged) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               label,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 13,
//               ),
//             ),
//           ),
//           Row(
//             children: List.generate(5, (index) {
//               return InkWell(
//                 onTap: () => onChanged((index + 1).toDouble()),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 3.0),
//                   child: Icon(
//                     index < rating ? Icons.star : Icons.star_border,
//                     color: const Color(0xFF00C2FF),
//                     size: 22,
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CareerResultsScreen extends StatelessWidget {
//   final List<String> recommendedRoles;
//   final String primaryStream;
//   final String evaluationSummary;

//   const CareerResultsScreen({
//     super.key,
//     required this.recommendedRoles,
//     required this.primaryStream,
//     required this.evaluationSummary,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0B1220),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0B1220),
//         elevation: 0,
//         title: const Text(
//           "Your Career Recommendations",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFF3654E0), Color(0xFF6278E8)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Primary Matched Stream",
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 12,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     primaryStream,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     evaluationSummary,
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.9),
//                       fontSize: 13,
//                       height: 1.4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               "Recommended Job Roles for You",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//             ...recommendedRoles.map((role) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 10.0),
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF151F32),
//                     borderRadius: BorderRadius.circular(14),
//                     border: Border.all(color: Colors.white12),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.verified,
//                         color: Color(0xFF00C2FF),
//                         size: 22,
//                       ),
//                       const SizedBox(width: 14),
//                       Expanded(
//                         child: Text(
//                           role,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//             const SizedBox(height: 30),
//             SizedBox(
//               width: double.infinity,
//               height: 48,
//               child: ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF00C2FF),
//                   foregroundColor: const Color(0xFF0B1220),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   "Retake Quiz / Back to Dashboard",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ==============================================================
// FIRESTORE SCHEMA (aligned with the dashboard's expectations)
//
// users/{uid}/quiz_history/{attemptId}   -> one doc per attempt
// users/{uid}.latestQuizResult           -> most recent attempt
//
// Both use the SAME keys so the dashboard's "Recent Activity" and
// "Top Picks For You" cards (which read `latestQuizResult`) work
// no matter which quiz flow the student took:
//   field              : 'computer' | 'medical' | 'engineering'
//   percentage         : 0-100 composite readiness score
//   recommendedStream  : String
//   recommendedCareers : List<String>
//   takenAt            : server timestamp
//
// Extra fields (technicalPreference, creativeScore, teamworkScore,
// leadershipScore, summary) are kept too, for future analytics /
// a detailed history view — the dashboard just ignores them.
// ==============================================================

class CareerQuizScreen extends StatefulWidget {
  const CareerQuizScreen({super.key});

  @override
  State<CareerQuizScreen> createState() => _CareerQuizScreenState();
}

class _CareerQuizScreenState extends State<CareerQuizScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PageController _pageController = PageController();

  bool isSubmitting = false;
  int currentStep = 0;
  static const int totalSteps = 3;

  int selectedStreamChoice = 0;
  double technicalSliderVal = 5.0;
  double creativeRating = 3.0;
  double teamworkRating = 3.0;
  double leadershipRating = 3.0;

  // -------- TIMER (Step 1 is a timed question) --------
  Timer? _timer;
  int secondsLeft = 20;
  static const int stepOneDuration = 20;

  final List<Map<String, dynamic>> streamOptions = [
    {
      "title": "Software & Tech Development",
      "subtitle": "Building apps, solving logic puzzles, and coding systems",
      "category": "computer",
    },
    {
      "title": "Healthcare & Life Sciences",
      "subtitle": "Clinical research, patient care, and biological sciences",
      "category": "medical",
    },
    {
      "title": "Core Engineering & Systems",
      "subtitle": "Hardware design, mechanics, and physical architecture",
      "category": "engineering",
    },
  ];

  @override
  void initState() {
    super.initState();
    _startStepOneTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // ==========================================================
  // TIMER LOGIC — only Step 1 (domain preference) is timed.
  // If time runs out, whatever is currently selected (default
  // index 0) is locked in and the quiz auto-advances.
  // ==========================================================
  void _startStepOneTimer() {
    _timer?.cancel();
    secondsLeft = stepOneDuration;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (secondsLeft <= 1) {
        timer.cancel();
        _goToStep(1, autoAdvanced: true);
      } else {
        setState(() => secondsLeft--);
      }
    });
  }

  void _goToStep(int step, {bool autoAdvanced = false}) {
    _timer?.cancel();

    if (autoAdvanced && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Time's up — moving on with your current pick."),
          duration: Duration(seconds: 2),
        ),
      );
    }

    setState(() => currentStep = step);

    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextStep() {
    if (currentStep < totalSteps - 1) {
      _goToStep(currentStep + 1);
    } else {
      _submitQuizAndGetRecommendations();
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      _goToStep(currentStep - 1);
    } else {
      Navigator.pop(context);
    }
  }

  // ==========================================================
  // SUBMIT
  // ==========================================================
  Future<void> _submitQuizAndGetRecommendations() async {
    final User? user = _auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in to save your result.")),
      );
      return;
    }

    setState(() => isSubmitting = true);

    try {
      final DocumentSnapshot userDoc =
          await _firestore.collection("users").doc(user.uid).get();

      final Map<String, dynamic> userData =
          userDoc.exists ? (userDoc.data() as Map<String, dynamic>? ?? {}) : {};

      final String educationLevel =
          userData["educationLevel"]?.toString() ?? "undergraduate";
      final String baseInterest =
          userData["interest_field"]?.toString() ?? "computer";

      final String category =
          streamOptions[selectedStreamChoice]["category"] as String;

      final Map<String, dynamic> evaluationResult = _evaluateCareerMatch(
        selectedCategory: category,
        techSlider: technicalSliderVal,
        creative: creativeRating,
        teamwork: teamworkRating,
        leadership: leadershipRating,
        baseInterest: baseInterest,
        education: educationLevel,
      );

      final List<String> recommendedCareers =
          List<String>.from(evaluationResult["roles"]);
      final String primaryStream = evaluationResult["primaryStream"];
      final String summary = evaluationResult["summary"];

      // Composite 0-100 readiness score from all quiz inputs —
      // not a "correct answer" score (this isn't an MCQ test), but
      // gives the dashboard a comparable percentage to display.
      final int percentage = _calculateCompositeScore();

      final Map<String, dynamic> resultData = {
        "field": category,
        "percentage": percentage,
        "recommendedStream": primaryStream,
        "recommendedCareers": recommendedCareers,
        "summary": summary,
        "technicalPreference": technicalSliderVal,
        "creativeScore": creativeRating,
        "teamworkScore": teamworkRating,
        "leadershipScore": leadershipRating,
        "takenAt": FieldValue.serverTimestamp(),
      };

      // Append to history (for future progress tracking).
      await _firestore
          .collection("users")
          .doc(user.uid)
          .collection("quiz_history")
          .add(resultData);

      // Update latest result so the dashboard reflects it immediately.
      await _firestore.collection("users").doc(user.uid).set(
        {"latestQuizResult": resultData},
        SetOptions(merge: true),
      );

      if (!mounted) return;

      setState(() => isSubmitting = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CareerResultsScreen(
            recommendedRoles: recommendedCareers,
            primaryStream: primaryStream,
            evaluationSummary: summary,
          ),
        ),
      );
    } catch (e) {
      debugPrint("Quiz submission error: $e");
      if (!mounted) return;

      setState(() => isSubmitting = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to generate recommendations: $e"),
        ),
      );
    }
  }

  int _calculateCompositeScore() {
    final double techNorm = technicalSliderVal / 10.0;
    final double creativeNorm = creativeRating / 5.0;
    final double teamworkNorm = teamworkRating / 5.0;
    final double leadershipNorm = leadershipRating / 5.0;

    final double avg =
        (techNorm + creativeNorm + teamworkNorm + leadershipNorm) / 4.0;

    return (avg * 100).round();
  }

  Map<String, dynamic> _evaluateCareerMatch({
    required String selectedCategory,
    required double techSlider,
    required double creative,
    required double teamwork,
    required double leadership,
    required String baseInterest,
    required String education,
  }) {
    List<String> roles = [];
    String primaryStream = "";
    String summary = "";

    if (selectedCategory == "computer" || baseInterest == "computer") {
      primaryStream = "Computer & Software Systems";
      if (techSlider >= 7.0) {
        roles = [
          "Full Stack Software Engineer",
          "Backend & Cloud Architect",
          "AI/ML Developer",
        ];
        summary =
            "Aapka technical jhukav bohot strong hai. High-scale backend systems aur AI development aapke liye perfect rahenge.";
      } else {
        roles = [
          "UI/UX Product Designer",
          "Frontend Developer",
          "Digital Product Manager",
        ];
        summary =
            "Aapka balance technical aur creative dono sides par hai. Product design aur frontend development ideal match hain.";
      }
    } else if (selectedCategory == "medical" || baseInterest == "medical") {
      primaryStream = "Healthcare & Life Sciences";
      if (leadership >= 4.0) {
        roles = [
          "Healthcare Administration Manager",
          "Clinical Research Lead",
          "Biomedical Project Coordinator",
        ];
        summary =
            "Aap medical field ke sath-sath leadership qualities bhi rakhte hain, jo management roles ke liye behtareen hain.";
      } else {
        roles = [
          "Clinical Data Analyst",
          "Medical Researcher",
          "Healthcare Software Specialist",
        ];
        summary =
            "Aapki analytical approach medical diagnostics aur healthcare tech ke liye bilkul fit hai.";
      }
    } else {
      primaryStream = "Core Engineering & Technical Systems";
      if (techSlider >= 6.0) {
        roles = [
          "Robotics Systems Engineer",
          "IoT & Automation Specialist",
          "Mechanical Design Analyst",
        ];
        summary =
            "Aapka focus physical systems aur automated hardware design par bohot strong hai.";
      } else {
        roles = [
          "Technical Operations Manager",
          "Quality Assurance Engineer",
          "Systems Integration Lead",
        ];
        summary =
            "Aapki structured approach engineering operations ko optimize karne ke liye ideal hai.";
      }
    }

    return {
      "primaryStream": primaryStream,
      "roles": roles,
      "summary": summary,
    };
  }

  // ==========================================================
  // BUILD
  // ==========================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        title: const Text(
          "Career Assessment Quiz",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: isSubmitting ? null : _previousStep,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // -------- PROGRESS --------
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Step ${currentStep + 1} of $totalSteps",
                        style: const TextStyle(
                          color: Color(0xFF00C2FF),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (currentStep == 0)
                        Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              color: Colors.orangeAccent,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${secondsLeft}s",
                              style: const TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: (currentStep + 1) / totalSteps,
                      minHeight: 6,
                      backgroundColor: Colors.white10,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF00C2FF),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // -------- STEPS --------
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _stepOneDomain(),
                  _stepTwoTechnical(),
                  _stepThreeRatings(),
                ],
              ),
            ),

            // -------- NEXT / SUBMIT BUTTON --------
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isSubmitting ? null : _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C2FF),
                    disabledBackgroundColor: Colors.white12,
                    foregroundColor: const Color(0xFF0B1220),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Color(0xFF0B1220),
                          ),
                        )
                      : Text(
                          currentStep == totalSteps - 1
                              ? "Generate My Recommendations"
                              : "Next",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // STEP 1 — Domain preference (TIMED)
  // ==========================================================
  Widget _stepOneDomain() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "1. Core Domain Preference",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Pick the one that excites you most — answer quickly, the timer is running!",
            style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 20),
          ...List.generate(streamOptions.length, (index) {
            final bool isSelected = selectedStreamChoice == index;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: InkWell(
                onTap: () => setState(() => selectedStreamChoice = index),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF00C2FF).withOpacity(0.15)
                        : const Color(0xFF151F32),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          isSelected ? const Color(0xFF00C2FF) : Colors.white12,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              streamOptions[index]["title"]!,
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF00C2FF)
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              streamOptions[index]["subtitle"]!,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isSelected
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color:
                            isSelected ? const Color(0xFF00C2FF) : Colors.white24,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // ==========================================================
  // STEP 2 — Technical slider
  // ==========================================================
  Widget _stepTwoTechnical() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "2. Technical Complexity Comfort",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "How comfortable are you with technical, logic-heavy work? (1 = low, 10 = high)",
            style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 30),
          Center(
            child: Text(
              "${technicalSliderVal.toInt()}/10",
              style: const TextStyle(
                color: Color(0xFF00C2FF),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Slider(
            value: technicalSliderVal,
            min: 1.0,
            max: 10.0,
            divisions: 9,
            activeColor: const Color(0xFF00C2FF),
            inactiveColor: Colors.white12,
            onChanged: (val) => setState(() => technicalSliderVal = val),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // STEP 3 — Ratings
  // ==========================================================
  Widget _stepThreeRatings() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "3. Skill Weight Ratings",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Rate yourself from 1 to 5 stars on each.",
            style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 20),
          _buildRatingRow(
            "Creative Expression",
            creativeRating,
            (val) => setState(() => creativeRating = val),
          ),
          _buildRatingRow(
            "Team Collaboration",
            teamworkRating,
            (val) => setState(() => teamworkRating = val),
          ),
          _buildRatingRow(
            "Leadership & Management",
            leadershipRating,
            (val) => setState(() => leadershipRating = val),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow(
      String label, double rating, ValueChanged<double> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF151F32),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              return InkWell(
                onTap: () => onChanged((index + 1).toDouble()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: const Color(0xFF00C2FF),
                    size: 22,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// RESULT SCREEN
// ============================================================

class CareerResultsScreen extends StatelessWidget {
  final List<String> recommendedRoles;
  final String primaryStream;
  final String evaluationSummary;

  const CareerResultsScreen({
    super.key,
    required this.recommendedRoles,
    required this.primaryStream,
    required this.evaluationSummary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        title: const Text(
          "Your Career Recommendations",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3654E0), Color(0xFF6278E8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Primary Matched Stream",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    primaryStream,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    evaluationSummary,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Recommended Job Roles for You",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...recommendedRoles.map((role) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF151F32),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.verified, color: Color(0xFF00C2FF), size: 22),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          role,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C2FF),
                  foregroundColor: const Color(0xFF0B1220),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Back to Dashboard",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}