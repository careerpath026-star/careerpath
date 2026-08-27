import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/feedback_analytics_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/success_stories_page.dart';

class CareerBankPage extends StatelessWidget {
  final String userId;
  const CareerBankPage({Key? key, required this.userId}) : super(key: key);

  // 1. CREATE (C): Naya career document add karne ke liye
  // 2. UPDATE (U): Existing career document ko update karne ke liye
  void _showCareerFormDialog({
    required BuildContext context,
    String? docId,
    Map<String, dynamic>? initialData,
  }) {
    final titleController = TextEditingController(text: initialData?['title'] ?? '');
    final domainController = TextEditingController(text: initialData?['domain'] ?? '');
    final salaryController = TextEditingController(text: initialData?['expected_salary'] ?? '');
    final descController = TextEditingController(text: initialData?['description'] ?? '');

    bool isEdit = docId != null;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          isEdit ? 'Edit Career Role' : 'Add New Career Role',
          style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Career Title (e.g., Flutter Developer)'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: domainController,
                decoration: const InputDecoration(labelText: 'Domain (e.g., Software Engineering)'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: salaryController,
                decoration: const InputDecoration(labelText: 'Expected Salary Range'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Short Description'),
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

              Map<String, dynamic> careerData = {
                'title': title,
                'domain': domainController.text.trim().isEmpty ? 'General' : domainController.text.trim(),
                'expected_salary': salaryController.text.trim().isEmpty ? '\$60k - \$90k' : salaryController.text.trim(),
                'description': descController.text.trim(),
                'updated_at': FieldValue.serverTimestamp(),
              };

              final db = FirebaseFirestore.instance;

              if (isEdit) {
                // UPDATE (U)
                await db.collection('careers_bank').doc(docId).update(careerData);
              } else {
                // CREATE (C)
                careerData['created_at'] = FieldValue.serverTimestamp();
                await db.collection('careers_bank').add(careerData);
              }

              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: Text(isEdit ? 'Update' : 'Save', style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // 3. DELETE (D): Firestore Document Remove karne ke liye
  Future<void> _deleteCareer(String docId) async {
    await FirebaseFirestore.instance.collection('careers_bank').doc(docId).delete();
  }

  // Helper Function: Quick Bookmark Option
  Future<void> _bookmarkCareer(BuildContext context, Map<String, dynamic> career) async {
    final db = FirebaseFirestore.instance;
    await db.collection('bookmarks').add({
      'user_id': userId,
      'title': career['title'] ?? 'Career Item',
      'type': 'Career',
      'note': 'Saved from Career Bank',
      'created_at': FieldValue.serverTimestamp(),
    });

    await db.collection('user_stats').doc(userId).set({
      'saved_careers_count': FieldValue.increment(1),
    }, SetOptions(merge: true));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${career['title']} saved to your Bookmarks!'),
          backgroundColor: const Color(0xFF00796B),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1),
      appBar: AppBar(
        title: const Text('Career Bank', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF00796B),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: db.collection('users').doc(userId).snapshots(),
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
                    builder: (_) => CareerBankPage(userId: userId),
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
                    builder: (_) => BookmarksNotesPage(userId: userId),
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
                    builder: (_) => FeedbackAnalyticsPage(userId: userId),
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
                    builder: (_) => DocumentLibraryPage(userId: userId),
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
                    builder: (_) => MultimediaCenterPage(userId: userId),
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
                    builder: (_) => SuccessStoriesPage(userId: userId),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
              title: const Text('Interest Quiz & Career Assessment'),
              onTap: () {
                Navigator.pop(context); // safe navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InterestQuizPage(userId: userId),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // 4. READ (R): Real-time Stream Engine
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('careers_bank').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'No careers available in Database.\nTap + button to add a new career role.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Color(0xFF004D40), fontWeight: FontWeight.w500),
                ),
              ),
            );
          }

          var docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;
              String docId = docs[index].id;

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFB2DFDB),
                      child: Icon(Icons.work_outline, color: Color(0xFF00796B)),
                    ),
                    title: Text(
                      data['title'] ?? 'Career Role',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xFF004D40)),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Domain: ${data['domain'] ?? 'N/A'}', style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text('Salary: ${data['expected_salary'] ?? 'N/A'}', style: const TextStyle(color: Color(0xFF00796B))),
                          if (data['description'] != null && data['description'].toString().isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(data['description'], style: const TextStyle(color: Colors.black87, fontSize: 13)),
                            ),
                        ],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Bookmark Action
                        IconButton(
                          icon: const Icon(Icons.bookmark_add_outlined, color: Color(0xFF00796B)),
                          onPressed: () => _bookmarkCareer(context, data),
                        ),
                        // EDIT (U) Button
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey),
                          onPressed: () => _showCareerFormDialog(context: context, docId: docId, initialData: data),
                        ),
                        // DELETE (D) Button
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () => _deleteCareer(docId),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      // CREATE (C) Action Trigger
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF00796B),
        onPressed: () => _showCareerFormDialog(context: context),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Career', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/feedback_analytics_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
// import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';
// import 'package:myapp/screens/ProfessionalDashboard/success_stories_page.dart';
// // import 'package01/cloud_firestore/cloud_firestore.dart';

// class CareerBankPage extends StatelessWidget {
//   final String userId;
//   const CareerBankPage({Key? key, required this.userId}) : super(key: key);

//   // 1. CREATE (C): Naya career document add karne ke liye
//   // 2. UPDATE (U): Existing career document ko update karne ke liye
//   void _showCareerFormDialog({
//     required BuildContext context,
//     String? docId,
//     Map<String, dynamic>? initialData,
//   }) {
//     final titleController = TextEditingController(text: initialData?['title'] ?? '');
//     final domainController = TextEditingController(text: initialData?['domain'] ?? '');
//     final salaryController = TextEditingController(text: initialData?['expected_salary'] ?? '');
//     final descController = TextEditingController(text: initialData?['description'] ?? '');

//     bool isEdit = docId != null;

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text(
//           isEdit ? 'Edit Career Role' : 'Add New Career Role',
//           style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
//         ),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: const InputDecoration(labelText: 'Career Title (e.g., Flutter Developer)'),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: domainController,
//                 decoration: const InputDecoration(labelText: 'Domain (e.g., Software Engineering)'),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: salaryController,
//                 decoration: const InputDecoration(labelText: 'Expected Salary Range'),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: descController,
//                 maxLines: 2,
//                 decoration: const InputDecoration(labelText: 'Short Description'),
//               ),
//             ],
//           ),
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

//               Map<String, dynamic> careerData = {
//                 'title': title,
//                 'domain': domainController.text.trim().isEmpty ? 'General' : domainController.text.trim(),
//                 'expected_salary': salaryController.text.trim().isEmpty ? '\$60k - \$90k' : salaryController.text.trim(),
//                 'description': descController.text.trim(),
//                 'updated_at': FieldValue.serverTimestamp(),
//               };

//               final db = FirebaseFirestore.instance;

//               if (isEdit) {
//                 // UPDATE (U)
//                 await db.collection('careers_bank').doc(docId).update(careerData);
//               } else {
//                 // CREATE (C)
//                 careerData['created_at'] = FieldValue.serverTimestamp();
//                 await db.collection('careers_bank').add(careerData);
//               }

//               if (ctx.mounted) Navigator.pop(ctx);
//             },
//             child: Text(isEdit ? 'Update' : 'Save', style: const TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   // 3. DELETE (D): Firestore Document Remove karne ke liye
//   Future<void> _deleteCareer(String docId) async {
//     await FirebaseFirestore.instance.collection('careers_bank').doc(docId).delete();
//   }

//   // Helper Function: Quick Bookmark Option
//   Future<void> _bookmarkCareer(BuildContext context, Map<String, dynamic> career) async {
//     final db = FirebaseFirestore.instance;
//     await db.collection('bookmarks').add({
//       'user_id': userId,
//       'title': career['title'] ?? 'Career Item',
//       'type': 'Career',
//       'note': 'Saved from Career Bank',
//       'created_at': FieldValue.serverTimestamp(),
//     });

//     await db.collection('user_stats').doc(userId).set({
//       'saved_careers_count': FieldValue.increment(1),
//     }, SetOptions(merge: true));

//     if (context.mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('${career['title']} saved to your Bookmarks!'),
//           backgroundColor: const Color(0xFF00796B),
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
//         title: const Text('Career Bank', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: const Color(0xFF00796B),
//       ),
//       drawer: Drawer(
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
//                  Navigator.push(
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

//       // 4. READ (R): Real-time Stream Engine
//       body: StreamBuilder<QuerySnapshot>(
//         stream: db.collection('careers_bank').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Text(
//                   'No careers available in Database.\nTap + button to add a new career role.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16, color: Color(0xFF004D40), fontWeight: FontWeight.w500),
//                 ),
//               ),
//             );
//           }

//           var docs = snapshot.data!.docs;

//           return ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: docs.length,
//             itemBuilder: (context, index) {
//               var data = docs[index].data() as Map<String, dynamic>;
//               String docId = docs[index].id;

//               return Card(
//                 elevation: 2,
//                 margin: const EdgeInsets.only(bottom: 12),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: ListTile(
//                     leading: const CircleAvatar(
//                       backgroundColor: Color(0xFFB2DFDB),
//                       child: Icon(Icons.work_outline, color: Color(0xFF00796B)),
//                     ),
//                     title: Text(
//                       data['title'] ?? 'Career Role',
//                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Color(0xFF004D40)),
//                     ),
//                     subtitle: Padding(
//                       padding: const EdgeInsets.only(top: 6.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Domain: ${data['domain'] ?? 'N/A'}', style: const TextStyle(fontWeight: FontWeight.w600)),
//                           Text('Salary: ${data['expected_salary'] ?? 'N/A'}', style: const TextStyle(color: Color(0xFF00796B))),
//                           if (data['description'] != null && data['description'].toString().isNotEmpty)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 4.0),
//                               child: Text(data['description'], style: const TextStyle(color: Colors.black87, fontSize: 13)),
//                             ),
//                         ],
//                       ),
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // Bookmark Action
//                         IconButton(
//                           icon: const Icon(Icons.bookmark_add_outlined, color: Color(0xFF00796B)),
//                           onPressed: () => _bookmarkCareer(context, data),
//                         ),
//                         // EDIT (U) Button
//                         IconButton(
//                           icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey),
//                           onPressed: () => _showCareerFormDialog(context: context, docId: docId, initialData: data),
//                         ),
//                         // DELETE (D) Button
//                         IconButton(
//                           icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
//                           onPressed: () => _deleteCareer(docId),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),

//       // CREATE (C) Action Trigger
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: const Color(0xFF00796B),
//         onPressed: () => _showCareerFormDialog(context: context),
//         icon: const Icon(Icons.add, color: Colors.white),
//         label: const Text('Add Career', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//       ),
//     );
//   }
// }