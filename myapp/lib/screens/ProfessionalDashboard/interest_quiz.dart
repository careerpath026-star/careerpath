// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class InterestQuizPage extends StatefulWidget {
//   final String userId;
//   const InterestQuizPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<InterestQuizPage> createState() => _InterestQuizPageState();
// }

// class _InterestQuizPageState extends State<InterestQuizPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   double _likertRating = 3.0; // Likert Scale Slider (1-5)
//   bool _quizCompleted = false;

//   void _saveQuizResults() async {
//     String suggestedStream = _likertRating >= 4.0 ? 'Data Science & Software Engineering' : 'Digital Marketing & Management';

//     await db.collection('quiz_history').add({
//       'user_id': widget.userId,
//       'score_rating': _likertRating,
//       'suggested_stream': suggestedStream,
//       'attempted_at': FieldValue.serverTimestamp(),
//     });

//     // Increment user stat counter in database
//     await db.collection('user_stats').doc(widget.userId).set({
//       'quizzes_taken': FieldValue.increment(1),
//     }, SetOptions(merge: true));

//     setState(() => _quizCompleted = true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         scaffoldBackgroundColor: const Color(0xFFE0F2F1),
//         cardTheme: CardTheme(color: Colors.white, elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('AI Career Quiz', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           backgroundColor: const Color(0xFF00796B),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: _quizCompleted
//               ? Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(Icons.check_circle_outline, color: Color(0xFF00796B), size: 60),
//                         const SizedBox(height: 12),
//                         const Text('Quiz Completed!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                         const SizedBox(height: 8),
//                         Text('Suggested Career Stream: ${_likertRating >= 4.0 ? "Data Science & Software Engineering" : "Digital Marketing & Management"}',
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(fontSize: 16, color: Color(0xFF00796B), fontWeight: FontWeight.w600)),
//                       ],
//                     ),
//                   ),
//                 )
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Question 1 of 5 (Timed Likert Scale)', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                     const SizedBox(height: 12),
//                     const Text('How strongly do you enjoy analytical problem solving and coding logical algorithms?',
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//                     const SizedBox(height: 30),
//                     Text('Rating: ${_likertRating.toInt()} / 5', style: const TextStyle(fontWeight: FontWeight.bold)),
//                     Slider(
//                       value: _likertRating,
//                       min: 1.0,
//                       max: 5.0,
//                       divisions: 4,
//                       activeColor: const Color(0xFF00796B),
//                       onChanged: (val) => setState(() => _likertRating = val),
//                     ),
//                     const Spacer(),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B), foregroundColor: Colors.white),
//                         onPressed: _saveQuizResults,
//                         child: const Text('Submit & Save Quiz to DB'),
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class InterestQuizPage extends StatefulWidget {
//   final String userId;
//   const InterestQuizPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<InterestQuizPage> createState() => _InterestQuizPageState();
// }

// class _InterestQuizPageState extends State<InterestQuizPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   double _likertRating = 3.0; // Likert Scale Slider (1-5)
//   bool _quizCompleted = false;

//   void _saveQuizResults() async {
//     String suggestedStream = _likertRating >= 4.0 
//         ? 'Data Science & Software Engineering' 
//         : 'Digital Marketing & Management';

//     await db.collection('quiz_history').add({
//       'user_id': widget.userId,
//       'score_rating': _likertRating,
//       'suggested_stream': suggestedStream,
//       'attempted_at': FieldValue.serverTimestamp(),
//     });

//     // Increment user stat counter in database
//     await db.collection('user_stats').doc(widget.userId).set({
//       'quizzes_taken': FieldValue.increment(1),
//     }, SetOptions(merge: true));

//     setState(() => _quizCompleted = true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         useMaterial3: true,
//         scaffoldBackgroundColor: const Color(0xFFE0F2F1), // Soft Light Mint Teal
//         // Material 3 ke mutabiq CardThemeData fix kar diya gaya hai
//         cardTheme: CardThemeData(
//           color: Colors.white,
//           elevation: 2,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('AI Career Quiz', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           backgroundColor: const Color(0xFF00796B),
//           centerTitle: true,
//         ),
//         // Navigation Drawer Menu Integration
//         drawer: Drawer(
//           backgroundColor: Colors.white,
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               StreamBuilder<DocumentSnapshot>(
//                 stream: db.collection('users').doc(widget.userId).snapshots(),
//                 builder: (context, snapshot) {
//                   String name = 'PathSeeker User';
//                   String email = 'user@pathseeker.com';

//                   if (snapshot.hasData && snapshot.data!.exists) {
//                     var data = snapshot.data!.data() as Map<String, dynamic>;
//                     name = data['uname'] ?? name;
//                     email = data['email'] ?? email;
//                   }

//                   return UserAccountsDrawerHeader(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Color(0xFF00796B), Color(0xFF26A69A)],
//                       ),
//                     ),
//                     accountName: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                     accountEmail: Text(email),
//                     currentAccountPicture: const CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.person, color: Color(0xFF00796B), size: 40),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
//                 title: const Text('AI Interest Quiz', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.history, color: Color(0xFF78909C)),
//                 title: const Text('Retake / Reset Quiz'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   setState(() {
//                     _quizCompleted = false;
//                     _likertRating = 3.0;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: _quizCompleted
//               ? Center(
//                   child: Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(24.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(Icons.check_circle_outline, color: Color(0xFF00796B), size: 60),
//                           const SizedBox(height: 12),
//                           const Text('Quiz Completed!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Suggested Career Stream:\n${_likertRating >= 4.0 ? "Data Science & Software Engineering" : "Digital Marketing & Management"}',
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(fontSize: 16, color: Color(0xFF00796B), fontWeight: FontWeight.w600),
//                           ),
//                           const SizedBox(height: 20),
//                           ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF00796B),
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                             ),
//                             icon: const Icon(Icons.refresh),
//                             label: const Text('Retake Quiz'),
//                             onPressed: () {
//                               setState(() {
//                                 _quizCompleted = false;
//                                 _likertRating = 3.0;
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Question 1 of 5 (Timed Likert Scale)', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B), fontSize: 16)),
//                     const SizedBox(height: 16),
//                     Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'How strongly do you enjoy analytical problem solving and coding logical algorithms?',
//                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF004D40)),
//                             ),
//                             const SizedBox(height: 24),
//                             Text('Rating: ${_likertRating.toInt()} / 5', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                             Slider(
//                               value: _likertRating,
//                               min: 1.0,
//                               max: 5.0,
//                               divisions: 4,
//                               activeColor: const Color(0xFF00796B),
//                               inactiveColor: const Color(0xFFB2DFDB),
//                               onChanged: (val) => setState(() => _likertRating = val),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const Spacer(),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF00796B),
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.vertical(14),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         ),
//                         icon: const Icon(Icons.send),
//                         label: const Text('Submit & Save Quiz to DB', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                         onPressed: _saveQuizResults,
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }








// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class InterestQuizPage extends StatefulWidget {
//   final String userId;
//   const InterestQuizPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<InterestQuizPage> createState() => _InterestQuizPageState();
// }

// class _InterestQuizPageState extends State<InterestQuizPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   double _likertRating = 3.0; // Likert Scale Slider (1-5)
//   bool _quizCompleted = false;

//   void _saveQuizResults() async {
//     String suggestedStream = _likertRating >= 4.0 
//         ? 'Data Science & Software Engineering' 
//         : 'Digital Marketing & Management';

//     await db.collection('quiz_history').add({
//       'user_id': widget.userId,
//       'score_rating': _likertRating,
//       'suggested_stream': suggestedStream,
//       'attempted_at': FieldValue.serverTimestamp(),
//     });

//     // Increment user stat counter in database
//     await db.collection('user_stats').doc(widget.userId).set({
//       'quizzes_taken': FieldValue.increment(1),
//     }, SetOptions(merge: true));

//     setState(() => _quizCompleted = true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         useMaterial3: true,
//         scaffoldBackgroundColor: const Color(0xFFE0F2F1), // Soft Light Mint Teal
//         cardTheme: CardThemeData(
//           color: Colors.white,
//           elevation: 2,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('AI Career Quiz', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           backgroundColor: const Color(0xFF00796B),
//           centerTitle: true,
//         ),
//         drawer: Drawer(
//           backgroundColor: Colors.white,
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               StreamBuilder<DocumentSnapshot>(
//                 stream: db.collection('users').doc(widget.userId).snapshots(),
//                 builder: (context, snapshot) {
//                   String name = 'PathSeeker User';
//                   String email = 'user@pathseeker.com';

//                   if (snapshot.hasData && snapshot.data!.exists) {
//                     var data = snapshot.data!.data() as Map<String, dynamic>;
//                     name = data['name'] ?? name;
//                     email = data['email'] ?? email;
//                   }

//                   return UserAccountsDrawerHeader(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Color(0xFF00796B), Color(0xFF26A69A)],
//                       ),
//                     ),
//                     accountName: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                     accountEmail: Text(email),
//                     currentAccountPicture: const CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.person, color: Color(0xFF00796B), size: 40),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
//                 title: const Text('AI Interest Quiz', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.history, color: Color(0xFF78909C)),
//                 title: const Text('Retake / Reset Quiz'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   setState(() {
//                     _quizCompleted = false;
//                     _likertRating = 3.0;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: _quizCompleted
//               ? Center(
//                   child: Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(24.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(Icons.check_circle_outline, color: Color(0xFF00796B), size: 60),
//                           const SizedBox(height: 12),
//                           const Text('Quiz Completed!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Suggested Career Stream:\n${_likertRating >= 4.0 ? "Data Science & Software Engineering" : "Digital Marketing & Management"}',
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(fontSize: 16, color: Color(0xFF00796B), fontWeight: FontWeight.w600),
//                           ),
//                           const SizedBox(height: 20),
//                           ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF00796B),
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                             ),
//                             icon: const Icon(Icons.refresh),
//                             label: const Text('Retake Quiz'),
//                             onPressed: () {
//                               setState(() {
//                                 _quizCompleted = false;
//                                 _likertRating = 3.0;
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               // Fix: Column ko Expanded or SingleChildScrollView ke sath structure kiya gaya hai
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text('Question 1 of 5 (Timed Likert Scale)', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B), fontSize: 16)),
//                             const SizedBox(height: 16),
//                             Card(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'How strongly do you enjoy analytical problem solving and coding logical algorithms?',
//                                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF004D40)),
//                                     ),
//                                     const SizedBox(height: 24),
//                                     Text('Rating: ${_likertRating.toInt()} / 5', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                                     Slider(
//                                       value: _likertRating,
//                                       min: 1.0,
//                                       max: 5.0,
//                                       divisions: 4,
//                                       activeColor: const Color(0xFF00796B),
//                                       inactiveColor: const Color(0xFFB2DFDB),
//                                       onChanged: (val) => setState(() => _likertRating = val),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF00796B),
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         ),
//                         icon: const Icon(Icons.send),
//                         label: const Text('Submit & Save Quiz to DB', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                         onPressed: _saveQuizResults,
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }










import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/career_bank_screen.dart';
import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/feedback_analytics_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/success_stories_page.dart';

class InterestQuizPage extends StatefulWidget {
  final String userId;
  const InterestQuizPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<InterestQuizPage> createState() => _InterestQuizPageState();
}

class _InterestQuizPageState extends State<InterestQuizPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // 1. UPDATE QUESTION OPERATION
  void _showEditQuestionDialog(String docId, Map<String, dynamic> data) {
    final questionController = TextEditingController(text: data['question_text'] ?? '');
    final correctAnswerController = TextEditingController(text: data['correct_answer'] ?? '');
    final domainController = TextEditingController(text: data['domain_tag'] ?? '');
    
    List<dynamic> rawOptions = data['options'] ?? ['Yes', 'A little', 'No'];
    List<TextEditingController> optionControllers = rawOptions
        .map((opt) => TextEditingController(text: opt.toString()))
        .toList();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Quiz Question', style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: questionController,
                decoration: const InputDecoration(labelText: 'Question Text'),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: domainController,
                decoration: const InputDecoration(labelText: 'Domain Tag (e.g. Business)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: correctAnswerController,
                decoration: const InputDecoration(labelText: 'Correct Answer'),
              ),
              const SizedBox(height: 12),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Options:', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
              ),
              ...List.generate(optionControllers.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: TextField(
                    controller: optionControllers[index],
                    decoration: InputDecoration(labelText: 'Option ${index + 1}'),
                  ),
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
            onPressed: () async {
              String question = questionController.text.trim();
              String domain = domainController.text.trim();
              String correctAnswer = correctAnswerController.text.trim();
              List<String> updatedOptions = optionControllers.map((c) => c.text.trim()).toList();

              if (question.isNotEmpty) {
                await db.collection('quizQuestions').doc(docId).update({
                  'question_text': question,
                  'domain_tag': domain,
                  'correct_answer': correctAnswer,
                  'options': updatedOptions,
                });
                if (ctx.mounted) Navigator.pop(ctx);
              }
            },
            child: const Text('Update', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  // 2. DELETE QUESTION OPERATION
  Future<void> _deleteQuestion(String docId) async {
    await db.collection('quizQuestions').doc(docId).delete();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Question deleted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFE0F2F1),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Quiz Questions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF00796B),
          centerTitle: true,
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: db.collection('users').doc(widget.userId).snapshots(),
                builder: (context, snapshot) {
                  String name = 'Explorer';
                  String email = 'user@pathseeker.com';

                  if (snapshot.hasData && snapshot.data!.exists) {
                    var data = snapshot.data!.data() as Map<String, dynamic>?;
                    name = data?['name'] ?? data?['uname'] ?? 'Explorer';
                    email = data?['email'] ?? email;
                  }

                  return UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF00796B), Color(0xFF26A69A)],
                      ),
                    ),
                    accountName: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    accountEmail: Text(email),
                    currentAccountPicture: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Color(0xFF00796B), size: 40),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.dashboard_outlined, color: Color(0xFF00796B)),
                title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
                selected: true,
                selectedTileColor: const Color(0xFFE0F2F1),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
                title: const Text('Career Bank'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CareerBankPage(userId: widget.userId),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
                title: const Text('Bookmarked Careers & Saved Items'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookmarksNotesPage(userId: widget.userId),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback_outlined, color: Color(0xFF00796B)),
                title: const Text('Feedback & Suggestions'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FeedbackAnalyticsPage(userId: widget.userId),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.library_books_outlined, color: Color(0xFF00796B)),
                title: const Text('Document Library & Resources'),
                onTap: () {
                  Navigator.pop(context);
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DocumentLibraryPage(userId: widget.userId),
                    ),
                    );

                },
              ),
              ListTile(
                leading: const Icon(Icons.video_library_outlined, color: Color(0xFF00796B)),
                title: const Text('Multimedia & Explainers'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MultimediaCenterPage(userId: widget.userId),
                    ),
                    );
                },
              ),
              ListTile(
                leading: const Icon(Icons.star_outline, color: Color(0xFF00796B)),
                title: const Text('Success Stories & Testimonials'),
                onTap: () {
                  Navigator.pop(context);
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SuccessStoriesPage(userId: widget.userId),
                    ),
                    );
                },
              ),
              ListTile(
                leading: const Icon(Icons.star_outline, color: Color(0xFF00796B)),
                title: const Text('Interest Quiz & Career Assessment'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InterestQuizPage(userId: widget.userId),
                    ),
                    );
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quiz Questions (Update & Delete)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
              ),
              const SizedBox(height: 12),
              
              // READ, UPDATE & DELETE FROM quizQuestions COLLECTION
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: db.collection('quizQuestions').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('No questions found in quizQuestions database.', style: TextStyle(color: Colors.grey)),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var doc = snapshot.data!.docs[index];
                        var data = doc.data() as Map<String, dynamic>;
                        List<dynamic> options = data['options'] ?? [];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Chip(
                                      label: Text(data['domain_tag'] ?? 'General', style: const TextStyle(color: Colors.white, fontSize: 12)),
                                      backgroundColor: const Color(0xFF00796B),
                                      padding: EdgeInsets.zero,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey),
                                          onPressed: () => _showEditQuestionDialog(doc.id, data),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                          onPressed: () => _deleteQuestion(doc.id),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  data['question_text'] ?? 'No Question Text',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Correct Answer: ${data['correct_answer'] ?? 'N/A'}',
                                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 6),
                                Wrap(
                                  spacing: 6,
                                  children: options.map((opt) {
                                    return Chip(
                                      label: Text(opt.toString(), style: const TextStyle(fontSize: 12)),
                                      backgroundColor: const Color(0xFFF5F5F5),
                                    );
                                  }).toList(),
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
        ),
      ),
    );
  }
}