// <<<<<<< HEAD
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class PersonalizedDashboardPage extends StatefulWidget {
// //   final String userId;
// //   const PersonalizedDashboardPage({Key? key, required this.userId}) : super(key: key);

// //   @override
// //   State<PersonalizedDashboardPage> createState() => _PersonalizedDashboardPageState();
// // }

// // class _PersonalizedDashboardPageState extends State<PersonalizedDashboardPage> {
// //   final FirebaseFirestore db = FirebaseFirestore.instance;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Theme(
// //       data: ThemeData(
// //         scaffoldBackgroundColor: const Color(0xFFE0F2F1),
// //         cardTheme: CardThemeData(
// //           color: Colors.white, 
// //           elevation: 2, 
// //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //         ),
// //       ),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text(
// //             'PathSeeker Dashboard', 
// //             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
// //           ),
// //           backgroundColor: const Color(0xFF00796B),
// //         ),

// //         // 1. Dynamic Navigation Drawer Connected to 'users' DB
// //         drawer: Drawer(
// //           backgroundColor: Colors.white,
// //           child: ListView(
// //             padding: EdgeInsets.zero,
// //             children: [
// //               StreamBuilder<DocumentSnapshot>(
// //                 stream: db.collection('users').doc(widget.userId).snapshots(),
// //                 builder: (context, snapshot) {
// //                   String name = 'Explorer';
// //                   String email = 'user@pathseeker.com';

// //                   if (snapshot.hasData && snapshot.data!.exists) {
// //                     var data = snapshot.data!.data() as Map<String, dynamic>?;
// //                     name = data?['name'] ?? data?['uname'] ?? 'Explorer';
// //                     email = data?['email'] ?? email;
// //                   }

// //                   return UserAccountsDrawerHeader(
// //                     decoration: const BoxDecoration(
// //                       gradient: LinearGradient(
// //                         colors: [Color(0xFF00796B), Color(0xFF26A69A)],
// //                       ),
// //                     ),
// //                     accountName: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// //                     accountEmail: Text(email),
// //                     currentAccountPicture: const CircleAvatar(
// //                       backgroundColor: Colors.white,
// //                       child: Icon(Icons.person, color: Color(0xFF00796B), size: 40),
// //                     ),
// //                   );
// //                 },
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.dashboard_outlined, color: Color(0xFF00796B)),
// //                 title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
// //                 selected: true,
// //                 selectedTileColor: const Color(0xFFE0F2F1),
// //                 onTap: () => Navigator.pop(context),
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
// //                 title: const Text('Career Assessment Quiz'),
// //                 onTap: () {
// //                   Navigator.pop(context);
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => DynamicQuizPage(userId: widget.userId),
// //                     ),
// //                   );
// //                 },
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
// //                 title: const Text('Feedback & Suggestions'),
// //                 onTap: () {
// //                   Navigator.pop(context);
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => DynamicQuizPage(userId: widget.userId),
// //                     ),
// //                   );
// //                 },
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
// //                 title: const Text('Document Library & Resources'),
// //                 onTap: () {
// //                   Navigator.pop(context);
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => DynamicQuizPage(userId: widget.userId),
// //                     ),
// //                   );
// //                 },
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
// //                 title: const Text('Quizzes & Multimedia Center'),
// //                 onTap: () {
// //                   Navigator.pop(context);
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => DynamicQuizPage(userId: widget.userId),
// //                     ),
// //                   );
// //                 },
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
// //                 title: const Text('Multimedia & Explainers'),
// //                 onTap: () {
// //                   Navigator.pop(context);
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => DynamicQuizPage(userId: widget.userId),
// //                     ),
// //                   );
// //                 },
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
// //                 title: const Text('Success Stories & Testimonials'),
// //                 onTap: () {
// //                   Navigator.pop(context);
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => DynamicQuizPage(userId: widget.userId),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),

// //         body: SingleChildScrollView(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // Personalized Greeting Card
// //               StreamBuilder<DocumentSnapshot>(
// //                 stream: db.collection('users').doc(widget.userId).snapshots(),
// //                 builder: (context, snapshot) {
// //                   String name = snapshot.data?.get('name') ?? snapshot.data?.get('uname') ?? 'Explorer';
// //                   return Container(
// //                     width: double.infinity,
// //                     padding: const EdgeInsets.all(20),
// //                     decoration: BoxDecoration(
// //                       gradient: const LinearGradient(
// //                         colors: [Color(0xFF00796B), Color(0xFF26A69A)],
// //                       ),
// //                       borderRadius: BorderRadius.circular(16),
// //                     ),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           'Welcome back, $name!', 
// //                           style: const TextStyle(
// //                             color: Colors.white, 
// //                             fontSize: 22, 
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 6),
// //                         const Text(
// //                           'Here is your career progression overview.', 
// //                           style: TextStyle(color: Colors.white70, fontSize: 14),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               ),
// //               const SizedBox(height: 20),

// //               // Dynamic Activity Stats
// //               const Text(
// //                 'Activity & Results Summary', 
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
// //               ),
// //               const SizedBox(height: 10),
// //              // Dynamic Activity Stats (Fixed with null and existence check)
// // StreamBuilder<DocumentSnapshot>(
// //   stream: db.collection('user_stats').doc(widget.userId).snapshots(),
// //   builder: (context, snapshot) {
// //     int quizzes = 0;
// //     int saved = 0;

// //     // Direct .get() use karne ke bajaye snapshots ki existence check ki gayi hai
// //     if (snapshot.hasData && snapshot.data!.exists) {
// //       var data = snapshot.data!.data() as Map<String, dynamic>?;
// //       if (data != null) {
// //         quizzes = data['quizzes_taken'] ?? 0;
// //         saved = data['saved_careers_count'] ?? 0;
// //       }
// //     }

// //     return Row(
// //       children: [
// //         Expanded(child: _buildStatTile('Quizzes Taken', '$quizzes', Icons.quiz_outlined)),
// //         const SizedBox(width: 12),
// //         Expanded(child: _buildStatTile('Saved Items', '$saved', Icons.bookmark_added_outlined)),
// //       ],
// //     );
// //   },
// // ),
// //               const SizedBox(height: 20),

// //               // Trending Careers Widget
// //               const Text(
// //                 'Trending Careers For You', 
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
// //               ),
// //               const SizedBox(height: 10),
// //               StreamBuilder<QuerySnapshot>(
// //                 stream: db.collection('careers').limit(3).snapshots(),
// //                 builder: (context, snapshot) {
// //                   if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
// //                   return Column(
// //                     children: snapshot.data!.docs.map((doc) {
// //                       var data = doc.data() as Map<String, dynamic>;
// //                       return Card(
// //                         margin: const EdgeInsets.only(bottom: 10),
// //                         child: ListTile(
// //                           leading: const CircleAvatar(
// //                             backgroundColor: Color(0xFFB2DFDB),
// //                             child: Icon(Icons.work_outline, color: Color(0xFF00796B)),
// //                           ),
// //                           title: Text(
// //                             data['title'] ?? 'Career Role', 
// //                             style: const TextStyle(fontWeight: FontWeight.bold),
// //                           ),
// //                           subtitle: Text('${data['domain'] ?? 'N/A'} | Salary: ${data['expected_salary'] ?? 'N/A'}'),
// //                           trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF00796B)),
// //                         ),
// //                       );
// //                     }).toList(),
// //                   );
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildStatTile(String title, String count, IconData icon) {
// //     return Card(
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             Icon(icon, color: const Color(0xFF00796B), size: 30),
// //             const SizedBox(height: 8),
// //             Text(
// //               count, 
// //               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
// //             ),
// //             Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // 2. Dynamic Career Quiz Page with Real-time DB Fetch & Save
// // class DynamicQuizPage extends StatefulWidget {
// //   final String userId;
// //   const DynamicQuizPage({Key? key, required this.userId}) : super(key: key);

// //   @override
// //   State<DynamicQuizPage> createState() => _DynamicQuizPageState();
// // }

// // class _DynamicQuizPageState extends State<DynamicQuizPage> {
// //   final FirebaseFirestore db = FirebaseFirestore.instance;
// //   int currentQuestionIndex = 0;
// //   int totalScore = 0;

// //   void saveQuizResult(int finalScore) async {
// //     // Write result to 'quiz_results' collection
// //     await db.collection('quiz_results').add({
// //       'user_id': widget.userId,
// //       'score': finalScore,
// //       'recommended_domain': finalScore > 10 ? 'Technology' : 'Business',
// //       'taken_at': FieldValue.serverTimestamp(),
// //     });

// //     // Update 'user_stats' count
// //     await db.collection('user_stats').doc(widget.userId).set({
// //       'quizzes_taken': FieldValue.increment(1),
// //     }, SetOptions(merge: true));

// //     if (!mounted) return;
// //     showDialog(
// //       context: context,
// //       builder: (_) => AlertDialog(
// //         title: const Text('Quiz Completed!'),
// //         content: Text('Your Score: $finalScore\nResult saved to Database successfully.'),
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               Navigator.pop(context);
// //               Navigator.pop(context);
// //             },
// //             child: const Text('OK'),
// //           )
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFE0F2F1),
// //       appBar: AppBar(
// //         title: const Text('Career Assessment Quiz', style: TextStyle(color: Colors.white)),
// //         backgroundColor: const Color(0xFF00796B),
// //       ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: db.collection('quizzes').snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //             return const Center(
// //               child: Padding(
// //                 padding: EdgeInsets.all(16.0),
// //                 child: Text(
// //                   'No quiz questions found in Database.\nAdd documents in "quizzes" collection.',
// //                   textAlign: TextAlign.center,
// //                   style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
// //                 ),
// //               ),
// //             );
// //           }

// //           var questions = snapshot.data!.docs;
// //           if (currentQuestionIndex >= questions.length) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           var currentQuestion = questions[currentQuestionIndex].data() as Map<String, dynamic>;
// //           List options = currentQuestion['options'] ?? [];

// //           return Padding(
// //             padding: const EdgeInsets.all(20.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.stretch,
// //               children: [
// //                 Text(
// //                   'Question ${currentQuestionIndex + 1} of ${questions.length}',
// //                   style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
// //                 ),
// //                 const SizedBox(height: 12),
// //                 Text(
// //                   currentQuestion['question'] ?? 'Sample Question',
// //                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
// //                 ),
// //                 const SizedBox(height: 20),
// //                 ...options.map((opt) {
// //                   return Container(
// //                     margin: const EdgeInsets.only(bottom: 10),
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.white,
// //                         foregroundColor: const Color(0xFF00796B),
// //                         padding: const EdgeInsets.symmetric(vertical: 14),
// //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //                       ),
// //                       onPressed: () {
// //                         int score = opt['score'] ?? 5;
// //                         totalScore += score;

// //                         if (currentQuestionIndex + 1 < questions.length) {
// //                           setState(() {
// //                             currentQuestionIndex++;
// //                           });
// //                         } else {
// //                           saveQuizResult(totalScore);
// //                         }
// //                       },
// //                       child: Text(opt['text'] ?? 'Option', style: const TextStyle(fontSize: 16)),
// //                     ),
// //                   );
// //                 }).toList(),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/career_bank_screen.dart';
// import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
// import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/success_stories_page.dart';

// class PersonalizedDashboardPage extends StatefulWidget {
//   final String userId;
//   const PersonalizedDashboardPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<PersonalizedDashboardPage> createState() => _PersonalizedDashboardPageState();
// }

// class _PersonalizedDashboardPageState extends State<PersonalizedDashboardPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         scaffoldBackgroundColor: const Color(0xFFE0F2F1),
//         cardTheme: CardThemeData(
//           color: Colors.white, 
//           elevation: 2, 
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'PathSeeker Dashboard', 
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           backgroundColor: const Color(0xFF00796B),
//         ),

//         // 1. Dynamic Navigation Drawer Connected to 'users' DB
//         drawer: Drawer(
//           backgroundColor: Colors.white,
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               StreamBuilder<DocumentSnapshot>(
//                 stream: db.collection('users').doc(widget.userId).snapshots(),
//                 builder: (context, snapshot) {
//                   String name = 'Explorer';
//                   String email = 'user@pathseeker.com';

//                   if (snapshot.hasData && snapshot.data!.exists) {
//                     var data = snapshot.data!.data() as Map<String, dynamic>?;
//                     name = data?['name'] ?? data?['uname'] ?? 'Explorer';
//                     email = data?['email'] ?? email;
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
//                 leading: const Icon(Icons.dashboard_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Career Bank'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => CareerBankPage(userId: widget.userId),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Bookmarked Careers & Saved Items'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => BookmarksNotesPage(userId: widget.userId),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.feedback_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Feedback & Suggestions'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _showSimplePage(context, 'Feedback & Suggestions');
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.library_books_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Document Library & Resources'),
//                 onTap: () {
//                   Navigator.pop(context);
//                  Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DocumentLibraryPage(userId: widget.userId),
//                     ),
//                     );

//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.video_library_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Multimedia & Explainers'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => MultimediaCenterPage(userId: widget.userId),
//                     ),
//                     );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.star_outline, color: Color(0xFF00796B)),
//                 title: const Text('Success Stories & Testimonials'),
//                 onTap: () {
//                   Navigator.pop(context);
//                  Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => SuccessStoriesPage(userId: widget.userId),
//                     ),
//                     );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.star_outline, color: Color(0xFF00796B)),
//                 title: const Text('Interest Quiz & Career Assessment'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => InterestQuizPage(userId: widget.userId),
//                     ),
//                     );
//                 },
//               ),
//             ],
//           ),
//         ),

//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Personalized Greeting Card
//               StreamBuilder<DocumentSnapshot>(
//                 stream: db.collection('users').doc(widget.userId).snapshots(),
//                 builder: (context, snapshot) {
//                   String name = snapshot.data?.get('name') ?? snapshot.data?.get('uname') ?? 'Explorer';
//                   return Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF00796B), Color(0xFF26A69A)],
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
// =======
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:myapp/screens/auth/login_screen.dart';

// class ProfessionalDashboard extends StatelessWidget {
//   const ProfessionalDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FB),

//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: const Color(0xFF172033),
//         title: const Text(
//           'Professional Hub',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//   IconButton(
//     icon: const Icon(Icons.notifications_none_rounded),
//     onPressed: () {},
//   ),

//   IconButton(
//     icon: const Icon(
//       Icons.logout_rounded,
//       color: Colors.red,
//     ),
//     tooltip: 'Logout',
//     onPressed: () async {
//       final shouldLogout = await showDialog<bool>(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Logout'),
//             content: const Text(
//               'Are you sure you want to logout?',
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context, false);
//                 },
//                 child: const Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context, true);
//                 },
//                 child: const Text('Logout'),
//               ),
//             ],
//           );
//         },
//       );

//       if (shouldLogout == true) {
//         await FirebaseAuth.instance.signOut();

//         if (!context.mounted) return;

//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (_) => const LoginScreen(),
//           ),
//           (route) => false,
//         );
//       }
//     },
//   ),

//   const SizedBox(width: 8),
// ],
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             // Welcome Section
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(22),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color(0xFF3654E0),
//                     Color(0xFF6278E8),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.workspace_premium_rounded,
//                     color: Colors.white,
//                     size: 38,
//                   ),

//                   SizedBox(height: 15),

//                   Text(
//                     'Welcome, Professional 👋',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   SizedBox(height: 8),

//                   Text(
//                     'Build your career, discover opportunities and grow professionally.',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                       height: 1.4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 25),

//             const Text(
//               'Career Overview',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF172033),
//               ),
//             ),

//             const SizedBox(height: 15),

//             // Statistics
//             Row(
//               children: [
//                 Expanded(
//                   child: _statCard(
//                     icon: Icons.work_outline_rounded,
//                     title: 'Applications',
//                     value: '12',
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: _statCard(
//                     icon: Icons.event_available_rounded,
//                     title: 'Interviews',
//                     value: '04',
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),

//             Row(
//               children: [
//                 Expanded(
//                   child: _statCard(
//                     icon: Icons.bookmark_outline_rounded,
//                     title: 'Saved Jobs',
//                     value: '08',
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: _statCard(
//                     icon: Icons.auto_graph_rounded,
//                     title: 'Profile Score',
//                     value: '82%',
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),

//             // Profile Strength
//             const Text(
//               'Profile Strength',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF172033),
//               ),
//             ),

//             const SizedBox(height: 12),

//             Container(
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.04),
//                     blurRadius: 12,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text(
//                         'Your profile is 82% complete',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         '82%',
//                         style: TextStyle(
//                           color: Color(0xFF3654E0),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 12),

//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: const LinearProgressIndicator(
//                       value: 0.82,
//                       minHeight: 9,
//                       backgroundColor: Color(0xFFE5E9F5),
//                       valueColor: AlwaysStoppedAnimation(
//                         Color(0xFF3654E0),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   const Text(
//                     'Add certifications and update your skills to improve your profile.',
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Color(0xFF697386),
//                     ),
//                   ),

//                   const SizedBox(height: 15),

//                   OutlinedButton(
//                     onPressed: () {},
//                     child: const Text('Complete Profile'),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 28),

//             // Quick Actions
//             const Text(
//               'Professional Tools',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF172033),
//               ),
//             ),

//             const SizedBox(height: 15),

//             GridView.count(
//               crossAxisCount: 2,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//               childAspectRatio: 1.25,
//               children: [
//                 _actionCard(
//                   icon: Icons.search_rounded,
//                   title: 'Find Jobs',
//                   subtitle: 'Explore opportunities',
//                   onTap: () {},
//                 ),

//                 _actionCard(
//                   icon: Icons.description_outlined,
//                   title: 'My Applications',
//                   subtitle: 'Track applications',
//                   onTap: () {},
//                 ),

//                 _actionCard(
//                   icon: Icons.psychology_outlined,
//                   title: 'Skills',
//                   subtitle: 'Improve your skills',
//                   onTap: () {},
//                 ),

//                 _actionCard(
//                   icon: Icons.school_outlined,
//                   title: 'Certifications',
//                   subtitle: 'Manage certificates',
//                   onTap: () {},
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),

//             // Career Insight
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEEF2FF),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.lightbulb_outline_rounded,
//                     color: Color(0xFF3654E0),
//                     size: 30,
//                   ),

//                   SizedBox(width: 14),

//                   Expanded(
// >>>>>>> 831d2b4087552cf0e5078b2e7a119c4f75cfd1fc
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
// <<<<<<< HEAD
//                           'Welcome back, $name!', 
//                           style: const TextStyle(
//                             color: Colors.white, 
//                             fontSize: 22, 
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         const Text(
//                           'Here is your career progression overview.', 
//                           style: TextStyle(color: Colors.white70, fontSize: 14),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),

//               // Dynamic Activity Stats
//               const Text(
//                 'Activity & Results Summary', 
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//               ),
//               const SizedBox(height: 10),
//               StreamBuilder<DocumentSnapshot>(
//                 stream: db.collection('user_stats').doc(widget.userId).snapshots(),
//                 builder: (context, snapshot) {
//                   int quizzes = 0;
//                   int saved = 0;

//                   if (snapshot.hasData && snapshot.data!.exists) {
//                     var data = snapshot.data!.data() as Map<String, dynamic>?;
//                     if (data != null) {
//                       quizzes = data['quizzes_taken'] ?? 0;
//                       saved = data['saved_careers_count'] ?? 0;
//                     }
//                   }

//                   return Row(
//                     children: [
//                       Expanded(child: _buildStatTile('Quizzes Taken', '$quizzes', Icons.quiz_outlined)),
//                       const SizedBox(width: 12),
//                       Expanded(child: _buildStatTile('Saved Items', '$saved', Icons.bookmark_added_outlined)),
//                     ],
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),

//               // Trending Careers Widget
//               const Text(
//                 'Trending Careers For You', 
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//               ),
//               const SizedBox(height: 10),
//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('careers').limit(3).snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//                   return Column(
//                     children: snapshot.data!.docs.map((doc) {
//                       var data = doc.data() as Map<String, dynamic>;
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             backgroundColor: Color(0xFFB2DFDB),
//                             child: Icon(Icons.work_outline, color: Color(0xFF00796B)),
//                           ),
//                           title: Text(
//                             data['title'] ?? 'Career Role', 
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Text('${data['domain'] ?? 'N/A'} | Salary: ${data['expected_salary'] ?? 'N/A'}'),
//                           trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF00796B)),
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showSimplePage(BuildContext context, String title) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => Scaffold(
//           backgroundColor: const Color(0xFFE0F2F1),
//           appBar: AppBar(
//             title: Text(title, style: const TextStyle(color: Colors.white)),
//             backgroundColor: const Color(0xFF00796B),
//           ),
//           body: Center(
//             child: Text(
//               '$title Page',
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatTile(String title, String count, IconData icon) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Icon(icon, color: const Color(0xFF00796B), size: 30),
//             const SizedBox(height: 8),
//             Text(
//               count, 
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//             ),
//             Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
// =======
//                           'Career Insight',
//                           style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF172033),
//                           ),
//                         ),

//                         SizedBox(height: 6),

//                         Text(
//                           'Keep your profile updated and add relevant skills to increase your chances of getting noticed by employers.',
//                           style: TextStyle(
//                             color: Color(0xFF697386),
//                             height: 1.4,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 25),
// >>>>>>> 831d2b4087552cf0e5078b2e7a119c4f75cfd1fc
//           ],
//         ),
//       ),
//     );
//   }
// <<<<<<< HEAD
// }

// // 2. Dynamic Career Quiz Page with Real-time DB Fetch & Save
// class DynamicQuizPage extends StatefulWidget {
//   final String userId;
//   const DynamicQuizPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<DynamicQuizPage> createState() => _DynamicQuizPageState();
// }

// class _DynamicQuizPageState extends State<DynamicQuizPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   int currentQuestionIndex = 0;
//   int totalScore = 0;

//   void saveQuizResult(int finalScore) async {
//     await db.collection('quiz_results').add({
//       'user_id': widget.userId,
//       'score': finalScore,
//       'recommended_domain': finalScore > 10 ? 'Technology' : 'Business',
//       'taken_at': FieldValue.serverTimestamp(),
//     });

//     await db.collection('user_stats').doc(widget.userId).set({
//       'quizzes_taken': FieldValue.increment(1),
//     }, SetOptions(merge: true));

//     if (!mounted) return;
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Quiz Completed!'),
//         content: Text('Your Score: $finalScore\nResult saved to Database successfully.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pop(context);
//             },
//             child: const Text('OK'),
//           )
// =======

//   static Widget _statCard({
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.035),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             icon,
//             color: const Color(0xFF3654E0),
//             size: 27,
//           ),

//           const SizedBox(height: 14),

//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 23,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF172033),
//             ),
//           ),

//           const SizedBox(height: 4),

//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Color(0xFF697386),
//             ),
//           ),
// >>>>>>> 831d2b4087552cf0e5078b2e7a119c4f75cfd1fc
//         ],
//       ),
//     );
//   }

// <<<<<<< HEAD
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE0F2F1),
//       appBar: AppBar(
//         title: const Text('Career Assessment Quiz', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF00796B),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: db.collection('quizzes').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'No quiz questions found in Database.\nAdd documents in "quizzes" collection.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//                 ),
//               ),
//             );
//           }

//           var questions = snapshot.data!.docs;
//           if (currentQuestionIndex >= questions.length) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           var currentQuestion = questions[currentQuestionIndex].data() as Map<String, dynamic>;
//           List options = currentQuestion['options'] ?? [];

//           return Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Question ${currentQuestionIndex + 1} of ${questions.length}',
//                   style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   currentQuestion['question'] ?? 'Sample Question',
//                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//                 ),
//                 const SizedBox(height: 20),
//                 ...options.map((opt) {
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 10),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: const Color(0xFF00796B),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                       onPressed: () {
//                         int score = opt['score'] ?? 5;
//                         totalScore += score;

//                         if (currentQuestionIndex + 1 < questions.length) {
//                           setState(() {
//                             currentQuestionIndex++;
//                           });
//                         } else {
//                           saveQuizResult(totalScore);
//                         }
//                       },
//                       child: Text(opt['text'] ?? 'Option', style: const TextStyle(fontSize: 16)),
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }






// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class PersonalizedDashboardPage extends StatefulWidget {
// //   final String userId;
// //   const PersonalizedDashboardPage({Key? key, required this.userId}) : super(key: key);

// //   @override
// //   State<PersonalizedDashboardPage> createState() => _PersonalizedDashboardPageState();
// // }

// // class _PersonalizedDashboardPageState extends State<PersonalizedDashboardPage> {
// //   final FirebaseFirestore db = FirebaseFirestore.instance;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Theme(
// //       data: ThemeData(
// //         scaffoldBackgroundColor: const Color(0xFFE0F2F1),
// //         // CardTheme ki jagah CardThemeData use kiya h error resolve karne ke liye
// //         cardTheme: CardThemeData(
// //           color: Colors.white, 
// //           elevation: 2, 
// //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //         ),
// //       ),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text(
// //             'PathSeeker Dashboard', 
// //             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
// //           ),
// //           backgroundColor: const Color(0xFF00796B),
// //         ),
// //         body: SingleChildScrollView(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // Personalized Greeting Card
// //               StreamBuilder<DocumentSnapshot>(
// //                 stream: db.collection('users').doc(widget.userId).snapshots(),
// //                 builder: (context, snapshot) {
// //                   String name = snapshot.data?.get('name') ?? 'Explorer';
// //                   return Container(
// //                     width: double.infinity,
// //                     padding: const EdgeInsets.all(20),
// //                     decoration: BoxDecoration(
// //                       gradient: const LinearGradient(
// //                         colors: [Color(0xFF00796B), Color(0xFF26A69A)],
// //                       ),
// //                       borderRadius: BorderRadius.circular(16),
// //                     ),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           'Welcome back, $name!', 
// //                           style: const TextStyle(
// //                             color: Colors.white, 
// //                             fontSize: 22, 
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 6),
// //                         const Text(
// //                           'Here is your career progression overview.', 
// //                           style: TextStyle(color: Colors.white70, fontSize: 14),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               ),
// //               const SizedBox(height: 20),

// //               // Dynamic Activity Stats
// //               const Text(
// //                 'Activity & Results Summary', 
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
// //               ),
// //               const SizedBox(height: 10),
// //               StreamBuilder<DocumentSnapshot>(
// //                 stream: db.collection('user_stats').doc(widget.userId).snapshots(),
// //                 builder: (context, snapshot) {
// //                   int quizzes = snapshot.data?.get('quizzes_taken') ?? 0;
// //                   int saved = snapshot.data?.get('saved_careers_count') ?? 0;
// //                   return Row(
// //                     children: [
// //                       Expanded(child: _buildStatTile('Quizzes Taken', '$quizzes', Icons.quiz_outlined)),
// //                       const SizedBox(width: 12),
// //                       Expanded(child: _buildStatTile('Saved Items', '$saved', Icons.bookmark_added_outlined)),
// //                     ],
// //                   );
// //                 },
// //               ),
// //               const SizedBox(height: 20),

// //               // Trending Careers Widget
// //               const Text(
// //                 'Trending Careers For You', 
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
// //               ),
// //               const SizedBox(height: 10),
// //               StreamBuilder<QuerySnapshot>(
// //                 stream: db.collection('careers').limit(3).snapshots(),
// //                 builder: (context, snapshot) {
// //                   if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
// //                   return Column(
// //                     children: snapshot.data!.docs.map((doc) {
// //                       var data = doc.data() as Map<String, dynamic>;
// //                       return Card(
// //                         margin: const EdgeInsets.only(bottom: 10),
// //                         child: ListTile(
// //                           leading: const CircleAvatar(
// //                             backgroundColor: Color(0xFFB2DFDB),
// //                             child: Icon(Icons.work_outline, color: Color(0xFF00796B)),
// //                           ),
// //                           title: Text(
// //                             data['title'] ?? 'Career Role', 
// //                             style: const TextStyle(fontWeight: FontWeight.bold),
// //                           ),
// //                           subtitle: Text('${data['domain']} | Salary: ${data['expected_salary']}'),
// //                           trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF00796B)),
// //                         ),
// //                       );
// //                     }).toList(),
// //                   );
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildStatTile(String title, String count, IconData icon) {
// //     return Card(
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             Icon(icon, color: const Color(0xFF00796B), size: 30),
// //             const SizedBox(height: 8),
// //             Text(
// //               count, 
// //               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
// //             ),
// //             Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// =======
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
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEEF2FF),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 icon,
//                 color: const Color(0xFF3654E0),
//                 size: 25,
//               ),
//             ),

//             const SizedBox(height: 12),

//             Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
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
// }
// >>>>>>> 831d2b4087552cf0e5078b2e7a119c4f75cfd1fc




// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PersonalizedDashboardPage extends StatefulWidget {
//   final String userId;
//   const PersonalizedDashboardPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<PersonalizedDashboardPage> createState() => _PersonalizedDashboardPageState();
// }

// class _PersonalizedDashboardPageState extends State<PersonalizedDashboardPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         scaffoldBackgroundColor: const Color(0xFFE0F2F1),
//         cardTheme: CardThemeData(
//           color: Colors.white, 
//           elevation: 2, 
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'PathSeeker Dashboard', 
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           backgroundColor: const Color(0xFF00796B),
//         ),

//         // 1. Dynamic Navigation Drawer Connected to 'users' DB
//         drawer: Drawer(
//           backgroundColor: Colors.white,
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               StreamBuilder<DocumentSnapshot>(
//                 stream: db.collection('users').doc(widget.userId).snapshots(),
//                 builder: (context, snapshot) {
//                   String name = 'Explorer';
//                   String email = 'user@pathseeker.com';

//                   if (snapshot.hasData && snapshot.data!.exists) {
//                     var data = snapshot.data!.data() as Map<String, dynamic>?;
//                     name = data?['name'] ?? data?['uname'] ?? 'Explorer';
//                     email = data?['email'] ?? email;
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
//                 leading: const Icon(Icons.dashboard_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Career Assessment Quiz'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DynamicQuizPage(userId: widget.userId),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Feedback & Suggestions'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DynamicQuizPage(userId: widget.userId),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Document Library & Resources'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DynamicQuizPage(userId: widget.userId),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Quizzes & Multimedia Center'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DynamicQuizPage(userId: widget.userId),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Multimedia & Explainers'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DynamicQuizPage(userId: widget.userId),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Success Stories & Testimonials'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DynamicQuizPage(userId: widget.userId),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),

//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Personalized Greeting Card
//               StreamBuilder<DocumentSnapshot>(
//                 stream: db.collection('users').doc(widget.userId).snapshots(),
//                 builder: (context, snapshot) {
//                   String name = snapshot.data?.get('name') ?? snapshot.data?.get('uname') ?? 'Explorer';
//                   return Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF00796B), Color(0xFF26A69A)],
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Welcome back, $name!', 
//                           style: const TextStyle(
//                             color: Colors.white, 
//                             fontSize: 22, 
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         const Text(
//                           'Here is your career progression overview.', 
//                           style: TextStyle(color: Colors.white70, fontSize: 14),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),

//               // Dynamic Activity Stats
//               const Text(
//                 'Activity & Results Summary', 
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//               ),
//               const SizedBox(height: 10),
//              // Dynamic Activity Stats (Fixed with null and existence check)
// StreamBuilder<DocumentSnapshot>(
//   stream: db.collection('user_stats').doc(widget.userId).snapshots(),
//   builder: (context, snapshot) {
//     int quizzes = 0;
//     int saved = 0;

//     // Direct .get() use karne ke bajaye snapshots ki existence check ki gayi hai
//     if (snapshot.hasData && snapshot.data!.exists) {
//       var data = snapshot.data!.data() as Map<String, dynamic>?;
//       if (data != null) {
//         quizzes = data['quizzes_taken'] ?? 0;
//         saved = data['saved_careers_count'] ?? 0;
//       }
//     }

//     return Row(
//       children: [
//         Expanded(child: _buildStatTile('Quizzes Taken', '$quizzes', Icons.quiz_outlined)),
//         const SizedBox(width: 12),
//         Expanded(child: _buildStatTile('Saved Items', '$saved', Icons.bookmark_added_outlined)),
//       ],
//     );
//   },
// ),
//               const SizedBox(height: 20),

//               // Trending Careers Widget
//               const Text(
//                 'Trending Careers For You', 
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//               ),
//               const SizedBox(height: 10),
//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('careers').limit(3).snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//                   return Column(
//                     children: snapshot.data!.docs.map((doc) {
//                       var data = doc.data() as Map<String, dynamic>;
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             backgroundColor: Color(0xFFB2DFDB),
//                             child: Icon(Icons.work_outline, color: Color(0xFF00796B)),
//                           ),
//                           title: Text(
//                             data['title'] ?? 'Career Role', 
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Text('${data['domain'] ?? 'N/A'} | Salary: ${data['expected_salary'] ?? 'N/A'}'),
//                           trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF00796B)),
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatTile(String title, String count, IconData icon) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Icon(icon, color: const Color(0xFF00796B), size: 30),
//             const SizedBox(height: 8),
//             Text(
//               count, 
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//             ),
//             Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // 2. Dynamic Career Quiz Page with Real-time DB Fetch & Save
// class DynamicQuizPage extends StatefulWidget {
//   final String userId;
//   const DynamicQuizPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<DynamicQuizPage> createState() => _DynamicQuizPageState();
// }

// class _DynamicQuizPageState extends State<DynamicQuizPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   int currentQuestionIndex = 0;
//   int totalScore = 0;

//   void saveQuizResult(int finalScore) async {
//     // Write result to 'quiz_results' collection
//     await db.collection('quiz_results').add({
//       'user_id': widget.userId,
//       'score': finalScore,
//       'recommended_domain': finalScore > 10 ? 'Technology' : 'Business',
//       'taken_at': FieldValue.serverTimestamp(),
//     });

//     // Update 'user_stats' count
//     await db.collection('user_stats').doc(widget.userId).set({
//       'quizzes_taken': FieldValue.increment(1),
//     }, SetOptions(merge: true));

//     if (!mounted) return;
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Quiz Completed!'),
//         content: Text('Your Score: $finalScore\nResult saved to Database successfully.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pop(context);
//             },
//             child: const Text('OK'),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFE0F2F1),
//       appBar: AppBar(
//         title: const Text('Career Assessment Quiz', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF00796B),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: db.collection('quizzes').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'No quiz questions found in Database.\nAdd documents in "quizzes" collection.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//                 ),
//               ),
//             );
//           }

//           var questions = snapshot.data!.docs;
//           if (currentQuestionIndex >= questions.length) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           var currentQuestion = questions[currentQuestionIndex].data() as Map<String, dynamic>;
//           List options = currentQuestion['options'] ?? [];

//           return Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Question ${currentQuestionIndex + 1} of ${questions.length}',
//                   style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   currentQuestion['question'] ?? 'Sample Question',
//                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//                 ),
//                 const SizedBox(height: 20),
//                 ...options.map((opt) {
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 10),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: const Color(0xFF00796B),
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                       onPressed: () {
//                         int score = opt['score'] ?? 5;
//                         totalScore += score;

//                         if (currentQuestionIndex + 1 < questions.length) {
//                           setState(() {
//                             currentQuestionIndex++;
//                           });
//                         } else {
//                           saveQuizResult(totalScore);
//                         }
//                       },
//                       child: Text(opt['text'] ?? 'Option', style: const TextStyle(fontSize: 16)),
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/career_bank_screen.dart';
import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/success_stories_page.dart';

class PersonalizedDashboardPage extends StatefulWidget {
  final String userId;
  const PersonalizedDashboardPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<PersonalizedDashboardPage> createState() => _PersonalizedDashboardPageState();
}

class _PersonalizedDashboardPageState extends State<PersonalizedDashboardPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE0F2F1),
        cardTheme: CardThemeData(
          color: Colors.white, 
          elevation: 2, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'PathSeeker Dashboard', 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF00796B),
        ),

        // 1. Dynamic Navigation Drawer Connected to 'users' DB
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
                  _showSimplePage(context, 'Feedback & Suggestions');
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

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personalized Greeting Card
              StreamBuilder<DocumentSnapshot>(
                stream: db.collection('users').doc(widget.userId).snapshots(),
                builder: (context, snapshot) {
                  String name = snapshot.data?.get('name') ?? snapshot.data?.get('uname') ?? 'Explorer';
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00796B), Color(0xFF26A69A)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, $name!', 
                          style: const TextStyle(
                            color: Colors.white, 
                            fontSize: 22, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Here is your career progression overview.', 
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Dynamic Activity Stats
              const Text(
                'Activity & Results Summary', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
              ),
              const SizedBox(height: 10),
              StreamBuilder<DocumentSnapshot>(
                stream: db.collection('user_stats').doc(widget.userId).snapshots(),
                builder: (context, snapshot) {
                  int quizzes = 0;
                  int saved = 0;

                  if (snapshot.hasData && snapshot.data!.exists) {
                    var data = snapshot.data!.data() as Map<String, dynamic>?;
                    if (data != null) {
                      quizzes = data['quizzes_taken'] ?? 0;
                      saved = data['saved_careers_count'] ?? 0;
                    }
                  }

                  return Row(
                    children: [
                      Expanded(child: _buildStatTile('Quizzes Taken', '$quizzes', Icons.quiz_outlined)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatTile('Saved Items', '$saved', Icons.bookmark_added_outlined)),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // Trending Careers Widget
              const Text(
                'Trending Careers For You', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
              ),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: db.collection('careers').limit(3).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFB2DFDB),
                            child: Icon(Icons.work_outline, color: Color(0xFF00796B)),
                          ),
                          title: Text(
                            data['title'] ?? 'Career Role', 
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${data['domain'] ?? 'N/A'} | Salary: ${data['expected_salary'] ?? 'N/A'}'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF00796B)),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSimplePage(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: const Color(0xFFE0F2F1),
          appBar: AppBar(
            title: Text(title, style: const TextStyle(color: Colors.white)),
            backgroundColor: const Color(0xFF00796B),
          ),
          body: Center(
            child: Text(
              '$title Page',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatTile(String title, String count, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF00796B), size: 30),
            const SizedBox(height: 8),
            Text(
              count, 
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
            ),
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// 2. Dynamic Career Quiz Page with Real-time DB Fetch & Save
class DynamicQuizPage extends StatefulWidget {
  final String userId;
  const DynamicQuizPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<DynamicQuizPage> createState() => _DynamicQuizPageState();
}

class _DynamicQuizPageState extends State<DynamicQuizPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  int currentQuestionIndex = 0;
  int totalScore = 0;

  void saveQuizResult(int finalScore) async {
    await db.collection('quiz_results').add({
      'user_id': widget.userId,
      'score': finalScore,
      'recommended_domain': finalScore > 10 ? 'Technology' : 'Business',
      'taken_at': FieldValue.serverTimestamp(),
    });

    await db.collection('user_stats').doc(widget.userId).set({
      'quizzes_taken': FieldValue.increment(1),
    }, SetOptions(merge: true));

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text('Your Score: $finalScore\nResult saved to Database successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1),
      appBar: AppBar(
        title: const Text('Career Assessment Quiz', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('quizzes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No quiz questions found in Database.\nAdd documents in "quizzes" collection.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                ),
              ),
            );
          }

          var questions = snapshot.data!.docs;
          if (currentQuestionIndex >= questions.length) {
            return const Center(child: CircularProgressIndicator());
          }

          var currentQuestion = questions[currentQuestionIndex].data() as Map<String, dynamic>;
          List options = currentQuestion['options'] ?? [];

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Question ${currentQuestionIndex + 1} of ${questions.length}',
                  style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  currentQuestion['question'] ?? 'Sample Question',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                ),
                const SizedBox(height: 20),
                ...options.map((opt) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF00796B),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        int score = opt['score'] ?? 5;
                        totalScore += score;

                        if (currentQuestionIndex + 1 < questions.length) {
                          setState(() {
                            currentQuestionIndex++;
                          });
                        } else {
                          saveQuizResult(totalScore);
                        }
                      },
                      child: Text(opt['text'] ?? 'Option', style: const TextStyle(fontSize: 16)),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class PersonalizedDashboardPage extends StatefulWidget {
//   final String userId;
//   const PersonalizedDashboardPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<PersonalizedDashboardPage> createState() => _PersonalizedDashboardPageState();
// }

// class _PersonalizedDashboardPageState extends State<PersonalizedDashboardPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         scaffoldBackgroundColor: const Color(0xFFE0F2F1),
//         // CardTheme ki jagah CardThemeData use kiya h error resolve karne ke liye
//         cardTheme: CardThemeData(
//           color: Colors.white, 
//           elevation: 2, 
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'PathSeeker Dashboard', 
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           backgroundColor: const Color(0xFF00796B),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Personalized Greeting Card
//               StreamBuilder<DocumentSnapshot>(
//                 stream: db.collection('users').doc(widget.userId).snapshots(),
//                 builder: (context, snapshot) {
//                   String name = snapshot.data?.get('name') ?? 'Explorer';
//                   return Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF00796B), Color(0xFF26A69A)],
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Welcome back, $name!', 
//                           style: const TextStyle(
//                             color: Colors.white, 
//                             fontSize: 22, 
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         const Text(
//                           'Here is your career progression overview.', 
//                           style: TextStyle(color: Colors.white70, fontSize: 14),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),

//               // Dynamic Activity Stats
//               const Text(
//                 'Activity & Results Summary', 
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//               ),
//               const SizedBox(height: 10),
//               StreamBuilder<DocumentSnapshot>(
//                 stream: db.collection('user_stats').doc(widget.userId).snapshots(),
//                 builder: (context, snapshot) {
//                   int quizzes = snapshot.data?.get('quizzes_taken') ?? 0;
//                   int saved = snapshot.data?.get('saved_careers_count') ?? 0;
//                   return Row(
//                     children: [
//                       Expanded(child: _buildStatTile('Quizzes Taken', '$quizzes', Icons.quiz_outlined)),
//                       const SizedBox(width: 12),
//                       Expanded(child: _buildStatTile('Saved Items', '$saved', Icons.bookmark_added_outlined)),
//                     ],
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),

//               // Trending Careers Widget
//               const Text(
//                 'Trending Careers For You', 
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//               ),
//               const SizedBox(height: 10),
//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('careers').limit(3).snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//                   return Column(
//                     children: snapshot.data!.docs.map((doc) {
//                       var data = doc.data() as Map<String, dynamic>;
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             backgroundColor: Color(0xFFB2DFDB),
//                             child: Icon(Icons.work_outline, color: Color(0xFF00796B)),
//                           ),
//                           title: Text(
//                             data['title'] ?? 'Career Role', 
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Text('${data['domain']} | Salary: ${data['expected_salary']}'),
//                           trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF00796B)),
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatTile(String title, String count, IconData icon) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Icon(icon, color: const Color(0xFF00796B), size: 30),
//             const SizedBox(height: 8),
//             Text(
//               count, 
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//             ),
//             Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }
// }
