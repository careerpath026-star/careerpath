// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DocumentLibraryPage extends StatelessWidget {
//   final String userId;
//   const DocumentLibraryPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final FirebaseFirestore db = FirebaseFirestore.instance;

//     return Theme(
//       data: ThemeData(
//         scaffoldBackgroundColor: const Color(0xFFE0F2F1),
//         cardTheme: CardTheme(color: Colors.white, elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Document Resource Library', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           backgroundColor: const Color(0xFF00796B),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: db.collection('resources').snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//             return ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 var doc = snapshot.data!.docs[index];
//                 var data = doc.data() as Map<String, dynamic>;
//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   child: ListTile(
//                     leading: const Icon(Icons.picture_as_pdf, color: Color(0xFF00796B), size: 36),
//                     title: Text(data['title'] ?? 'Document Guide', style: const TextStyle(fontWeight: FontWeight.bold)),
//                     subtitle: Text('Tag: ${data['tag'] ?? 'Beginner'} | Downloads: ${data['views_count'] ?? 0}'),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.download, color: Color(0xFF26A69A)),
//                       onPressed: () async {
//                         await db.collection('resources').doc(doc.id).update({'views_count': FieldValue.increment(1)});
//                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downloading file & updating stats...')));
//                       },
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







// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DocumentLibraryPage extends StatefulWidget {
//   final String userId;
//   const DocumentLibraryPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<DocumentLibraryPage> createState() => _DocumentLibraryPageState();
// }

// class _DocumentLibraryPageState extends State<DocumentLibraryPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;

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
//           title: const Text('Document Resource Library', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
//                 leading: const Icon(Icons.folder_open_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Resource Library', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.filter_list, color: Color(0xFF78909C)),
//                 title: const Text('Filter by Tag (PDFs/Guides)'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: db.collection('resources').snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//             }

//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(
//                 child: Text('No documents available right now.', style: TextStyle(color: Color(0xFF004D40), fontSize: 16)),
//               );
//             }

//             return ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 var doc = snapshot.data!.docs[index];
//                 var data = doc.data() as Map<String, dynamic>;

//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     leading: const CircleAvatar(
//                       backgroundColor: Color(0xFFB2DFDB),
//                       child: Icon(Icons.picture_as_pdf, color: Color(0xFF00796B)),
//                     ),
//                     title: Text(
//                       data['title'] ?? 'Document Guide',
//                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF004D40)),
//                     ),
//                     subtitle: Padding(
//                       padding: const EdgeInsets.only(top: 4.0),
//                       child: Text(
//                         'Tag: ${data['tag'] ?? 'Beginner'} | Downloads: ${data['views_count'] ?? 0}',
//                         style: const TextStyle(color: Color(0xFF78909C)),
//                       ),
//                     ),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.file_download_outlined, color: Color(0xFF00796B), size: 28),
//                       onPressed: () async {
//                         await db.collection('resources').doc(doc.id).update({
//                           'views_count': FieldValue.increment(1),
//                         });
//                         if (context.mounted) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Downloading file & updating stats...')),
//                           );
//                         }
//                       },
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















// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DocumentLibraryPage extends StatefulWidget {
//   final String userId;
//   const DocumentLibraryPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<DocumentLibraryPage> createState() => _DocumentLibraryPageState();
// }

// class _DocumentLibraryPageState extends State<DocumentLibraryPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   // 1. CREATE (C) & UPDATE (U): Document Add aur Edit karne ka dialog
//   void _showDocumentFormDialog({
//     String? docId,
//     Map<String, dynamic>? initialData,
//   }) {
//     final titleController = TextEditingController(text: initialData?['title'] ?? '');
//     final tagController = TextEditingController(text: initialData?['tag'] ?? '');
//     bool isEdit = docId != null;

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text(
//           isEdit ? 'Edit Document' : 'Add New Document',
//           style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Document Title',
//                 focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00796B))),
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: tagController,
//               decoration: const InputDecoration(
//                 labelText: 'Tag (e.g., PDF / Guide / Tech)',
//                 focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00796B))),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
//             onPressed: () async {
//               String title = titleController.text.trim();
//               if (title.isEmpty) return;

//               Map<String, dynamic> docData = {
//                 'title': title,
//                 'tag': tagController.text.trim().isEmpty ? 'General' : tagController.text.trim(),
//                 'updated_at': FieldValue.serverTimestamp(),
//               };

//               if (isEdit) {
//                 // UPDATE (U)
//                 await db.collection('resources').doc(docId).update(docData);
//               } else {
//                 // CREATE (C)
//                 docData['views_count'] = 0;
//                 docData['created_at'] = FieldValue.serverTimestamp();
//                 await db.collection('resources').add(docData);
//               }

//               if (ctx.mounted) Navigator.pop(ctx);
//             },
//             child: Text(isEdit ? 'Update' : 'Save', style: const TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   // 2. DELETE (D): Document remove karne ke liye
//   Future<void> _deleteDocument(String docId) async {
//     await db.collection('resources').doc(docId).delete();
//   }

//   // 3. BOOKMARK ACTION: Direct Bookmark collection mein save karne ke liye
//   Future<void> _bookmarkDocument(Map<String, dynamic> docData) async {
//     await db.collection('bookmarks').add({
//       'user_id': widget.userId,
//       'title': docData['title'] ?? 'Document Resource',
//       'type': 'Resource',
//       'note': 'Saved from Document Library',
//       'created_at': FieldValue.serverTimestamp(),
//     });

//     await db.collection('user_stats').doc(widget.userId).set({
//       'saved_careers_count': FieldValue.increment(1),
//     }, SetOptions(merge: true));

//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('${docData['title']} saved to Bookmarks!'),
//           backgroundColor: const Color(0xFF00796B),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         useMaterial3: true,
//         scaffoldBackgroundColor: const Color(0xFFE0F2F1),
//         cardTheme: CardThemeData(
//           color: Colors.white,
//           elevation: 2,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Document Resource Library', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
//                 leading: const Icon(Icons.folder_open_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Resource Library', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
//                 onTap: () => Navigator.pop(context),
//               ),
//             ],
//           ),
//         ),

//         // 4. READ (R): Real-time Stream Engine
//         body: StreamBuilder<QuerySnapshot>(
//           stream: db.collection('resources').snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//             }

//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(
//                 child: Text('No documents available right now.\nTap + button to add one.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF004D40), fontSize: 16)),
//               );
//             }

//             return ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 var doc = snapshot.data!.docs[index];
//                 var data = doc.data() as Map<String, dynamic>;

//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     leading: const CircleAvatar(
//                       backgroundColor: Color(0xFFB2DFDB),
//                       child: Icon(Icons.picture_as_pdf, color: Color(0xFF00796B)),
//                     ),
//                     title: Text(
//                       data['title'] ?? 'Document Guide',
//                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF004D40)),
//                     ),
//                     subtitle: Padding(
//                       padding: const EdgeInsets.only(top: 4.0),
//                       child: Text(
//                         'Tag: ${data['tag'] ?? 'Beginner'} | Downloads: ${data['views_count'] ?? 0}',
//                         style: const TextStyle(color: Color(0xFF78909C)),
//                       ),
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // Bookmark Action
//                         IconButton(
//                           icon: const Icon(Icons.bookmark_add_outlined, color: Color(0xFF00796B)),
//                           onPressed: () => _bookmarkDocument(data),
//                         ),
//                         // Download & Count Increment Action
//                         IconButton(
//                           icon: const Icon(Icons.file_download_outlined, color: Color(0xFF00796B)),
//                           onPressed: () async {
//                             await db.collection('resources').doc(doc.id).update({
//                               'views_count': FieldValue.increment(1),
//                             });
//                             if (context.mounted) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(content: Text('Downloading file & updating stats...')),
//                               );
//                             }
//                           },
//                         ),
//                         // EDIT (U) Action
//                         IconButton(
//                           icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey),
//                           onPressed: () => _showDocumentFormDialog(docId: doc.id, initialData: data),
//                         ),
//                         // DELETE (D) Action
//                         IconButton(
//                           icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
//                           onPressed: () => _deleteDocument(doc.id),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),

//         // CREATE (C) Trigger Button
//         floatingActionButton: FloatingActionButton.extended(
//           backgroundColor: const Color(0xFF00796B),
//           onPressed: () => _showDocumentFormDialog(),
//           icon: const Icon(Icons.add, color: Colors.white),
//           label: const Text('Add Document', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         ),
//       ),
//     );
//   }
// }











import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/career_bank_screen.dart';
import 'package:myapp/screens/ProfessionalDashboard/feedback_analytics_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/success_stories_page.dart';
import 'package:url_launcher/url_launcher.dart'; // URL Launch / Download Package

class DocumentLibraryPage extends StatefulWidget {
  final String userId;
  const DocumentLibraryPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<DocumentLibraryPage> createState() => _DocumentLibraryPageState();
}

class _DocumentLibraryPageState extends State<DocumentLibraryPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Actual Download Function using url_launcher
  Future<void> _downloadFile(String urlString, String docId) async {
    if (urlString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No valid download URL provided for this file.')),
      );
      return;
    }

    final Uri url = Uri.parse(urlString);

    try {
      // 1. Increment Download/Views count in Firestore
      await db.collection('resources').doc(docId).update({
        'views_count': FieldValue.increment(1),
      });

      // 2. Open link in external browser to initiate download
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open the download URL.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download Error: $e')),
        );
      }
    }
  }

  // 1. CREATE (C) & UPDATE (U) Dialog
  void _showDocumentFormDialog({
    String? docId,
    Map<String, dynamic>? initialData,
  }) {
    final titleController = TextEditingController(text: initialData?['title'] ?? '');
    final tagController = TextEditingController(text: initialData?['tag'] ?? 'CV');
    final fileUrlController = TextEditingController(text: initialData?['file_url'] ?? '');
    bool isEdit = docId != null;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          isEdit ? 'Edit Document / CV' : 'Add New Document / CV',
          style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Document Title (e.g. Flutter Developer CV)',
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00796B))),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: tagController,
                decoration: const InputDecoration(
                  labelText: 'Tag (e.g., CV, Resume, Guide, PDF)',
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00796B))),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: fileUrlController,
                decoration: const InputDecoration(
                  labelText: 'Direct PDF / CV Download URL',
                  hintText: 'https://example.com/my-cv.pdf',
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

              Map<String, dynamic> docData = {
                'title': title,
                'tag': tagController.text.trim().isEmpty ? 'General' : tagController.text.trim(),
                'file_url': fileUrlController.text.trim(),
                'updated_at': DateTime.now().toIso8601String(),
              };

              if (isEdit) {
                await db.collection('resources').doc(docId).update(docData);
              } else {
                docData['views_count'] = 0;
                docData['created_at'] = DateTime.now().toIso8601String();
                await db.collection('resources').add(docData);
              }

              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: Text(isEdit ? 'Update' : 'Save', style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // 2. DELETE (D)
  Future<void> _deleteDocument(String docId) async {
    await db.collection('resources').doc(docId).delete();
  }

  // 3. BOOKMARK ACTION
  Future<void> _bookmarkDocument(Map<String, dynamic> docData) async {
    await db.collection('bookmarks').add({
      'user_id': widget.userId,
      'title': docData['title'] ?? 'Document Resource',
      'type': 'Resource',
      'file_url': docData['file_url'] ?? '',
      'note': 'Saved PDF/CV Document',
      'created_at': DateTime.now().toIso8601String(),
    });

    await db.collection('user_stats').doc(widget.userId).set({
      'saved_careers_count': FieldValue.increment(1),
    }, SetOptions(merge: true));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${docData['title']} saved to Bookmarks!'),
          backgroundColor: const Color(0xFF00796B),
        ),
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
          title: const Text('Document & CV Library', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

        // 4. READ (R)
        body: StreamBuilder<QuerySnapshot>(
          stream: db.collection('resources').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No PDF/CV files available.\nTap + button to add one.', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF004D40), fontSize: 16)),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                var data = doc.data() as Map<String, dynamic>;
                String tag = (data['tag'] ?? 'PDF').toString().toUpperCase();
                String fileUrl = data['file_url'] ?? '';

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFB2DFDB),
                      child: Icon(
                        tag.contains('CV') || tag.contains('RESUME') 
                            ? Icons.badge_outlined 
                            : Icons.picture_as_pdf, 
                        color: const Color(0xFF00796B),
                      ),
                    ),
                    title: Text(
                      data['title'] ?? 'Document Guide',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF004D40)),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Tag: ${data['tag'] ?? 'PDF'} | Downloads: ${data['views_count'] ?? 0}',
                        style: const TextStyle(color: Color(0xFF78909C)),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Bookmark Action
                        IconButton(
                          icon: const Icon(Icons.bookmark_add_outlined, color: Color(0xFF00796B)),
                          onPressed: () => _bookmarkDocument(data),
                        ),
                        
                        // DOWNLOAD CV / FILE ACTION
                        IconButton(
                          tooltip: 'Download File / CV',
                          icon: const Icon(Icons.file_download_outlined, color: Color(0xFF00796B), size: 28),
                          onPressed: () => _downloadFile(fileUrl, doc.id),
                        ),

                        // EDIT (U) Action
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey),
                          onPressed: () => _showDocumentFormDialog(docId: doc.id, initialData: data),
                        ),

                        // DELETE (D) Action
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () => _deleteDocument(doc.id),
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
          onPressed: () => _showDocumentFormDialog(),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text('Add PDF / CV', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}