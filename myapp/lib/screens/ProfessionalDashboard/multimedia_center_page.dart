// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// // import 'package0:cloud_firestore/cloud_firestore.dart';

// class MultimediaCenterPage extends StatefulWidget {
//   final String userId;
//   const MultimediaCenterPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<MultimediaCenterPage> createState() => _MultimediaCenterPageState();
// }

// class _MultimediaCenterPageState extends State<MultimediaCenterPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//   bool showTranscript = false;

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: ThemeData(
//         useMaterial3: true,
//         scaffoldBackgroundColor: const Color(0xFFE0F2F1), // Soft Light Mint Teal
//         // Material 3 ke mutabiq CardThemeData fix kiya gaya hai
//         cardTheme: CardThemeData(
//           color: Colors.white,
//           elevation: 2,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Multimedia & Explainers', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
//                 leading: const Icon(Icons.video_library_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Multimedia Center', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
//                 onTap: () => Navigator.pop(context),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.podcasts_outlined, color: Color(0xFF78909C)),
//                 title: const Text('Audio Explainers & Podcasts'),
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
//               // Video Player Placeholder Widget
//               Container(
//                 height: 180,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.black87, 
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Icon(Icons.play_circle_fill, color: Color(0xFF26A69A), size: 50),
//                     SizedBox(height: 8),
//                     Text('Embedded Video Streaming Player', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF00796B), 
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     icon: const Icon(Icons.text_snippet_outlined),
//                     label: Text(showTranscript ? 'Hide Transcript' : 'Toggle Transcript'),
//                     onPressed: () => setState(() => showTranscript = !showTranscript),
//                   ),
//                 ],
//               ),
//               if (showTranscript)
//                 Container(
//                   padding: const EdgeInsets.all(14),
//                   margin: const EdgeInsets.only(top: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.white, 
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: const Color(0xFFB2DFDB)),
//                   ),
//                   child: const Text(
//                     'Transcript: Welcome to career exploration. In this module we analyze software engineering paths, AI developments, and required industry skills...',
//                     style: TextStyle(color: Color(0xFF004D40), height: 1.4),
//                   ),
//                 ),
//               const SizedBox(height: 24),

//               // Firestore Dynamic Media Collection
//               const Text('Available Multimedia', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//               const SizedBox(height: 10),
//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('multimedia').snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//                   }

//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Card(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Text('No multimedia content available.', style: TextStyle(color: Colors.grey)),
//                       ),
//                     );
//                   }

//                   return Column(
//                     children: snapshot.data!.docs.map((doc) {
//                       var data = doc.data() as Map<String, dynamic>;
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 10),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                           leading: CircleAvatar(
//                             backgroundColor: const Color(0xFFB2DFDB),
//                             child: Icon(
//                               data['type'] == 'Video' ? Icons.video_library : Icons.podcasts, 
//                               color: const Color(0xFF00796B),
//                             ),
//                           ),
//                           title: Text(data['title'] ?? 'Media Title', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//                           subtitle: Text('Category: ${data['category'] ?? 'General'} | Tag: ${data['tag'] ?? 'All'}', style: const TextStyle(color: Color(0xFF78909C))),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.thumb_up_outlined, color: Color(0xFF00796B)),
//                             onPressed: () async {
//                               await db.collection('multimedia').doc(doc.id).update({
//                                 'rating_count': FieldValue.increment(1),
//                               });
//                             },
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
// import 'package:webview_flutter/webview_flutter.dart';

// class MultimediaCenterPage extends StatefulWidget {
//   final String userId;
//   const MultimediaCenterPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<MultimediaCenterPage> createState() => _MultimediaCenterPageState();
// }

// class _MultimediaCenterPageState extends State<MultimediaCenterPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   WebViewController? _webViewController;
//   String _currentTitle = "Select a Video to Play";
//   String _currentTranscript = "Select any media item below to view its full interactive transcript.";
//   bool _showTranscript = false;

//   @override
//   void initState() {
//     super.initState();
//     // Default embedding a sample educational video URL
//     _initWebView('https://www.youtube.com/embed/fq4N0hgOWzU');
//   }

//   void _initWebView(String url) {
//     // Agar user ne standard watch link diya hai toh usko embed link mein convert karlein
//     String embedUrl = url;
//     if (url.contains('watch?v=')) {
//       embedUrl = url.replaceAll('watch?v=', 'embed/');
//     } else if (url.contains('youtu.be/')) {
//       embedUrl = url.replaceAll('youtu.be/', 'www.youtube.com/embed/');
//     }

//     _webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.black)
//       ..loadRequest(Uri.parse(embedUrl));
    
//     if (mounted) setState(() {});
//   }

//   // ---------------- FIRESTORE DYNAMIC CRUD OPERATIONS ----------------

//   // 1. CREATE / UPDATE MEDIA ITEM
//   void _showMediaFormDialog({String? docId, Map<String, dynamic>? initialData}) {
//     final titleController = TextEditingController(text: initialData?['title'] ?? '');
//     final categoryController = TextEditingController(text: initialData?['category'] ?? '');
//     final tagController = TextEditingController(text: initialData?['tag'] ?? '');
//     final videoUrlController = TextEditingController(text: initialData?['video_url'] ?? '');
//     final transcriptController = TextEditingController(text: initialData?['transcript'] ?? '');
//     String type = initialData?['type'] ?? 'Video';

//     bool isEdit = docId != null;

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text(
//           isEdit ? 'Edit Multimedia Content' : 'Add New Multimedia',
//           style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
//         ),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: const InputDecoration(labelText: 'Media Title'),
//               ),
//               const SizedBox(height: 8),
//               StatefulBuilder(
//                 builder: (context, setDialogState) => DropdownButtonFormField<String>(
//                   value: type,
//                   items: ['Video', 'Podcast']
//                       .map((t) => DropdownMenuItem(value: t, child: Text(t)))
//                       .toList(),
//                   onChanged: (val) => setDialogState(() => type = val!),
//                   decoration: const InputDecoration(labelText: 'Media Type'),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: categoryController,
//                 decoration: const InputDecoration(labelText: 'Category (e.g. Software, AI)'),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: tagController,
//                 decoration: const InputDecoration(labelText: 'Tag / Level (e.g. Beginner)'),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: videoUrlController,
//                 decoration: const InputDecoration(labelText: 'YouTube Link (e.g. https://youtu.be/...)'),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: transcriptController,
//                 maxLines: 3,
//                 decoration: const InputDecoration(labelText: 'Full Transcript Text'),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
//             onPressed: () async {
//               String title = titleController.text.trim();
//               String url = videoUrlController.text.trim();
//               if (title.isEmpty || url.isEmpty) return;

//               Map<String, dynamic> mediaData = {
//                 'title': title,
//                 'type': type,
//                 'category': categoryController.text.trim(),
//                 'tag': tagController.text.trim(),
//                 'video_url': url,
//                 'transcript': transcriptController.text.trim(),
//                 'updated_at': DateTime.now().toIso8601String(),
//               };

//               if (!isEdit) {
//                 mediaData['views'] = 0;
//                 mediaData['likes'] = 0;
//                 await db.collection('multimedia').add(mediaData);
//               } else {
//                 await db.collection('multimedia').doc(docId).update(mediaData);
//               }

//               if (ctx.mounted) Navigator.pop(ctx);
//             },
//             child: Text(isEdit ? 'Update' : 'Save Content', style: const TextStyle(color: Colors.white)),
//           )
//         ],
//       ),
//     );
//   }

//   // 2. DELETE MEDIA ITEM
//   Future<void> _deleteMedia(String docId) async {
//     await db.collection('multimedia').doc(docId).delete();
//   }

//   // 3. SELECT AND PLAY MEDIA VIA WEBVIEW
//   void _playMedia(String docId, Map<String, dynamic> data) {
//     setState(() {
//       _currentTitle = data['title'] ?? 'Playing Media';
//       _currentTranscript = data['transcript'] ?? 'No transcript provided for this content.';
//     });

//     String url = data['video_url'] ?? '';
//     if (url.isNotEmpty) {
//       _initWebView(url);
//     }

//     // Increment Views in Database
//     db.collection('multimedia').doc(docId).update({
//       'views': FieldValue.increment(1),
//     });
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
//           title: const Text('Multimedia & Explainers', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
//                 leading: const Icon(Icons.video_library_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Multimedia Center', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
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
//               // EMBEDDED VIDEO / AUDIO PLAYER VIA WEBVIEW (Error Free)
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   height: 200,
//                   color: Colors.black,
//                   child: _webViewController != null
//                       ? WebViewWidget(controller: _webViewController!)
//                       : const Center(child: CircularProgressIndicator(color: Colors.white)),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // TITLE & TRANSCRIPT TOGGLE
//               Text(
//                 _currentTitle,
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//               ),
//               const SizedBox(height: 8),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF00796B),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     icon: const Icon(Icons.text_snippet_outlined),
//                     label: Text(_showTranscript ? 'Hide Transcript' : 'Toggle Transcript'),
//                     onPressed: () => setState(() => _showTranscript = !_showTranscript),
//                   ),
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF004D40),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     icon: const Icon(Icons.add),
//                     label: const Text('Add Media Link'),
//                     onPressed: () => _showMediaFormDialog(),
//                   ),
//                 ],
//               ),

//               if (_showTranscript)
//                 Container(
//                   padding: const EdgeInsets.all(14),
//                   margin: const EdgeInsets.only(top: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: const Color(0xFFB2DFDB)),
//                   ),
//                   child: Text(
//                     _currentTranscript,
//                     style: const TextStyle(color: Color(0xFF004D40), height: 1.4),
//                   ),
//                 ),
//               const SizedBox(height: 24),

//               // DATABASE LIST (FIRESTORE)
//               const Text('Saved Media Links in DB', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//               const SizedBox(height: 10),

//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('multimedia').snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//                   }

//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Card(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Text('No media links saved in database yet. Click "Add Media Link".', style: TextStyle(color: Colors.grey)),
//                       ),
//                     );
//                   }

//                   return Column(
//                     children: snapshot.data!.docs.map((doc) {
//                       var data = doc.data() as Map<String, dynamic>;

//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 10),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                           onTap: () => _playMedia(doc.id, data),
//                           leading: CircleAvatar(
//                             backgroundColor: const Color(0xFFB2DFDB),
//                             child: Icon(
//                               data['type'] == 'Video' ? Icons.play_arrow : Icons.podcasts,
//                               color: const Color(0xFF00796B),
//                             ),
//                           ),
//                           title: Text(data['title'] ?? 'Media Title', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//                           subtitle: Text(
//                             'Cat: ${data['category'] ?? 'General'} | Views: ${data['views'] ?? 0} | Likes: ${data['likes'] ?? 0}',
//                             style: const TextStyle(color: Color(0xFF78909C), fontSize: 12),
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.thumb_up_outlined, color: Color(0xFF00796B), size: 20),
//                                 onPressed: () async {
//                                   await db.collection('multimedia').doc(doc.id).update({
//                                     'likes': FieldValue.increment(1),
//                                   });
//                                 },
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey, size: 20),
//                                 onPressed: () => _showMediaFormDialog(docId: doc.id, initialData: data),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
//                                 onPressed: () => _deleteMedia(doc.id),
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




// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class MultimediaCenterPage extends StatefulWidget {
//   final String userId;
//   const MultimediaCenterPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<MultimediaCenterPage> createState() => _MultimediaCenterPageState();
// }

// class _MultimediaCenterPageState extends State<MultimediaCenterPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   late final WebViewController _webViewController;
//   bool _isWebViewReady = false;
//   String _currentTitle = "Select a Video to Play";
//   String _currentTranscript = "Select any media item below to view its full interactive transcript.";
//   bool _showTranscript = false;

//   @override
//   void initState() {
//     super.initState();
//     _initWebView('https://www.youtube.com/embed/fq4N0hgOWzU');
//   }

//   void _initWebView(String url) {
//     String embedUrl = url;
//     if (url.contains('watch?v=')) {
//       embedUrl = url.replaceAll('watch?v=', 'embed/');
//     } else if (url.contains('youtu.be/')) {
//       embedUrl = url.replaceAll('youtu.be/', 'www.youtube.com/embed/');
//     }

//     _webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.black)
//       ..loadRequest(Uri.parse(embedUrl));

//     setState(() {
//       _isWebViewReady = true;
//     });
//   }

//   // ---------------- FULL CRUD OPERATIONS ----------------

//   void _showMediaFormDialog({String? docId, Map<String, dynamic>? initialData}) {
//     final titleController = TextEditingController(text: initialData?['title'] ?? '');
//     final categoryController = TextEditingController(text: initialData?['category'] ?? '');
//     final tagController = TextEditingController(text: initialData?['tag'] ?? '');
//     final videoUrlController = TextEditingController(text: initialData?['video_url'] ?? '');
//     final transcriptController = TextEditingController(text: initialData?['transcript'] ?? '');
//     String type = initialData?['type'] ?? 'Video';

//     bool isEdit = docId != null;

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text(
//           isEdit ? 'Update Multimedia Content' : 'Add New Multimedia',
//           style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
//         ),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: const InputDecoration(labelText: 'Media Title'),
//               ),
//               const SizedBox(height: 8),
//               StatefulBuilder(
//                 builder: (context, setDialogState) => DropdownButtonFormField<String>(
//                   value: type,
//                   items: ['Video', 'Podcast']
//                       .map((t) => DropdownMenuItem(value: t, child: Text(t)))
//                       .toList(),
//                   onChanged: (val) => setDialogState(() => type = val!),
//                   decoration: const InputDecoration(labelText: 'Media Type'),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: categoryController,
//                 decoration: const InputDecoration(labelText: 'Category (e.g. Software, AI)'),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: tagController,
//                 decoration: const InputDecoration(labelText: 'Tag / Level (e.g. Beginner)'),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: videoUrlController,
//                 decoration: const InputDecoration(labelText: 'YouTube Link (e.g. https://youtu.be/...)'),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: transcriptController,
//                 maxLines: 3,
//                 decoration: const InputDecoration(labelText: 'Full Transcript Text'),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
//             onPressed: () async {
//               String title = titleController.text.trim();
//               String url = videoUrlController.text.trim();
//               if (title.isEmpty || url.isEmpty) return;

//               Map<String, dynamic> mediaData = {
//                 'title': title,
//                 'type': type,
//                 'category': categoryController.text.trim(),
//                 'tag': tagController.text.trim(),
//                 'video_url': url,
//                 'transcript': transcriptController.text.trim(),
//                 'updated_at': DateTime.now().toIso8601String(),
//               };

//               if (!isEdit) {
//                 mediaData['views'] = 0;
//                 mediaData['likes'] = 0;
//                 await db.collection('multimedia').add(mediaData);
//               } else {
//                 await db.collection('multimedia').doc(docId).update(mediaData);
//               }

//               if (ctx.mounted) Navigator.pop(ctx);
//             },
//             child: Text(isEdit ? 'Update' : 'Save', style: const TextStyle(color: Colors.white)),
//           )
//         ],
//       ),
//     );
//   }

//   Future<void> _deleteMedia(String docId) async {
//     await db.collection('multimedia').doc(docId).delete();
//   }

//   void _playMedia(String docId, Map<String, dynamic> data) {
//     setState(() {
//       _currentTitle = data['title'] ?? 'Playing Media';
//       _currentTranscript = data['transcript'] ?? 'No transcript provided for this content.';
//     });

//     String url = data['video_url'] ?? '';
//     if (url.isNotEmpty) {
//       _initWebView(url);
//     }

//     db.collection('multimedia').doc(docId).update({
//       'views': FieldValue.increment(1),
//     });
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
//           title: const Text('Multimedia & Explainers', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
//                 leading: const Icon(Icons.video_library_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Multimedia Center', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
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
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   height: 200,
//                   color: Colors.black,
//                   child: _isWebViewReady
//                       ? WebViewWidget(controller: _webViewController)
//                       : const Center(child: CircularProgressIndicator(color: Colors.white)),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 _currentTitle,
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF00796B),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     icon: const Icon(Icons.text_snippet_outlined),
//                     label: Text(_showTranscript ? 'Hide Transcript' : 'Toggle Transcript'),
//                     onPressed: () => setState(() => _showTranscript = !_showTranscript),
//                   ),
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF004D40),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     icon: const Icon(Icons.add),
//                     label: const Text('Add Media Link'),
//                     onPressed: () => _showMediaFormDialog(),
//                   ),
//                 ],
//               ),
//               if (_showTranscript)
//                 Container(
//                   padding: const EdgeInsets.all(14),
//                   margin: const EdgeInsets.only(top: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: const Color(0xFFB2DFDB)),
//                   ),
//                   child: Text(
//                     _currentTranscript,
//                     style: const TextStyle(color: Color(0xFF004D40), height: 1.4),
//                   ),
//                 ),
//               const SizedBox(height: 24),
//               const Text('Saved Media Links in DB', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//               const SizedBox(height: 10),
//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('multimedia').snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//                   }

//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Card(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Text('No media links saved in database yet. Click "Add Media Link".', style: TextStyle(color: Colors.grey)),
//                       ),
//                     );
//                   }

//                   return Column(
//                     children: snapshot.data!.docs.map((doc) {
//                       var data = doc.data() as Map<String, dynamic>;

//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 10),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                           onTap: () => _playMedia(doc.id, data),
//                           leading: CircleAvatar(
//                             backgroundColor: const Color(0xFFB2DFDB),
//                             child: Icon(
//                               data['type'] == 'Video' ? Icons.play_arrow : Icons.podcasts,
//                               color: const Color(0xFF00796B),
//                             ),
//                           ),
//                           title: Text(data['title'] ?? 'Media Title', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//                           subtitle: Text(
//                             'Cat: ${data['category'] ?? 'General'} | Views: ${data['views'] ?? 0} | Likes: ${data['likes'] ?? 0}',
//                             style: const TextStyle(color: Color(0xFF78909C), fontSize: 12),
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.thumb_up_outlined, color: Color(0xFF00796B), size: 20),
//                                 onPressed: () async {
//                                   await db.collection('multimedia').doc(doc.id).update({
//                                     'likes': FieldValue.increment(1),
//                                   });
//                                 },
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey, size: 20),
//                                 onPressed: () => _showMediaFormDialog(docId: doc.id, initialData: data),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
//                                 onPressed: () => _deleteMedia(doc.id),
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









import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/career_bank_screen.dart';
import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/feedback_analytics_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
import 'package:myapp/screens/ProfessionalDashboard/success_stories_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MultimediaCenterPage extends StatefulWidget {
  final String userId;
  const MultimediaCenterPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<MultimediaCenterPage> createState() => _MultimediaCenterPageState();
}

class _MultimediaCenterPageState extends State<MultimediaCenterPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  String _currentTitle = "Select a Video to Play";
  String _currentTranscript = "Select any media item below to view its full interactive transcript.";
  String _currentVideoUrl = '';
  bool _showTranscript = false;

  // ---------------- LAUNCH URL FUNCTION ----------------
  Future<void> _launchYouTubeUrl(String url) async {
    if (url.isEmpty) return;
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  // ---------------- FULL CRUD OPERATIONS ----------------

  void _showMediaFormDialog({String? docId, Map<String, dynamic>? initialData}) {
    final titleController = TextEditingController(text: initialData?['title'] ?? '');
    final categoryController = TextEditingController(text: initialData?['category'] ?? '');
    final tagController = TextEditingController(text: initialData?['tag'] ?? '');
    final videoUrlController = TextEditingController(text: initialData?['video_url'] ?? '');
    final transcriptController = TextEditingController(text: initialData?['transcript'] ?? '');
    String type = initialData?['type'] ?? 'Video';

    bool isEdit = docId != null;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          isEdit ? 'Update Multimedia Content' : 'Add New Multimedia',
          style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Media Title'),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (context, setDialogState) => DropdownButtonFormField<String>(
                  value: type,
                  items: ['Video', 'Podcast']
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (val) => setDialogState(() => type = val!),
                  decoration: const InputDecoration(labelText: 'Media Type'),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category (e.g. Software, AI)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: tagController,
                decoration: const InputDecoration(labelText: 'Tag / Level (e.g. Beginner)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: videoUrlController,
                decoration: const InputDecoration(labelText: 'YouTube Link (e.g. https://youtu.be/...)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: transcriptController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Full Transcript Text'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
            onPressed: () async {
              String title = titleController.text.trim();
              String url = videoUrlController.text.trim();
              if (title.isEmpty || url.isEmpty) return;

              Map<String, dynamic> mediaData = {
                'title': title,
                'type': type,
                'category': categoryController.text.trim(),
                'tag': tagController.text.trim(),
                'video_url': url,
                'transcript': transcriptController.text.trim(),
                'updated_at': DateTime.now().toIso8601String(),
              };

              if (!isEdit) {
                mediaData['views'] = 0;
                mediaData['likes'] = 0;
                await db.collection('multimedia').add(mediaData);
              } else {
                await db.collection('multimedia').doc(docId).update(mediaData);
              }

              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: Text(isEdit ? 'Update' : 'Save', style: const TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Future<void> _deleteMedia(String docId) async {
    await db.collection('multimedia').doc(docId).delete();
  }

  void _selectMedia(String docId, Map<String, dynamic> data) {
    setState(() {
      _currentTitle = data['title'] ?? 'Playing Media';
      _currentTranscript = data['transcript'] ?? 'No transcript provided for this content.';
      _currentVideoUrl = data['video_url'] ?? '';
    });

    db.collection('multimedia').doc(docId).update({
      'views': FieldValue.increment(1),
    });
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
          title: const Text('Multimedia & Explainers', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              // --- YOUTUBE PLAYER BANNER (OPENS IN YOUTUBE APP/BROWSER) ---
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: const Color(0xFF004D40),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF00796B), Color(0xFF004D40)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.play_circle_fill, color: Colors.white, size: 64),
                            onPressed: () => _launchYouTubeUrl(_currentVideoUrl),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              _currentTitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          const Text(
                            'Tap to watch on YouTube',
                            style: TextStyle(fontSize: 12, color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00796B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.text_snippet_outlined),
                    label: Text(_showTranscript ? 'Hide Transcript' : 'Toggle Transcript'),
                    onPressed: () => setState(() => _showTranscript = !_showTranscript),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004D40),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Media Link'),
                    onPressed: () => _showMediaFormDialog(),
                  ),
                ],
              ),
              if (_showTranscript)
                Container(
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFB2DFDB)),
                  ),
                  child: Text(
                    _currentTranscript,
                    style: const TextStyle(color: Color(0xFF004D40), height: 1.4),
                  ),
                ),
              const SizedBox(height: 24),
              const Text('Saved Media Links in DB', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: db.collection('multimedia').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No media links saved in database yet. Click "Add Media Link".', style: TextStyle(color: Colors.grey)),
                      ),
                    );
                  }

                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      var data = doc.data() as Map<String, dynamic>;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          onTap: () => _selectMedia(doc.id, data),
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFB2DFDB),
                            child: Icon(
                              data['type'] == 'Video' ? Icons.play_arrow : Icons.podcasts,
                              color: const Color(0xFF00796B),
                            ),
                          ),
                          title: Text(data['title'] ?? 'Media Title', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
                          subtitle: Text(
                            'Cat: ${data['category'] ?? 'General'} | Views: ${data['views'] ?? 0} | Likes: ${data['likes'] ?? 0}',
                            style: const TextStyle(color: Color(0xFF78909C), fontSize: 12),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.thumb_up_outlined, color: Color(0xFF00796B), size: 20),
                                onPressed: () async {
                                  await db.collection('multimedia').doc(doc.id).update({
                                    'likes': FieldValue.increment(1),
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey, size: 20),
                                onPressed: () => _showMediaFormDialog(docId: doc.id, initialData: data),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                onPressed: () => _deleteMedia(doc.id),
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






// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class MultimediaCenterPage extends StatefulWidget {
//   final String userId;
//   const MultimediaCenterPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<MultimediaCenterPage> createState() => _MultimediaCenterPageState();
// }

// class _MultimediaCenterPageState extends State<MultimediaCenterPage> {
//   final FirebaseFirestore db = FirebaseFirestore.instance;

//   WebViewController? _webViewController;
//   String _currentTitle = "Select a Video to Play";
//   String _currentTranscript = "Select any media item below to view its full interactive transcript.";
//   bool _showTranscript = false;

//   @override
//   void initState() {
//     super.initState();
//     _initWebView('https://www.youtube.com/embed/fq4N0hgOWzU');
//   }

//   void _initWebView(String url) {
//     String embedUrl = url;
//     if (url.contains('watch?v=')) {
//       embedUrl = url.replaceAll('watch?v=', 'embed/');
//     } else if (url.contains('youtu.be/')) {
//       embedUrl = url.replaceAll('youtu.be/', 'www.youtube.com/embed/');
//     }

//     _webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.black)
//       ..loadRequest(Uri.parse(embedUrl));
    
//     if (mounted) setState(() {});
//   }

//   // ---------------- FULL CRUD OPERATIONS ----------------

//   // 1. CREATE & UPDATE (Dialog for Add / Edit)
//   void _showMediaFormDialog({String? docId, Map<String, dynamic>? initialData}) {
//     final titleController = TextEditingController(text: initialData?['title'] ?? '');
//     final categoryController = TextEditingController(text: initialData?['category'] ?? '');
//     final tagController = TextEditingController(text: initialData?['tag'] ?? '');
//     final videoUrlController = TextEditingController(text: initialData?['video_url'] ?? '');
//     final transcriptController = TextEditingController(text: initialData?['transcript'] ?? '');
//     String type = initialData?['type'] ?? 'Video';

//     bool isEdit = docId != null;

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text(
//           isEdit ? 'Update Multimedia Content' : 'Add New Multimedia',
//           style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
//         ),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: const InputDecoration(labelText: 'Media Title'),
//               ),
//               const SizedBox(height: 8),
//               StatefulBuilder(
//                 builder: (context, setDialogState) => DropdownButtonFormField<String>(
//                   value: type,
//                   items: ['Video', 'Podcast']
//                       .map((t) => DropdownMenuItem(value: t, child: Text(t)))
//                       .toList(),
//                   onChanged: (val) => setDialogState(() => type = val!),
//                   decoration: const InputDecoration(labelText: 'Media Type'),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: categoryController,
//                 decoration: const InputDecoration(labelText: 'Category (e.g. Software, AI)'),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: tagController,
//                 decoration: const InputDecoration(labelText: 'Tag / Level (e.g. Beginner)'),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: videoUrlController,
//                 decoration: const InputDecoration(labelText: 'YouTube Link (e.g. https://youtu.be/...)'),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: transcriptController,
//                 maxLines: 3,
//                 decoration: const InputDecoration(labelText: 'Full Transcript Text'),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00796B)),
//             onPressed: () async {
//               String title = titleController.text.trim();
//               String url = videoUrlController.text.trim();
//               if (title.isEmpty || url.isEmpty) return;

//               Map<String, dynamic> mediaData = {
//                 'title': title,
//                 'type': type,
//                 'category': categoryController.text.trim(),
//                 'tag': tagController.text.trim(),
//                 'video_url': url,
//                 'transcript': transcriptController.text.trim(),
//                 'updated_at': DateTime.now().toIso8601String(),
//               };

//               if (!isEdit) {
//                 // CREATE Operation
//                 mediaData['views'] = 0;
//                 mediaData['likes'] = 0;
//                 await db.collection('multimedia').add(mediaData);
//               } else {
//                 // UPDATE Operation
//                 await db.collection('multimedia').doc(docId).update(mediaData);
//               }

//               if (ctx.mounted) Navigator.pop(ctx);
//             },
//             child: Text(isEdit ? 'Update' : 'Save', style: const TextStyle(color: Colors.white)),
//           )
//         ],
//       ),
//     );
//   }

//   // 2. DELETE OPERATION
//   Future<void> _deleteMedia(String docId) async {
//     await db.collection('multimedia').doc(docId).delete();
//   }

//   // 3. READ / PLAY ITEM
//   void _playMedia(String docId, Map<String, dynamic> data) {
//     setState(() {
//       _currentTitle = data['title'] ?? 'Playing Media';
//       _currentTranscript = data['transcript'] ?? 'No transcript provided for this content.';
//     });

//     String url = data['video_url'] ?? '';
//     if (url.isNotEmpty) {
//       _initWebView(url);
//     }

//     db.collection('multimedia').doc(docId).update({
//       'views': FieldValue.increment(1),
//     });
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
//           title: const Text('Multimedia & Explainers', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
//                 leading: const Icon(Icons.video_library_outlined, color: Color(0xFF00796B)),
//                 title: const Text('Multimedia Center', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
//                 selected: true,
//                 selectedTileColor: const Color(0xFFE0F2F1),
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
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   height: 200,
//                   color: Colors.black,
//                   child: _webViewController != null
//                       ? WebViewWidget(controller: _webViewController!)
//                       : const Center(child: CircularProgressIndicator(color: Colors.white)),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 _currentTitle,
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF00796B),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     icon: const Icon(Icons.text_snippet_outlined),
//                     label: Text(_showTranscript ? 'Hide Transcript' : 'Toggle Transcript'),
//                     onPressed: () => setState(() => _showTranscript = !_showTranscript),
//                   ),
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF004D40),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                     icon: const Icon(Icons.add),
//                     label: const Text('Add Media Link'),
//                     onPressed: () => _showMediaFormDialog(),
//                   ),
//                 ],
//               ),
//               if (_showTranscript)
//                 Container(
//                   padding: const EdgeInsets.all(14),
//                   margin: const EdgeInsets.only(top: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: const Color(0xFFB2DFDB)),
//                   ),
//                   child: Text(
//                     _currentTranscript,
//                     style: const TextStyle(color: Color(0xFF004D40), height: 1.4),
//                   ),
//                 ),
//               const SizedBox(height: 24),
//               const Text('Saved Media Links in DB', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//               const SizedBox(height: 10),
//               StreamBuilder<QuerySnapshot>(
//                 stream: db.collection('multimedia').snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator(color: Color(0xFF00796B)));
//                   }

//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Card(
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Text('No media links saved in database yet. Click "Add Media Link".', style: TextStyle(color: Colors.grey)),
//                       ),
//                     );
//                   }

//                   return Column(
//                     children: snapshot.data!.docs.map((doc) {
//                       var data = doc.data() as Map<String, dynamic>;

//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 10),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                           onTap: () => _playMedia(doc.id, data),
//                           leading: CircleAvatar(
//                             backgroundColor: const Color(0xFFB2DFDB),
//                             child: Icon(
//                               data['type'] == 'Video' ? Icons.play_arrow : Icons.podcasts,
//                               color: const Color(0xFF00796B),
//                             ),
//                           ),
//                           title: Text(data['title'] ?? 'Media Title', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40))),
//                           subtitle: Text(
//                             'Cat: ${data['category'] ?? 'General'} | Views: ${data['views'] ?? 0} | Likes: ${data['likes'] ?? 0}',
//                             style: const TextStyle(color: Color(0xFF78909C), fontSize: 12),
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.thumb_up_outlined, color: Color(0xFF00796B), size: 20),
//                                 onPressed: () async {
//                                   await db.collection('multimedia').doc(doc.id).update({
//                                     'likes': FieldValue.increment(1),
//                                   });
//                                 },
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey, size: 20),
//                                 onPressed: () => _showMediaFormDialog(docId: doc.id, initialData: data),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
//                                 onPressed: () => _deleteMedia(doc.id),
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