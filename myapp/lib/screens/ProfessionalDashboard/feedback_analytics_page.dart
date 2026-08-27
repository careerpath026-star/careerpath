// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FeedbackAnalyticsPage extends StatefulWidget {
//   final String userId;
//   const FeedbackAnalyticsPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<FeedbackAnalyticsPage> createState() => _FeedbackAnalyticsPageState();
// }

// class _FeedbackAnalyticsPageState extends State<FeedbackAnalyticsPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   final TextEditingController _feedbackMsgController = TextEditingController();
//   String _category = 'Bug';

//   void _sendFeedback() async {
//     if (_feedbackMsgController.text.trim().isEmpty) return;
//     await db.collection('feedback').add({
//       'user_id': widget.userId,
//       'category': _category,
//       'message': _feedbackMsgController.text.trim(),
//       'status': 'Pending',
//       'submitted_at': FieldValue.serverTimestamp(),
//     });

//     _feedbackMsgController.clear();
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Feedback Submitted!')));
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
//           title: const Text('Feedback & Notifications', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           backgroundColor: const Color(0xFF00796B),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       DropdownButtonFormField<String>(
//                         value: _category,
//                         items: ['Bug', 'Suggestion', 'Query'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
//                         onChanged: (val) => setState(() => _category = val!),
//                         decoration: const InputDecoration(labelText: 'Feedback Type'),
//                       ),
//                       const SizedBox(height: 10),
//                       TextField(
//                         controller: _feedbackMsgController,
//                         maxLines: 2,
//                         decoration: const InputDecoration(hintText: 'Enter your message...'),
//                       ),
//                       const SizedBox(height: 12),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B), foregroundColor: Colors.white),
//                           onPressed: _sendFeedback,
//                           child: const Text('Submit Feedback to DB'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Dynamic Notifications List from Database
//               const Text('In-App Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//               const SizedBox(height: 10),
//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('notifications').snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//                   return Column(
//                     children: snapshot.data!.docs.map((doc) {
//                       var data = doc.data() as Map<String, dynamic>;
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 8),
//                         child: ListTile(
//                           leading: const Icon(Icons.notifications_active, color: Color(0xFF00796B)),
//                           title: Text(data['title'] ?? 'Announcement'),
//                           subtitle: Text(data['message'] ?? ''),
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

// class FeedbackAnalyticsPage extends StatefulWidget {
//   final String userId;
//   const FeedbackAnalyticsPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<FeedbackAnalyticsPage> createState() => _FeedbackAnalyticsPageState();
// }

// class _FeedbackAnalyticsPageState extends State<FeedbackAnalyticsPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   final TextEditingController _feedbackMsgController = TextEditingController();
//   String _category = 'Bug';

//   void _sendFeedback() async {
//     if (_feedbackMsgController.text.trim().isEmpty) return;
//     await db.collection('feedback').add({
//       'user_id': widget.userId,
//       'category': _category,
//       'message': _feedbackMsgController.text.trim(),
//       'status': 'Pending',
//       'submitted_at': FieldValue.serverTimestamp(),
//     });

//     _feedbackMsgController.clear();
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Feedback Submitted to Database!')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         useMaterial3: true,
//         scaffoldBackgroundColor: const Color(0xFFE0F2F1), // Pleasant Soft Mint Teal
//         // Material 3 ke mutabiq CardThemeData fix kiya gaya hai
//         cardTheme: CardThemeData(
//           color: Colors.white,
//           elevation: 2,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Feedback & Notifications', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           backgroundColor: const Color(0xFF00796B),
//           centerTitle: true,
//         ),
//         // Drawer Navigation Menu Integration
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
//                 leading: const Icon(Icons.feedback_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Feedback & Analytics', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.notifications_active_outlined, color: Color(0xFF78909C)),
//                 title: const Text('In-App Notifications'),
//                 onTap: () => Navigator.pop(context),
//               ),
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Submit Feedback',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//                       ),
//                       const SizedBox(height: 12),
//                       DropdownButtonFormField<String>(
//                         value: _category,
//                         items: ['Bug', 'Suggestion', 'Query']
//                             .map((c) => DropdownMenuItem(value: c, child: Text(c)))
//                             .toList(),
//                         onChanged: (val) => setState(() => _category = val!),
//                         decoration: InputDecoration(
//                           labelText: 'Feedback Type',
//                           filled: true,
//                           fillColor: const Color(0xFFF5F5F5),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       TextField(
//                         controller: _feedbackMsgController,
//                         maxLines: 3,
//                         decoration: InputDecoration(
//                           hintText: 'Enter your message or issue details...',
//                           filled: true,
//                           fillColor: const Color(0xFFF5F5F5),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
//                         ),
//                       ),
//                       const SizedBox(height: 14),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF00796B),
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                           ),
//                           icon: const Icon(Icons.send),
//                           label: const Text('Submit Feedback to DB', style: TextStyle(fontWeight: FontWeight.bold)),
//                           onPressed: _sendFeedback,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Dynamic Notifications List from Database
//               const Text('In-App Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//               const SizedBox(height: 10),
//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('notifications').snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//                   }

//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Card(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Text('No announcements or notifications right now.', style: TextStyle(color: Colors.grey)),
//                       ),
//                     );
//                   }

//                   return Column(
//                     children: snapshot.data!.docs.map((doc) {
//                       var data = doc.data() as Map<String, dynamic>;
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 8),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             backgroundColor: Color(0xFFB2DFDB),
//                             child: Icon(Icons.notifications_active, color: Color(0xFF00796B)),
//                           ),
//                           title: Text(data['title'] ?? 'Announcement', style: const TextStyle(fontWeight: FontWeight.bold)),
//                           subtitle: Text(data['message'] ?? '', style: const TextStyle(color: Color(0xFF78909C))),
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















import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/career_bank_screen.dart';
import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/success_stories_page.dart';

class FeedbackAnalyticsPage extends StatefulWidget {
  final String userId;
  const FeedbackAnalyticsPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<FeedbackAnalyticsPage> createState() => _FeedbackAnalyticsPageState();
}

class _FeedbackAnalyticsPageState extends State<FeedbackAnalyticsPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController _feedbackMsgController = TextEditingController();
  String _category = 'Bug';

  // ---------------- FEEDBACK CRUD OPERATIONS ----------------

  // 1. CREATE FEEDBACK
  Future<void> _sendFeedback() async {
    if (_feedbackMsgController.text.trim().isEmpty) return;

    await db.collection('feedback').add({
      'user_id': widget.userId,
      'category': _category,
      'message': _feedbackMsgController.text.trim(),
      'status': 'Pending',
      'submitted_at': DateTime.now().toIso8601String(),
    });

    _feedbackMsgController.clear();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback Submitted to Database!')),
      );
    }
  }

  // 2. UPDATE FEEDBACK
  void _editFeedbackDialog(String docId, Map<String, dynamic> data) {
    TextEditingController editMsgController = TextEditingController(text: data['message']);
    String editCategory = data['category'] ?? 'Bug';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Feedback', style: TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(
              builder: (context, setDialogState) => DropdownButtonFormField<String>(
                value: editCategory,
                items: ['Bug', 'Suggestion', 'Query']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setDialogState(() => editCategory = val!),
                decoration: const InputDecoration(labelText: 'Category'),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: editMsgController,
              maxLines: 2,
              decoration: const InputDecoration(labelText: 'Feedback Message'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
            onPressed: () async {
              if (editMsgController.text.trim().isNotEmpty) {
                await db.collection('feedback').doc(docId).update({
                  'category': editCategory,
                  'message': editMsgController.text.trim(),
                  'updated_at': DateTime.now().toIso8601String(),
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

  // 3. DELETE FEEDBACK
  Future<void> _deleteFeedback(String docId) async {
    await db.collection('feedback').doc(docId).delete();
  }

  // ---------------- NOTIFICATIONS CRUD OPERATIONS ----------------

  // 1. CREATE & UPDATE NOTIFICATION DIALOG
  void _showNotificationFormDialog({String? docId, Map<String, dynamic>? initialData}) {
    final titleController = TextEditingController(text: initialData?['title'] ?? '');
    final msgController = TextEditingController(text: initialData?['message'] ?? '');
    bool isEdit = docId != null;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          isEdit ? 'Edit Notification' : 'Add New Notification',
          style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Notification Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: msgController,
              maxLines: 2,
              decoration: const InputDecoration(labelText: 'Notification Message'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
            onPressed: () async {
              String title = titleController.text.trim();
              String msg = msgController.text.trim();
              if (title.isEmpty || msg.isEmpty) return;

              Map<String, dynamic> notifData = {
                'title': title,
                'message': msg,
                'created_at': DateTime.now().toIso8601String(),
              };

              if (isEdit) {
                await db.collection('notifications').doc(docId).update(notifData);
              } else {
                await db.collection('notifications').add(notifData);
              }

              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: Text(isEdit ? 'Update' : 'Publish', style: const TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  // 2. DELETE NOTIFICATION
  Future<void> _deleteNotification(String docId) async {
    await db.collection('notifications').doc(docId).delete();
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
          title: const Text('Feedback & Analytics', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CREATE FEEDBACK FORM
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Submit Feedback',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _category,
                        items: ['Bug', 'Suggestion', 'Query']
                            .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                            .toList(),
                        onChanged: (val) => setState(() => _category = val!),
                        decoration: InputDecoration(
                          labelText: 'Feedback Type',
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _feedbackMsgController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Enter your message or issue details...',
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00796B),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: const Icon(Icons.send),
                          label: const Text('Submit Feedback to DB', style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: _sendFeedback,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // READ & MANAGE MY SUBMITTED FEEDBACKS (READ, UPDATE, DELETE)
              const Text('My Submitted Feedbacks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: db.collection('feedback').where('user_id', isEqualTo: widget.userId).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No feedbacks submitted yet.', style: TextStyle(color: Colors.grey)),
                      ),
                    );
                  }

                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFB2DFDB),
                            child: Icon(Icons.rate_review_outlined, color: Color(0xFF00796B)),
                          ),
                          title: Text('[${data['category']}] ${data['message'] ?? ''}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Status: ${data['status'] ?? 'Pending'}', style: const TextStyle(color: Color(0xFF78909C))),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey),
                                onPressed: () => _editFeedbackDialog(doc.id, data),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                onPressed: () => _deleteFeedback(doc.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 24),

              // READ & MANAGE IN-APP NOTIFICATIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('In-App Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Color(0xFF00796B), size: 28),
                    tooltip: 'Add Notification',
                    onPressed: () => _showNotificationFormDialog(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: db.collection('notifications').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No announcements or notifications right now.', style: TextStyle(color: Colors.grey)),
                      ),
                    );
                  }

                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFB2DFDB),
                            child: Icon(Icons.notifications_active, color: Color(0xFF00796B)),
                          ),
                          title: Text(data['title'] ?? 'Announcement', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(data['message'] ?? '', style: const TextStyle(color: Color(0xFF78909C))),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey),
                                onPressed: () => _showNotificationFormDialog(docId: doc.id, initialData: data),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                onPressed: () => _deleteNotification(doc.id),
                              ),
                            ],
                          ),
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
}