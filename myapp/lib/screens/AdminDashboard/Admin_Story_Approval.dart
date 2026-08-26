import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminSuccessStoryApproval extends StatefulWidget {
  const AdminSuccessStoryApproval({super.key});

  @override
  State<AdminSuccessStoryApproval> createState() =>
      _AdminSuccessStoryApprovalState();
}

class _AdminSuccessStoryApprovalState
    extends State<AdminSuccessStoryApproval> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = true;

  List<Map<String, dynamic>> pendingStories = [];

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();
    loadPendingStories();
  }

  // ==========================================================
  // LOAD PENDING STORIES
  // ==========================================================

  Future<void> loadPendingStories() async {
    setState(() {
      isLoading = true;
    });

    try {
      final QuerySnapshot snapshot = await _firestore
          .collection("successStories")
          .where("status", isEqualTo: "pending")
          .get();

      final List<Map<String, dynamic>> loadedStories = [];

      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        loadedStories.add({
          "id": doc.id,
          ...data,
        });
      }

      // Newest first
      loadedStories.sort((a, b) {
        final Timestamp? dateA =
            a["createdAt"] is Timestamp ? a["createdAt"] : null;

        final Timestamp? dateB =
            b["createdAt"] is Timestamp ? b["createdAt"] : null;

        if (dateA == null && dateB == null) {
          return 0;
        }

        if (dateA == null) {
          return 1;
        }

        if (dateB == null) {
          return -1;
        }

        return dateB.compareTo(dateA);
      });

      if (!mounted) return;

      setState(() {
        pendingStories = loadedStories;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Load pending stories error: $e");

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Unable to load pending stories.",
          ),
        ),
      );
    }
  }

  // ==========================================================
  // APPROVE STORY
  // ==========================================================

  Future<void> approveStory(
    Map<String, dynamic> story,
  ) async {
    final String storyId = story["id"]?.toString() ?? "";

    if (storyId.isEmpty) {
      return;
    }

    try {
      await _firestore
          .collection("successStories")
          .doc(storyId)
          .update({
        "status": "approved",
        "approvedAt": FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      setState(() {
        pendingStories.removeWhere(
          (item) => item["id"].toString() == storyId,
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Success story approved successfully.",
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      debugPrint("Approve story error: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Could not approve this story.",
          ),
        ),
      );
    }
  }

  // ==========================================================
  // REJECT STORY
  // ==========================================================

  Future<void> rejectStory(
    Map<String, dynamic> story,
  ) async {
    final String storyId = story["id"]?.toString() ?? "";

    if (storyId.isEmpty) {
      return;
    }

    try {
      await _firestore
          .collection("successStories")
          .doc(storyId)
          .update({
        "status": "rejected",
        "rejectedAt": FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      setState(() {
        pendingStories.removeWhere(
          (item) => item["id"].toString() == storyId,
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Success story rejected.",
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      debugPrint("Reject story error: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Could not reject this story.",
          ),
        ),
      );
    }
  }

  // ==========================================================
  // GET VALUE
  // ==========================================================

  String getValue(
    Map<String, dynamic> story,
    String key,
  ) {
    final value = story[key];

    if (value == null) {
      return "Not added";
    }

    final text = value.toString().trim();

    if (text.isEmpty) {
      return "Not added";
    }

    return text;
  }

  // ==========================================================
  // GET PROFILE IMAGE
  // ==========================================================

  String getProfileImage(
    Map<String, dynamic> story,
  ) {
    final possibleKeys = [
      "profileImage",
      "profileImageUrl",
      "image",
      "photoUrl",
      "photoURL",
      "userImage",
    ];

    for (final key in possibleKeys) {
      final value = story[key];

      if (value != null &&
          value.toString().trim().isNotEmpty) {
        return value.toString().trim();
      }
    }

    return "";
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(
          "Success Story Approval",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            tooltip: "Refresh",
            onPressed: loadPendingStories,
            icon: const Icon(
              Icons.refresh,
              color: Color(0xFF00C2FF),
            ),
          ),
        ],
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF00C2FF),
              ),
            )
          : RefreshIndicator(
              color: const Color(0xFF00C2FF),

              backgroundColor:
                  const Color(0xFF151F32),

              onRefresh: loadPendingStories,

              child: pendingStories.isEmpty
                  ? _emptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(18),

                      itemCount:
                          pendingStories.length,

                      itemBuilder:
                          (context, index) {
                        return _storyCard(
                          pendingStories[index],
                        );
                      },
                    ),
            ),
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _emptyState() {
    return ListView(
      physics:
          const AlwaysScrollableScrollPhysics(),

      padding: const EdgeInsets.all(20),

      children: [
        const SizedBox(height: 100),

        const Icon(
          Icons.verified_outlined,
          color: Colors.white24,
          size: 75,
        ),

        const SizedBox(height: 20),

        const Text(
          "No Pending Stories",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          "There are currently no success stories waiting for approval.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 13,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 20),

        Center(
          child: OutlinedButton.icon(
            onPressed: loadPendingStories,

            icon: const Icon(
              Icons.refresh,
              color: Color(0xFF00C2FF),
            ),

            label: const Text(
              "Refresh",
              style: TextStyle(
                color: Color(0xFF00C2FF),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // STORY CARD
  // ==========================================================

  Widget _storyCard(
    Map<String, dynamic> story,
  ) {
    final String title =
        getValue(story, "title");

    final String career =
        getValue(story, "career");

    final String category =
        getValue(story, "category");

    final String successStory =
        getValue(story, "successStory");

    final String achievement =
        getValue(story, "achievement");

    final String company =
        getValue(story, "company");

    final String userName =
        getValue(story, "userName");

    final String role =
        getValue(story, "role");

    final String image =
        getProfileImage(story);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFF151F32),

        borderRadius:
            BorderRadius.circular(20),

        border: Border.all(
          color: Colors.orangeAccent
              .withOpacity(0.25),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(17),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ==================================================
            // USER INFORMATION
            // ==================================================

            Row(
              children: [
                _profileAvatar(
                  image,
                  userName,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        userName,
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,

                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        role,
                        style:
                            const TextStyle(
                          color:
                              Color(0xFF00C2FF),
                          fontSize: 12,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),

                  decoration:
                      BoxDecoration(
                    color: Colors.orange
                        .withOpacity(0.10),

                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: const Text(
                    "PENDING",
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 10,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ==================================================
            // TITLE
            // ==================================================

            Text(
              title,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // ==================================================
            // CAREER + CATEGORY
            // ==================================================

            Wrap(
              spacing: 8,
              runSpacing: 8,

              children: [
                _infoTag(
                  Icons.work_outline,
                  career,
                ),

                _infoTag(
                  Icons.category_outlined,
                  category,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ==================================================
            // SUCCESS STORY
            // ==================================================

            _storySection(
              "Success Story",
              successStory,
              Icons.auto_stories_outlined,
            ),

            // ==================================================
            // ACHIEVEMENT
            // ==================================================

            if (achievement != "Not added") ...[
              const SizedBox(height: 10),

              _storySection(
                "Achievement",
                achievement,
                Icons.emoji_events_outlined,
              ),
            ],

            // ==================================================
            // COMPANY
            // ==================================================

            if (company != "Not added") ...[
              const SizedBox(height: 10),

              _storySection(
                "Company / Organization",
                company,
                Icons.business_outlined,
              ),
            ],

            const SizedBox(height: 18),

            // ==================================================
            // ACTION BUTTONS
            // ==================================================

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _confirmReject(story);
                    },

                    icon: const Icon(
                      Icons.close,
                      size: 18,
                    ),

                    label: const Text(
                      "Reject",
                    ),

                    style:
                        OutlinedButton.styleFrom(
                      foregroundColor:
                          Colors.redAccent,

                      side: BorderSide(
                        color: Colors.redAccent
                            .withOpacity(0.5),
                      ),

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _confirmApprove(story);
                    },

                    icon: const Icon(
                      Icons.check,
                      size: 18,
                    ),

                    label: const Text(
                      "Approve",
                    ),

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF00C2FF,
                      ),

                      foregroundColor:
                          const Color(
                        0xFF0B1220,
                      ),

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // PROFILE AVATAR
  // ==========================================================

  Widget _profileAvatar(
    String image,
    String userName,
  ) {
    if (image.isNotEmpty) {
      return CircleAvatar(
        radius: 27,

        backgroundColor:
            const Color(0xFF00C2FF),

        backgroundImage:
            NetworkImage(image),
      );
    }

    final String firstLetter =
        userName != "Not added" &&
                userName.isNotEmpty
            ? userName[0].toUpperCase()
            : "G";

    return CircleAvatar(
      radius: 27,

      backgroundColor:
          const Color(0xFF00C2FF),

      child: Text(
        firstLetter,

        style: const TextStyle(
          color: Color(0xFF0B1220),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ==========================================================
  // INFO TAG
  // ==========================================================

  Widget _infoTag(
    IconData icon,
    String text,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),

      decoration: BoxDecoration(
        color:
            Colors.white.withOpacity(0.05),

        borderRadius:
            BorderRadius.circular(9),
      ),

      child: Row(
        mainAxisSize:
            MainAxisSize.min,

        children: [
          Icon(
            icon,
            color:
                const Color(0xFF00C2FF),
            size: 14,
          ),

          const SizedBox(width: 5),

          Text(
            text,

            style: const TextStyle(
              color: Colors.white60,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // STORY SECTION
  // ==========================================================

  Widget _storySection(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(13),

      decoration: BoxDecoration(
        color: const Color(0xFF0B1220),

        borderRadius:
            BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                icon,
                color:
                    const Color(0xFF00C2FF),
                size: 16,
              ),

              const SizedBox(width: 7),

              Text(
                title,
                style: const TextStyle(
                  color:
                      Color(0xFF00C2FF),
                  fontSize: 12,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          Text(
            value,

            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // APPROVE CONFIRMATION
  // ==========================================================

  void _confirmApprove(
    Map<String, dynamic> story,
  ) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFF151F32),

          title: const Text(
            "Approve Story?",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          content: const Text(
            "This success story will become visible on the appropriate Success Stories page.",
            style: TextStyle(
              color: Colors.white70,
              height: 1.5,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                approveStory(story);
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF00C2FF),

                foregroundColor:
                    const Color(0xFF0B1220),
              ),

              child: const Text(
                "Approve",
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // REJECT CONFIRMATION
  // ==========================================================

  void _confirmReject(
    Map<String, dynamic> story,
  ) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFF151F32),

          title: const Text(
            "Reject Story?",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          content: const Text(
            "This success story will not be visible to users.",
            style: TextStyle(
              color: Colors.white70,
              height: 1.5,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                rejectStory(story);
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.redAccent,

                foregroundColor:
                    Colors.white,
              ),

              child: const Text(
                "Reject",
              ),
            ),
          ],
        );
      },
    );
  }
}