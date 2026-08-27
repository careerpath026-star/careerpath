import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EngageScreen extends StatefulWidget {
  const EngageScreen({super.key});

  @override
  State<EngageScreen> createState() => _EngageScreenState();
}

class _EngageScreenState extends State<EngageScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        title: const Text(
          "Student Engagement",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF00C2FF),
          labelColor: const Color(0xFF00C2FF),
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(text: "Bookmarks"),
            Tab(text: "Stories"),
            Tab(text: "Feedback"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          BookmarksTab(),
          SuccessStoriesTab(),
          FeedbackTab(),
        ],
      ),
    );
  }
}

// ==========================================
// 1. BOOKMARKS & NOTES TAB
// ==========================================
class BookmarksTab extends StatelessWidget {
  const BookmarksTab({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return const Center(child: Text("Please login to see bookmarks", style: TextStyle(color: Colors.white54)));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("bookmarks")
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF00C2FF)));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No bookmarked items or notes yet.", style: TextStyle(color: Colors.white54)),
          );
        }

        final docs = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final docId = docs[index].id;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF151F32),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data["title"] ?? "Untitled",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(uid)
                              .collection("bookmarks")
                              .doc(docId)
                              .delete();
                        },
                      )
                    ],
                  ),
                  if (data["note"] != null && data["note"].toString().isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      "Note: ${data['note']}",
                      style: const TextStyle(color: Colors.white70, fontSize: 13, fontStyle: FontStyle.italic),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ==========================================
// 2. SUCCESS STORIES TAB
// ==========================================
class SuccessStoriesTab extends StatelessWidget {
  const SuccessStoriesTab({super.key});

  void _showSubmitDialog(BuildContext context) {
    final titleController = TextEditingController();
    final storyController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF151F32),
        title: const Text("Share Your Success Story", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Title (e.g. Got hired as Flutter Dev!)",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: storyController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Share details of your journey...",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel", style: TextStyle(color: Colors.white54)),
          ),
       ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF00C2FF),
  ),
  onPressed: () async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && titleController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("successStories").add({
        "uid": user.uid,
        "authorName": user.displayName ?? user.email ?? "Anonymous",
        "title": titleController.text.trim(),
        "story": storyController.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
      });
      if (ctx.mounted) Navigator.pop(ctx);
    }
  },
  child: const Text("Submit", style: TextStyle(color: Colors.black)),
)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF00C2FF),
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text("Share Story", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        onPressed: () => _showSubmitDialog(context),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("successStories").orderBy("createdAt", descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF00C2FF)));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No success stories published yet.", style: TextStyle(color: Colors.white54)));
          }

          final docs = snapshot.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF151F32),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["title"] ?? "Story",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "By ${data['authorName'] ?? 'Anonymous'}",
                      style: const TextStyle(color: Color(0xFF00C2FF), fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data["story"] ?? "",
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ==========================================
// 3. FEEDBACK TAB
// ==========================================
class FeedbackTab extends StatefulWidget {
  const FeedbackTab({super.key});

  @override
  State<FeedbackTab> createState() => _FeedbackTabState();
}

class _FeedbackTabState extends State<FeedbackTab> {
  final TextEditingController _feedbackController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitFeedback() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || _feedbackController.text.trim().isEmpty) return;

    setState(() => _isSubmitting = true);
    try {
      await FirebaseFirestore.instance.collection("feedbacks").add({
        "uid": user.uid,
        "email": user.email,
        "message": _feedbackController.text.trim(),
        "status": "pending",
        "createdAt": FieldValue.serverTimestamp(),
      });

      _feedbackController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Colors.green, content: Text("Feedback submitted successfully!")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.redAccent, content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Send System Feedback",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            "Have an issue or suggestions? Send your feedback and get responses in your notifications.",
            style: TextStyle(color: Colors.white60, fontSize: 13),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _feedbackController,
            maxLines: 5,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Write your feedback here...",
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: const Color(0xFF151F32),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C2FF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _isSubmitting ? null : _submitFeedback,
              child: _isSubmitting
                  ? const CircularProgressIndicator(color: Colors.black)
                  : const Text("Submit Feedback", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}