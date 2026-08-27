// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class BookmarksNotesPage extends StatelessWidget {
//   final String userId;
//   const BookmarksNotesPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore db = FirebaseFirestore.instance;

//     return Scaffold(
//       backgroundColor: const Color(0xFFE0F2F1),
//       appBar: AppBar(
//         title: const Text('Saved Bookmarks', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF00796B),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         // Querying user specific bookmarks from DB
//         stream: db.collection('bookmarks').where('user_id', isEqualTo: userId).snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Text('No saved bookmarks found in DB.'),
//             );
//           }

//           var bookmarkDocs = snapshot.data!.docs;

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: bookmarkDocs.length,
//             itemBuilder: (context, index) {
//               var item = bookmarkDocs[index].data() as Map<String, dynamic>;
//               String docId = bookmarkDocs[index].id;

//               return Card(
//                 elevation: 2,
//                 margin: const EdgeInsets.only(bottom: 12),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: ListTile(
//                   leading: const Icon(Icons.bookmark, color: Color(0xFF00796B)),
//                   title: Text(item['title'] ?? 'Saved Item', style: const TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Text('Type: ${item['type'] ?? 'Career'}'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
//                     onPressed: () async {
//                       // Delete bookmark from DB directly
//                       await db.collection('bookmarks').doc(docId).delete();
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class BookmarksNotesPage extends StatelessWidget {
//   final String userId;
//   const BookmarksNotesPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore db = FirebaseFirestore.instance;

//     return Scaffold(
//       backgroundColor: const Color(0xFFE0F2F1),
//       appBar: AppBar(
//         title: const Text('Saved Bookmarks', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: const Color(0xFF00796B),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         // Sort by newest bookmarks first
//         stream: db
//             .collection('bookmarks')
//             .where('user_id', isEqualTo: userId)
//             .orderBy('created_at', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No saved bookmarks found in DB.',
//                 style: TextStyle(fontSize: 16, color: Color(0xFF004D40), fontWeight: FontWeight.w500),
//               ),
//             );
//           }

//           var bookmarkDocs = snapshot.data!.docs;

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: bookmarkDocs.length,
//             itemBuilder: (context, index) {
//               var item = bookmarkDocs[index].data() as Map<String, dynamic>;
//               String docId = bookmarkDocs[index].id;
//               String type = item['type'] ?? 'Career';

//               return Card(
//                 elevation: 2,
//                 margin: const EdgeInsets.only(bottom: 12),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: ListTile(
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   leading: CircleAvatar(
//                     backgroundColor: const Color(0xFFB2DFDB),
//                     child: Icon(
//                       type == 'Career' ? Icons.work_outline : Icons.menu_book_outlined,
//                       color: const Color(0xFF00796B),
//                     ),
//                   ),
//                   title: Text(
//                     item['title'] ?? 'Saved Item',
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   subtitle: Padding(
//                     padding: const EdgeInsets.only(top: 4.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Type: $type', style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF00796B))),
//                         if (item['note'] != null && item['note'].toString().isNotEmpty)
//                           Text('Note: ${item['note']}', style: const TextStyle(color: Colors.black87)),
//                       ],
//                     ),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
//                     onPressed: () async {
//                       await db.collection('bookmarks').doc(docId).delete();
                      
//                       // Optional: Decrement saved count in user_stats
//                       db.collection('user_stats').doc(userId).set({
//                         'saved_careers_count': FieldValue.increment(-1),
//                       }, SetOptions(merge: true));
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class BookmarksNotesPage extends StatelessWidget {
//   final String userId;
//   const BookmarksNotesPage({Key? key, required this.userId}) : super(key: key);

//   // 1. CREATE: Sample Data DB mein Add karne ke liye
//   Future<void> _seedSampleBookmarks(BuildContext context) async {
//     final FirebaseFirestore db = FirebaseFirestore.instance;

//     List<Map<String, dynamic>> sampleData = [
//       {
//         'user_id': userId,
//         'title': 'Flutter & Mobile App Development',
//         'type': 'Career',
//         'target_id': 'car_001',
//         'note': 'Cross-platform app design aur State Management seekhna h.',
//         'created_at': FieldValue.serverTimestamp(),
//       },
//       {
//         'user_id': userId,
//         'title': 'Cloud Computing & Azure Fundamentals',
//         'type': 'Resource',
//         'target_id': 'res_002',
//         'note': 'Exam 70-621 prep guidelines aur network topology notes.',
//         'created_at': FieldValue.serverTimestamp(),
//       },
//     ];

//     WriteBatch batch = db.batch();

//     for (var item in sampleData) {
//       DocumentReference docRef = db.collection('bookmarks').doc();
//       batch.set(docRef, item);
//     }

//     DocumentReference statRef = db.collection('user_stats').doc(userId);
//     batch.set(statRef, {
//       'saved_careers_count': FieldValue.increment(sampleData.length),
//     }, SetOptions(merge: true));

//     await batch.commit();

//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Sample Bookmarks DB mein save ho gaye hain!'),
//           backgroundColor: Color(0xFF00796B),
//         ),
//       );
//     }
//   }

//   // 2. UPDATE: Existing Bookmark Note Edit karne ke liye
//   void _editNoteDialog(BuildContext context, String docId, String currentNote) {
//     TextEditingController controller = TextEditingController(text: currentNote);

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Edit Note', style: TextStyle(color: Color(0xFF00796B))),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(
//             labelText: 'Personal Note',
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: Color(0xFF00796B)),
//             ),
//           ),
//           maxLines: 2,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
//             onPressed: () async {
//               await FirebaseFirestore.instance
//                   .collection('bookmarks')
//                   .doc(docId)
//                   .update({'note': controller.text.trim()});

//               if (context.mounted) Navigator.pop(context);
//             },
//             child: const Text('Save', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore db = FirebaseFirestore.instance;

//     return Scaffold(
//       backgroundColor: const Color(0xFFE0F2F1),
//       appBar: AppBar(
//         title: const Text('Saved Bookmarks', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: const Color(0xFF00796B),
//       ),
      
//       // 3. READ: Real-time Fetching
//       body: StreamBuilder<QuerySnapshot>(
//         stream: db
//             .collection('bookmarks')
//             .where('user_id', isEqualTo: userId)
//             .orderBy('created_at', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Text(
//                   'DB mein koi content nahi mila.\nNeeche + button daba kar sample data save karein.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16, color: Color(0xFF004D40), fontWeight: FontWeight.w500),
//                 ),
//               ),
//             );
//           }

//           var bookmarkDocs = snapshot.data!.docs;

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: bookmarkDocs.length,
//             itemBuilder: (context, index) {
//               var item = bookmarkDocs[index].data() as Map<String, dynamic>;
//               String docId = bookmarkDocs[index].id;
//               String type = item['type'] ?? 'Career';
//               String note = item['note'] ?? '';

//               return Card(
//                 elevation: 2,
//                 margin: const EdgeInsets.only(bottom: 12),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: ListTile(
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   leading: CircleAvatar(
//                     backgroundColor: const Color(0xFFB2DFDB),
//                     child: Icon(
//                       type == 'Career' ? Icons.work_outline : Icons.menu_book_outlined,
//                       color: const Color(0xFF00796B),
//                     ),
//                   ),
//                   title: Text(
//                     item['title'] ?? 'Saved Item',
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   subtitle: Padding(
//                     padding: const EdgeInsets.only(top: 4.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Type: $type', style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF00796B))),
//                         if (note.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 2.0),
//                             child: Text('Note: $note', style: const TextStyle(color: Colors.black87)),
//                           ),
//                       ],
//                     ),
//                   ),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Edit Button (Update)
//                       IconButton(
//                         icon: const Icon(Icons.edit_outlined, color: Color(0xFF00796B)),
//                         onPressed: () => _editNoteDialog(context, docId, note),
//                       ),
//                       // 4. DELETE: Document Remove karne ke liye
//                       IconButton(
//                         icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
//                         onPressed: () async {
//                           await db.collection('bookmarks').doc(docId).delete();
//                           db.collection('user_stats').doc(userId).set({
//                             'saved_careers_count': FieldValue.increment(-1),
//                           }, SetOptions(merge: true));
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),

//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _seedSampleBookmarks(context),
//         backgroundColor: const Color(0xFF00796B),
//         icon: const Icon(Icons.add, color: Colors.white),
//         label: const Text('Add Sample Data', style: TextStyle(color: Colors.white)),
//       ),
//     );
//   }
// }
















// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class BookmarksNotesPage extends StatelessWidget {
//   final String userId;
//   const BookmarksNotesPage({Key? key, required this.userId}) : super(key: key);

//   void _editNoteDialog(BuildContext context, String docId, String currentNote) {
//     TextEditingController controller = TextEditingController(text: currentNote);

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('Edit Note', style: TextStyle(color: Color(0xFF00796B))),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(labelText: 'Personal Note'),
//           maxLines: 2,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
//             onPressed: () async {
//               await FirebaseFirestore.instance
//                   .collection('bookmarks')
//                   .doc(docId)
//                   .update({'note': controller.text.trim()});

//               if (ctx.mounted) Navigator.pop(ctx);
//             },
//             child: const Text('Save', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore db = FirebaseFirestore.instance;

//     return Scaffold(
//       backgroundColor: const Color(0xFFE0F2F1),
//       appBar: AppBar(
//         title: const Text('Saved Bookmarks', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: const Color(0xFF00796B),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: db
//             .collection('bookmarks')
//             .where('user_id', isEqualTo: userId)
//             .orderBy('created_at', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Text(
//                   'No saved bookmarks found in DB.',
//                   style: TextStyle(fontSize: 16, color: Color(0xFF004D40), fontWeight: FontWeight.w500),
//                 ),
//               ),
//             );
//           }

//           var bookmarkDocs = snapshot.data!.docs;

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: bookmarkDocs.length,
//             itemBuilder: (context, index) {
//               var item = bookmarkDocs[index].data() as Map<String, dynamic>;
//               String docId = bookmarkDocs[index].id;
//               String type = item['type'] ?? 'Career';
//               String note = item['note'] ?? '';

//               return Card(
//                 elevation: 2,
//                 margin: const EdgeInsets.only(bottom: 12),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: ListTile(
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   leading: const CircleAvatar(
//                     backgroundColor: Color(0xFFB2DFDB),
//                     child: Icon(Icons.bookmark, color: Color(0xFF00796B)),
//                   ),
//                   title: Text(item['title'] ?? 'Saved Item', style: const TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Text('Type: $type\nNote: $note'),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.edit_outlined, color: Color(0xFF00796B)),
//                         onPressed: () => _editNoteDialog(context, docId, note),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
//                         onPressed: () async {
//                           await db.collection('bookmarks').doc(docId).delete();
//                           db.collection('user_stats').doc(userId).set({
//                             'saved_careers_count': FieldValue.increment(-1),
//                           }, SetOptions(merge: true));
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }










import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/screens/ProfessionalDashboard/career_bank_screen.dart';
import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/feedback_analytics_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/success_stories_page.dart';

class BookmarksNotesPage extends StatefulWidget {
  final String userId;
  const BookmarksNotesPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<BookmarksNotesPage> createState() => _BookmarksNotesPageState();
}

class _BookmarksNotesPageState extends State<BookmarksNotesPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // 1. CREATE (C) & UPDATE (U) Dialog
  void _showBookmarkFormDialog({
    String? docId,
    Map<String, dynamic>? initialData,
  }) {
    final titleController = TextEditingController(text: initialData?['title'] ?? '');
    final noteController = TextEditingController(text: initialData?['note'] ?? '');
    String selectedType = initialData?['type'] ?? 'Career';
    bool isEdit = docId != null;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            isEdit ? 'Edit Bookmark' : 'Add New Bookmark',
            style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Bookmark Title',
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00796B))),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: const [
                    DropdownMenuItem(value: 'Career', child: Text('Career')),
                    DropdownMenuItem(value: 'Resource', child: Text('Resource')),
                    DropdownMenuItem(value: 'Note', child: Text('Personal Note')),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setDialogState(() {
                        selectedType = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: noteController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Personal Note',
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00796B))),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
              onPressed: () async {
                String title = titleController.text.trim();
                if (title.isEmpty) return;

                if (isEdit) {
                  // UPDATE (U)
                  await db.collection('bookmarks').doc(docId).update({
                    'title': title,
                    'type': selectedType,
                    'note': noteController.text.trim(),
                    'updated_at': DateTime.now().toIso8601String(),
                  });
                } else {
                  // CREATE (C)
                  await db.collection('bookmarks').add({
                    'user_id': widget.userId,
                    'title': title,
                    'type': selectedType,
                    'note': noteController.text.trim(),
                    'created_at': DateTime.now().toIso8601String(),
                  });

                  // Stats Increment
                  await db.collection('user_stats').doc(widget.userId).set({
                    'saved_careers_count': FieldValue.increment(1),
                  }, SetOptions(merge: true));
                }

                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: Text(isEdit ? 'Update' : 'Save', style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // 2. DELETE (D)
  Future<void> _deleteBookmark(String docId) async {
    await db.collection('bookmarks').doc(docId).delete();
    
    await db.collection('user_stats').doc(widget.userId).set({
      'saved_careers_count': FieldValue.increment(-1),
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1),
      appBar: AppBar(
        title: const Text('Saved Bookmarks', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                  // _showSimplePage(context, 'Feedback & Suggestions');
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

      // 3. READ (R) - Fixed Real-time Stream Query
      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('bookmarks')
            .where('user_id', isEqualTo: widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'No saved bookmarks found.\nTap + button below to add a new bookmark.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Color(0xFF004D40), fontWeight: FontWeight.w500),
                ),
              ),
            );
          }

          var bookmarkDocs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookmarkDocs.length,
            itemBuilder: (context, index) {
              var item = bookmarkDocs[index].data() as Map<String, dynamic>;
              String docId = bookmarkDocs[index].id;
              String type = item['type'] ?? 'Career';
              String note = item['note'] ?? '';

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFB2DFDB),
                    child: Icon(
                      type == 'Resource'
                          ? Icons.menu_book_outlined
                          : type == 'Note'
                              ? Icons.note_alt_outlined
                              : Icons.work_outline,
                      color: const Color(0xFF00796B),
                    ),
                  ),
                  title: Text(
                    item['title'] ?? 'Saved Item',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF004D40)),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type: $type', style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.w600)),
                        if (note.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text('Note: $note', style: const TextStyle(color: Colors.black87)),
                          ),
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Color(0xFF00796B)),
                        onPressed: () => _showBookmarkFormDialog(docId: docId, initialData: item),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () => _deleteBookmark(docId),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF00796B),
        onPressed: () => _showBookmarkFormDialog(),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Bookmark', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class BookmarksNotesPage extends StatelessWidget {
//   final String userId;
//   const BookmarksNotesPage({Key? key, required this.userId}) : super(key: key);

//   // Helper Function: Firestore mein sample data save karwane ke liye
//   Future<void> _seedSampleBookmarks(BuildContext context) async {
//     final FirebaseFirestore db = FirebaseFirestore.instance;

//     List<Map<String, dynamic>> sampleData = [
//       {
//         'user_id': userId,
//         'title': 'Flutter & Mobile App Development',
//         'type': 'Career',
//         'target_id': 'car_001',
//         'note': 'Cross-platform app design aur State Management seekhna h.',
//         'created_at': FieldValue.serverTimestamp(),
//       },
//       {
//         'user_id': userId,
//         'title': 'Cloud Computing & Azure Fundamentals',
//         'type': 'Resource',
//         'target_id': 'res_002',
//         'note': 'Exam 70-621 prep guidelines aur network topology notes.',
//         'created_at': FieldValue.serverTimestamp(),
//       },
//       {
//         'user_id': userId,
//         'title': 'UI/UX Design Trends',
//         'type': 'Resource',
//         'target_id': 'res_003',
//         'note': 'Clean teal and soft cyan cooling color themes.',
//         'created_at': FieldValue.serverTimestamp(),
//       },
//     ];

//     WriteBatch batch = db.batch();

//     for (var item in sampleData) {
//       DocumentReference docRef = db.collection('bookmarks').doc();
//       batch.set(docRef, item);
//     }

//     // User stats count update
//     DocumentReference statRef = db.collection('user_stats').doc(userId);
//     batch.set(statRef, {
//       'saved_careers_count': FieldValue.increment(sampleData.length),
//     }, SetOptions(merge: true));

//     await batch.commit();

//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Sample Bookmarks DB mein save ho gaye hain!'),
//           backgroundColor: Color(0xFF00796B),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore db = FirebaseFirestore.instance;

//     return Scaffold(
//       backgroundColor: const Color(0xFFE0F2F1),
//       appBar: AppBar(
//         title: const Text('Saved Bookmarks', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: const Color(0xFF00796B),
//       ),
      
//       // Real-time Database Stream Listener
//       body: StreamBuilder<QuerySnapshot>(
//         stream: db
//             .collection('bookmarks')
//             .where('user_id', isEqualTo: userId)
//             .orderBy('created_at', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//           }

//           // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           //   return const Center(
//           //     child: Padding(
//           //       padding: EdgeInsets.all(20.0),
//           //       style: TextStyle(fontSize: 16, color: Color(0xFF004D40), fontWeight: FontWeight.w500),
//           //       child: Text('DB mein koi content nahi mila.\nNeeche + button daba kar sample data save karein.', textAlign: TextAlign.center),
//           //     ),
//           //   );
//           // }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//   return const Center(
//     child: Padding(
//       padding: EdgeInsets.all(20.0),
//       child: Text(
//         'DB mein koi content nahi mila.\nNeeche + button daba kar sample data save karein.',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 16, 
//           color: Color(0xFF004D40), 
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     ),
//   );
// }

//           var bookmarkDocs = snapshot.data!.docs;

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: bookmarkDocs.length,
//             itemBuilder: (context, index) {
//               var item = bookmarkDocs[index].data() as Map<String, dynamic>;
//               String docId = bookmarkDocs[index].id;
//               String type = item['type'] ?? 'Career';

//               return Card(
//                 elevation: 2,
//                 margin: const EdgeInsets.only(bottom: 12),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: ListTile(
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   leading: CircleAvatar(
//                     backgroundColor: const Color(0xFFB2DFDB),
//                     child: Icon(
//                       type == 'Career' ? Icons.work_outline : Icons.menu_book_outlined,
//                       color: const Color(0xFF00796B),
//                     ),
//                   ),
//                   title: Text(
//                     item['title'] ?? 'Saved Item',
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   subtitle: Padding(
//                     padding: const EdgeInsets.only(top: 4.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Type: $type', style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF00796B))),
//                         if (item['note'] != null && item['note'].toString().isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.only(top: 2.0),
//                             child: Text('Note: ${item['note']}', style: const TextStyle(color: Colors.black87)),
//                           ),
//                       ],
//                     ),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
//                     onPressed: () async {
//                       await db.collection('bookmarks').doc(docId).delete();
//                       db.collection('user_stats').doc(userId).set({
//                         'saved_careers_count': FieldValue.increment(-1),
//                       }, SetOptions(merge: true));
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),

//       // Button to Trigger DB Seeding
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _seedSampleBookmarks(context),
//         backgroundColor: const Color(0xFF00796B),
//         icon: const Icon(Icons.add, color: Colors.white),
//         label: const Text('Add Sample Data', style: TextStyle(color: Colors.white)),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class BookmarksNotesPage extends StatefulWidget {
//   final String userId;
//   const BookmarksNotesPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<BookmarksNotesPage> createState() => _BookmarksNotesPageState();
// }

// class _BookmarksNotesPageState extends State<BookmarksNotesPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         useMaterial3: true,
//         scaffoldBackgroundColor: const Color(0xFFE0F2F1), // Soft Light Teal
//         // Fixed CardTheme error by using CardThemeData correctly for Material 3
//         cardTheme: CardThemeData(
//           color: Colors.white,
//           elevation: 2,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Bookmarks & Sticky Notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           backgroundColor: const Color(0xFF00796B),
//           centerTitle: true,
//         ),
//         // Drawer Navigation Bar
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
//                 leading: const Icon(Icons.bookmark, color: Color(0xFF00796B)),
//                 title: const Text('My Saved Bookmarks', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.note_alt_outlined, color: Color(0xFF78909C)),
//                 title: const Text('Export Notes as PDF'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Preparing notes PDF export...')),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: db.collection('bookmarks').where('user_id', isEqualTo: widget.userId).snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//             }

//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(
//                 child: Text('No bookmarked items found.', style: TextStyle(color: Color(0xFF004D40), fontSize: 16)),
//               );
//             }

//             var docs = snapshot.data!.docs;

//             return ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: docs.length,
//               itemBuilder: (context, index) {
//                 var doc = docs[index];
//                 var data = doc.data() as Map<String, dynamic>;
//                 TextEditingController noteController = TextEditingController(text: data['sticky_note'] ?? '');

//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   child: Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ListTile(
//                           contentPadding: EdgeInsets.zero,
//                           leading: const CircleAvatar(
//                             backgroundColor: Color(0xFFB2DFDB),
//                             child: Icon(Icons.bookmark, color: Color(0xFF00796B)),
//                           ),
//                           title: Text(data['title'] ?? 'Saved Item', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                           subtitle: Text('Type: ${data['type'] ?? 'Career'}', style: const TextStyle(color: Colors.grey)),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
//                             onPressed: () async {
//                               await db.collection('bookmarks').doc(doc.id).delete();
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         TextField(
//                           controller: noteController,
//                           maxLines: 2,
//                           decoration: InputDecoration(
//                             hintText: 'Add sticky note or reminder...',
//                             filled: true,
//                             fillColor: const Color(0xFFF5F5F5),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF00796B),
//                               foregroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                             ),
//                             icon: const Icon(Icons.save, size: 16),
//                             label: const Text('Save Note'),
//                             onPressed: () async {
//                               await db.collection('bookmarks').doc(doc.id).update({
//                                 'sticky_note': noteController.text.trim(),
//                               });
//                               if (context.mounted) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text('Sticky note updated!')),
//                                 );
//                               }
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }