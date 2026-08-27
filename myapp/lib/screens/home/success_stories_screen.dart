import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SuccessStoriesScreen extends StatelessWidget {
  const SuccessStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";

    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        title: const Text(
          "Success Stories",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Stream Firestore database
        stream: firestore
            .collection("success_stories")
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF00C2FF)),
            );
          }

          // Approved stories + User's own pending stories filter
          List<DocumentSnapshot> docs = [];
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            docs = snapshot.data!.docs.where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final bool isApproved = data["isApproved"] == true;
              final bool isMyStory = data["userId"] == currentUserId;
              return isApproved || isMyStory;
            }).toList();
          }

          // Database khali hone par Demo/Dummy stories automatic show hongi
          if (docs.isEmpty) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildStoryCard(
                  authorName: "Sarah Ahmed",
                  achievedRole: "Flutter Developer",
                  storyText: "Career Path application helped me structure my learning path. Within 6 months of daily practice and quizzes, I cracked my first remote software developer role!",
                  statusTag: "Verified Story",
                  tagColor: const Color(0xFF00C2FF),
                ),
                _buildStoryCard(
                  authorName: "Muhammad Ali",
                  achievedRole: "Data Analyst",
                  storyText: "The resource bank and guidance on this portal gave me direct clarity on which certifications to target. Highly recommended for graduates!",
                  statusTag: "Verified Story",
                  tagColor: const Color(0xFF00C2FF),
                ),
              ],
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final bool isApproved = data["isApproved"] == true;

              return _buildStoryCard(
                authorName: data["authorName"] ?? "Anonymous Student",
                achievedRole: data["achievedRole"] ?? "Achiever",
                storyText: data["storyText"] ?? "",
                statusTag: isApproved ? "Approved" : "Pending Review",
                tagColor: isApproved ? const Color(0xFF00C2FF) : Colors.orangeAccent,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF00C2FF),
        foregroundColor: const Color(0xFF0B1220),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SubmitSuccessStoryScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text(
          "Share Your Story",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildStoryCard({
    required String authorName,
    required String achievedRole,
    required String storyText,
    required String statusTag,
    required Color tagColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
              Expanded(
                child: Text(
                  authorName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  statusTag == "Approved" ? achievedRole : "$achievedRole ($statusTag)",
                  style: TextStyle(
                    color: tagColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            storyText,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class SubmitSuccessStoryScreen extends StatefulWidget {
  const SubmitSuccessStoryScreen({super.key});

  @override
  State<SubmitSuccessStoryScreen> createState() =>
      _SubmitSuccessStoryScreenState();
}

class _SubmitSuccessStoryScreenState extends State<SubmitSuccessStoryScreen> {
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  bool isSubmitting = false;

  Future<void> _submitStory() async {
    if (_roleController.text.trim().isEmpty ||
        _storyController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
      return;
    }

    setState(() => isSubmitting = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      final userData = userDoc.data() as Map<String, dynamic>?;
      final String authorName = userData?["name"] ?? "Student";

      await FirebaseFirestore.instance.collection("success_stories").add({
        "userId": user.uid,
        "authorName": authorName,
        "achievedRole": _roleController.text.trim(),
        "storyText": _storyController.text.trim(),
        "timestamp": FieldValue.serverTimestamp(),
        "isApproved": false,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Story submitted successfully! It will appear under review in your feed.",
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      debugPrint("Error submitting story: $e");
      setState(() => isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to submit story. Try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        title: const Text(
          "Submit Success Story",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Achieved Your Career Goal?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Share your journey with other students. Once reviewed by our team, it will be published to the community feed.",
              style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 24),
            const Text(
              "Achieved Role / Milestone",
              style: TextStyle(
                color: Color(0xFF00C2FF),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _roleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "e.g., Junior Software Engineer at TechCorp",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF151F32),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your Success Story",
              style: TextStyle(
                color: Color(0xFF00C2FF),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _storyController,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Describe how this platform helped you achieve your goal...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF151F32),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : _submitStory,
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
                    : const Text(
                        "Submit For Approval",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}