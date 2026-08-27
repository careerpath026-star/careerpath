// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SuccessStoriesPage extends StatefulWidget {
//   final String userId;
//   const SuccessStoriesPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<SuccessStoriesPage> createState() => _SuccessStoriesPageState();
// }

// class _SuccessStoriesPageState extends State<SuccessStoriesPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   final TextEditingController _storyController = TextEditingController();

//   void _submitUserStory() async {
//     if (_storyController.text.trim().isEmpty) return;
//     await db.collection('success_stories').add({
//       'submitted_by': widget.userId,
//       'story_text': _storyController.text.trim(),
//       'status': 'Pending Approval',
//       'created_at': FieldValue.serverTimestamp(),
//     });
//     _storyController.clear();
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Story submitted for Admin Approval!')));
//     }
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
//           title: const Text('Success Stories Hub', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           backgroundColor: const Color(0xFF00796B),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Submit Story Widget
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: _storyController,
//                         maxLines: 2,
//                         decoration: const InputDecoration(hintText: 'Share your career journey timeline...'),
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B), foregroundColor: Colors.white),
//                           onPressed: _submitUserStory,
//                           child: const Text('Submit Story to Database'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Firestore Timeline Stories Display
//               const Text('Approved Stories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//               const SizedBox(height: 10),
//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('success_stories').snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//                   return Column(
//                     children: snapshot.data!.docs.map((doc) {
//                       var data = doc.data() as Map<String, dynamic>;
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 12),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(data['story_text'] ?? '', style: const TextStyle(fontSize: 15)),
//                               const SizedBox(height: 8),
//                               Text('Status: ${data['status'] ?? 'Approved'}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
//                             ],
//                           ),
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
// }
















// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SuccessStoriesPage extends StatefulWidget {
//   final String userId;
//   const SuccessStoriesPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<SuccessStoriesPage> createState() => _SuccessStoriesPageState();
// }

// class _SuccessStoriesPageState extends State<SuccessStoriesPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   final TextEditingController _storyController = TextEditingController();

//   @override
//   void dispose() {
//     _storyController.dispose();
//     super.dispose();
//   }

//   void _submitUserStory() async {
//     final text = _storyController.text.trim();
//     if (text.isEmpty) return;

//     await db.collection('success_stories').add({
//       'submitted_by': widget.userId,
//       'story_text': text,
//       'status': 'Pending Approval',
//       'created_at': FieldValue.serverTimestamp(),
//     });

//     _storyController.clear();

//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Story submitted for Admin Approval!')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         scaffoldBackgroundColor: const Color(0xFFE0F2F1),
//         cardTheme: CardTheme(
//           color: Colors.white,
//           elevation: 2,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Success Stories Hub',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: const Color(0xFF00796B),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Submit Story Widget
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: _storyController,
//                         maxLines: 2,
//                         decoration: const InputDecoration(
//                           hintText: 'Share your career journey timeline...',
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF00796B),
//                             foregroundColor: Colors.white,
//                           ),
//                           onPressed: _submitUserStory,
//                           child: const Text('Submit Story to Database'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Firestore Timeline Stories Display
//               const Text(
//                 'Approved Stories',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF004D40),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('success_stories').snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   return Column(
//                     children: snapshot.data!.docs.map((doc) {
//                       var data = doc.data() as Map<String, dynamic>;
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 12),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 data['story_text'] ?? '',
//                                 style: const TextStyle(fontSize: 15),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 'Status: ${data['status'] ?? 'Approved'}',
//                                 style: const TextStyle(color: Colors.grey, fontSize: 12),
//                               ),
//                             ],
//                           ),
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
// }










// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/career_bank_screen.dart';
// import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/feedback_analytics_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
// import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';
// // import 'package0:cloud_firestore/cloud_firestore.dart';

// class SuccessStoriesPage extends StatefulWidget {
//   final String userId;
//   const SuccessStoriesPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<SuccessStoriesPage> createState() => _SuccessStoriesPageState();
// }

// class _SuccessStoriesPageState extends State<SuccessStoriesPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   final TextEditingController _storyController = TextEditingController();

//   @override
//   void dispose() {
//     _storyController.dispose();
//     super.dispose();
//   }

//   void _submitUserStory() async {
//     final text = _storyController.text.trim();
//     if (text.isEmpty) return;

//     await db.collection('success_stories').add({
//       'submitted_by': widget.userId,
//       'story_text': text,
//       'status': 'Pending Approval',
//       'created_at': FieldValue.serverTimestamp(),
//     });

//     _storyController.clear();

//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Story submitted for Admin Approval!')),
//       );
//     }
//   }

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
//             'Success Stories Hub',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: const Color(0xFF00796B),
//         ),
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
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => FeedbackAnalyticsPage(userId: widget.userId),
//                     ),
//                   );
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
//               // Submit Story Widget
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: _storyController,
//                         maxLines: 2,
//                         decoration: const InputDecoration(
//                           hintText: 'Share your career journey timeline...',
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF00796B),
//                             foregroundColor: Colors.white,
//                           ),
//                           onPressed: _submitUserStory,
//                           child: const Text('Submit Story to Database'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Firestore Timeline Stories Display
//               const Text(
//                 'Approved Stories',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF004D40),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('success_stories').snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   return Column(
//                     children: snapshot.data!.docs.map((doc) {
//                       var data = doc.data() as Map<String, dynamic>;
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 12),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 data['story_text'] ?? '',
//                                 style: const TextStyle(fontSize: 15),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 'Status: ${data['status'] ?? 'Approved'}',
//                                 style: const TextStyle(color: Colors.grey, fontSize: 12),
//                               ),
//                             ],
//                           ),
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
// }












// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/career_bank_screen.dart';
// import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/feedback_analytics_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
// import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';

// class SuccessStoriesPage extends StatefulWidget {
//   final String userId;
//   const SuccessStoriesPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<SuccessStoriesPage> createState() => _SuccessStoriesPageState();
// }

// class _SuccessStoriesPageState extends State<SuccessStoriesPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   final TextEditingController _storyController = TextEditingController();

//   @override
//   void dispose() {
//     _storyController.dispose();
//     super.dispose();
//   }

//   // 1. CREATE & UPDATE (C & U): Story add ya update karne ke liye Dialog/Function
//   void _showStoryDialog({String? docId, String? initialText}) {
//     if (initialText != null) {
//       _storyController.text = initialText;
//     } else {
//       _storyController.clear();
//     }

//     bool isEdit = docId != null;

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text(
//           isEdit ? 'Edit Success Story' : 'Share Success Story',
//           style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
//         ),
//         content: TextField(
//           controller: _storyController,
//           maxLines: 4,
//           decoration: const InputDecoration(
//             hintText: 'Share your career journey timeline...',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               _storyController.clear();
//               Navigator.pop(ctx);
//             },
//             child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
//             onPressed: () async {
//               final text = _storyController.text.trim();
//               if (text.isEmpty) return;

//               if (isEdit) {
//                 // UPDATE (U)
//                 await db.collection('success_stories').doc(docId).update({
//                   'story_text': text,
//                   'updated_at': FieldValue.serverTimestamp(),
//                 });
//               } else {
//                 // CREATE (C)
//                 await db.collection('success_stories').add({
//                   'submitted_by': widget.userId,
//                   'story_text': text,
//                   'status': 'Pending Approval',
//                   'created_at': FieldValue.serverTimestamp(),
//                 });
//               }

//               _storyController.clear();
//               if (ctx.mounted) Navigator.pop(ctx);

//               if (mounted) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(
//                       isEdit
//                           ? 'Story updated successfully!'
//                           : 'Story submitted for Admin Approval!',
//                     ),
//                     backgroundColor: const Color(0xFF00796B),
//                   ),
//                 );
//               }
//             },
//             child: Text(
//               isEdit ? 'Update' : 'Submit',
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // 3. DELETE (D): Firestore se story remove karne ke liye
//   Future<void> _deleteStory(String docId) async {
//     await db.collection('success_stories').doc(docId).delete();
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Success story deleted!'),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//     }
//   }

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
//             'Success Stories Hub',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: const Color(0xFF00796B),
//         ),
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
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.work_outline, color: Color(0xFF00796B)),
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
//                 leading: const Icon(Icons.bookmark_outline, color: Color(0xFF00796B)),
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
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => FeedbackAnalyticsPage(userId: widget.userId),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.library_books_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Document Library & Resources'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DocumentLibraryPage(userId: widget.userId),
//                     ),
//                   );
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
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.star, color: Color(0xFF00796B)),
//                 title: const Text('Success Stories & Testimonials'),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Interest Quiz & Career Assessment'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => InterestQuizPage(userId: widget.userId),
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
//               // Trigger Button to Open Add Dialog
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF00796B),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   onPressed: () => _showStoryDialog(),
//                   icon: const Icon(Icons.add),
//                   label: const Text('Share Your Success Story', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 ),
//               ),
//               const SizedBox(height: 25),

//               // Firestore Timeline Stories Display
//               const Text(
//                 'Community Success Stories',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF004D40),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('success_stories').snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//                   }
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Center(
//                       child: Padding(
//                         padding: EdgeInsets.all(30.0),
//                         child: Text(
//                           'No success stories shared yet.\nBe the first one to share your journey!',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Color(0xFF004D40), fontSize: 15),
//                         ),
//                       ),
//                     );
//                   }
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       var doc = snapshot.data!.docs[index];
//                       var data = doc.data() as Map<String, dynamic>;
//                       String docId = doc.id;
//                       String submittedBy = data['submitted_by'] ?? '';
//                       bool isOwner = submittedBy == widget.userId;

//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 12),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 data['story_text'] ?? '',
//                                 style: const TextStyle(fontSize: 15, color: Colors.black87),
//                               ),
//                               const SizedBox(height: 12),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     'Status: ${data['status'] ?? 'Approved'}',
//                                     style: const TextStyle(color: Color(0xFF00796B), fontSize: 12, fontWeight: FontWeight.w600),
//                                   ),
//                                   // Agar current user ki apni story hai toh Edit aur Delete ka option milega
//                                   if (isOwner)
//                                     Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         IconButton(
//                                           icon: const Icon(Icons.edit_outlined, size: 20, color: Colors.blueGrey),
//                                           onPressed: () => _showStoryDialog(docId: docId, initialText: data['story_text']),
//                                         ),
//                                         IconButton(
//                                           icon: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
//                                           onPressed: () => _deleteStory(docId),
//                                         ),
//                                       ],
//                                     ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
























import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/career_bank_screen.dart';
import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/feedback_analytics_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';

class SuccessStoriesPage extends StatefulWidget {
  final String userId;
  const SuccessStoriesPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<SuccessStoriesPage> createState() => _SuccessStoriesPageState();
}

class _SuccessStoriesPageState extends State<SuccessStoriesPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController _storyController = TextEditingController();

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  // Sirf UPDATE (Edit) ke liye Dialog/Function
  void _showEditDialog({required String docId, required String initialText}) {
    _storyController.text = initialText;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Edit Success Story',
          style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: _storyController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Edit your career journey timeline...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _storyController.clear();
              Navigator.pop(ctx);
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
            onPressed: () async {
              final text = _storyController.text.trim();
              if (text.isEmpty) return;

              // UPDATE (U)
              await db.collection('success_stories').doc(docId).update({
                'story_text': text,
                'updated_at': FieldValue.serverTimestamp(),
              });

              _storyController.clear();
              if (ctx.mounted) Navigator.pop(ctx);

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Story updated successfully!'),
                    backgroundColor: Color(0xFF00796B),
                  ),
                );
              }
            },
            child: const Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // DELETE (D): Firestore se story remove karne ke liye
  Future<void> _deleteStory(String docId) async {
    await db.collection('success_stories').doc(docId).delete();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Success story deleted!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

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
            'Success Stories Hub',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF00796B),
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
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.work_outline, color: Color(0xFF00796B)),
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
                leading: const Icon(Icons.bookmark_outline, color: Color(0xFF00796B)),
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
                leading: const Icon(Icons.star, color: Color(0xFF00796B)),
                title: const Text('Success Stories & Testimonials'),
                selected: true,
                selectedTileColor: const Color(0xFFE0F2F1),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
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
              // Firestore Timeline Stories Display
              const Text(
                'Community Success Stories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: db.collection('success_stories').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Text(
                          'No success stories available right now.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF004D40), fontSize: 15),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      var data = doc.data() as Map<String, dynamic>;
                      String docId = doc.id;
                      String submittedBy = data['submitted_by'] ?? '';
                      bool isOwner = submittedBy == widget.userId;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // FutureBuilder to fetch and display student name dynamically
                              FutureBuilder<DocumentSnapshot>(
                                future: db.collection('users').doc(submittedBy).get(),
                                builder: (context, userSnapshot) {
                                  String studentName = 'Loading student...';
                                  if (userSnapshot.hasData && userSnapshot.data!.exists) {
                                    var userData = userSnapshot.data!.data() as Map<String, dynamic>?;
                                    studentName = userData?['name'] ?? userData?['uname'] ?? 'Anonymous Student';
                                  } else if (userSnapshot.hasError || (userSnapshot.hasData && !userSnapshot.data!.exists)) {
                                    studentName = 'Anonymous Student';
                                  }

                                  return Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Color(0xFFE0F2F1),
                                        child: Icon(Icons.person, size: 16, color: Color(0xFF00796B)),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        studentName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xFF00796B),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                              Text(
                                data['story_text'] ?? '',
                                style: const TextStyle(fontSize: 15, color: Colors.black87),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Status: ${data['status'] ?? 'Approved'}',
                                    style: const TextStyle(color: Color(0xFF004D40), fontSize: 12, fontWeight: FontWeight.w600),
                                  ),
                                  // Agar current user ki apni story hai toh Edit aur Delete ka option milega
                                  if (isOwner)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit_outlined, size: 20, color: Colors.blueGrey),
                                          onPressed: () => _showEditDialog(docId: docId, initialText: data['story_text']),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
                                          onPressed: () => _deleteStory(docId),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}