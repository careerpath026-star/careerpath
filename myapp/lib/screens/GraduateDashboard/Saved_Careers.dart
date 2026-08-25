import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SavedCareersScreen extends StatefulWidget {
  const SavedCareersScreen({super.key});

  @override
  State<SavedCareersScreen> createState() =>
      _SavedCareersScreenState();
}

class _SavedCareersScreenState extends State<SavedCareersScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  bool isLoading = true;

  List<Map<String, dynamic>> savedCareers = [];

  @override
  void initState() {
    super.initState();
    loadSavedCareers();
  }

  // ==========================================================
  // LOAD SAVED CAREERS
  // ==========================================================

  Future<void> loadSavedCareers() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
          savedCareers = [];
        });

        return;
      }

      final QuerySnapshot snapshot = await _firestore
          .collection("users")
          .doc(user.uid)
          .collection("savedCareers")
          .orderBy(
            "savedAt",
            descending: true,
          )
          .get();

      final List<Map<String, dynamic>> careers = [];

      for (final doc in snapshot.docs) {
        final data =
            doc.data() as Map<String, dynamic>;

        careers.add({
          "id": doc.id,
          ...data,
        });
      }

      if (!mounted) return;

      setState(() {
        savedCareers = careers;
        isLoading = false;
      });
    } catch (e) {
      debugPrint(
        "Load saved careers error: $e",
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Unable to load saved careers.",
          ),
        ),
      );
    }
  }

  // ==========================================================
  // REMOVE SAVED CAREER
  // ==========================================================

  Future<void> removeSavedCareer(
    String careerId,
  ) async {
    final User? user = _auth.currentUser;

    if (user == null) return;

    try {
      await _firestore
          .collection("users")
          .doc(user.uid)
          .collection("savedCareers")
          .doc(careerId)
          .delete();

      if (!mounted) return;

      setState(() {
        savedCareers.removeWhere(
          (career) =>
              career["id"].toString() ==
              careerId,
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Career removed from saved careers.",
          ),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      debugPrint(
        "Remove saved career error: $e",
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Could not remove career.",
          ),
        ),
      );
    }
  }

  // ==========================================================
  // FORMAT CATEGORY
  // ==========================================================

  String formatCategory(String category) {
    switch (category.toLowerCase()) {
      case "computer":
        return "Computer Science";

      case "medical":
        return "Medical & Healthcare";

      case "engineering":
        return "Engineering";

      default:
        return category.isEmpty
            ? "Career"
            : category;
    }
  }

  // ==========================================================
  // CATEGORY ICON
  // ==========================================================

  IconData categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "computer":
        return Icons.computer_outlined;

      case "medical":
        return Icons.medical_services_outlined;

      case "engineering":
        return Icons.engineering_outlined;

      default:
        return Icons.work_outline_rounded;
    }
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
          "Saved Careers",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF00C2FF),
              ),
            )
          : RefreshIndicator(
              color: const Color(0xFF00C2FF),

              onRefresh: loadSavedCareers,

              child: savedCareers.isEmpty
                  ? _emptyState()
                  : ListView(
                      physics:
                          const AlwaysScrollableScrollPhysics(),

                      padding:
                          const EdgeInsets.all(18),

                      children: [
                        _buildHeader(),

                        const SizedBox(
                          height: 20,
                        ),

                        ...savedCareers.map(
                          (career) =>
                              _careerCard(career),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
            ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF3654E0),
            Color(0xFF6278E8),
          ],

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Row(
        children: [
          Container(
            height: 54,
            width: 54,

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),

              borderRadius:
                  BorderRadius.circular(15),
            ),

            child: const Icon(
              Icons.bookmark_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  "My Saved Careers",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "${savedCareers.length} career${savedCareers.length == 1 ? '' : 's'} saved",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CAREER CARD
  // ==========================================================

  Widget _careerCard(
    Map<String, dynamic> career,
  ) {
    final String careerId =
        career["id"]?.toString() ?? "";

    final String careerName =
        career["careerName"]
                ?.toString()
                .trim()
                .isNotEmpty ==
            true
            ? career["careerName"].toString()
            : "Career";

    final String description =
        career["description"]
                ?.toString()
                .trim()
                .isNotEmpty ==
            true
            ? career["description"].toString()
            : "No description available.";

    final String category =
        career["category"]
                ?.toString() ??
            "";

    final String role =
        career["role"]
                ?.toString() ??
            "graduate";

    return Container(
      margin:
          const EdgeInsets.only(bottom: 14),

      decoration: BoxDecoration(
        color: const Color(0xFF151F32),

        borderRadius:
            BorderRadius.circular(18),

        border: Border.all(
          color: const Color(0xFF00C2FF)
              .withOpacity(0.12),
        ),
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(18),

        onTap: () {
          _showCareerDetails(career);
        },

        child: Padding(
          padding: const EdgeInsets.all(17),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  // ==================================================
                  // ICON
                  // ==================================================

                  Container(
                    height: 52,
                    width: 52,

                    decoration: BoxDecoration(
                      color: const Color(0xFF00C2FF)
                          .withOpacity(0.10),

                      borderRadius:
                          BorderRadius.circular(14),
                    ),

                    child: Icon(
                      categoryIcon(category),

                      color:
                          const Color(0xFF00C2FF),

                      size: 27,
                    ),
                  ),

                  const SizedBox(width: 13),

                  // ==================================================
                  // NAME + CATEGORY
                  // ==================================================

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          careerName,

                          style:
                              const TextStyle(
                            color: Colors.white,

                            fontSize: 16,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "${role.toUpperCase()} • ${formatCategory(category)}",

                          style:
                              const TextStyle(
                            color:
                                Color(0xFF00C2FF),

                            fontSize: 10,

                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ==================================================
                  // REMOVE BUTTON
                  // ==================================================

                  IconButton(
                    tooltip:
                        "Remove from saved",

                    onPressed: () {
                      _confirmRemove(
                        careerId,
                        careerName,
                      );
                    },

                    icon: const Icon(
                      Icons.bookmark_rounded,
                      color: Color(0xFF00C2FF),
                      size: 27,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ==================================================
              // DESCRIPTION
              // ==================================================

              Text(
                description,

                maxLines: 3,

                overflow:
                    TextOverflow.ellipsis,

                style:
                    const TextStyle(
                  color: Colors.white60,

                  fontSize: 13,

                  height: 1.5,
                ),
              ),

              const SizedBox(height: 14),

              // ==================================================
              // TAGS
              // ==================================================

              Row(
                children: [
                  _smallTag(
                    Icons.category_outlined,
                    formatCategory(category),
                  ),

                  const SizedBox(width: 8),

                  _smallTag(
                    Icons.person_outline,
                    role,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const Row(
                mainAxisAlignment:
                    MainAxisAlignment.end,

                children: [
                  Text(
                    "View Details",
                    style: TextStyle(
                      color: Color(0xFF00C2FF),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(width: 4),

                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF00C2FF),
                    size: 11,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SMALL TAG
  // ==========================================================

  Widget _smallTag(
    IconData icon,
    String text,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color:
            Colors.white.withOpacity(0.05),

        borderRadius:
            BorderRadius.circular(8),
      ),

      child: Row(
        mainAxisSize:
            MainAxisSize.min,

        children: [
          Icon(
            icon,
            color: Colors.white38,
            size: 13,
          ),

          const SizedBox(width: 5),

          Text(
            text,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CAREER DETAILS
  // ==========================================================

  void _showCareerDetails(
    Map<String, dynamic> career,
  ) {
    final String careerName =
        career["careerName"]
                ?.toString() ??
            "Career";

    final String description =
        career["description"]
                ?.toString() ??
            "No description available.";

    final String category =
        career["category"]
                ?.toString() ??
            "";

    final String role =
        career["role"]
                ?.toString() ??
            "graduate";

    showModalBottomSheet(
      context: context,

      backgroundColor:
          const Color(0xFF151F32),

      isScrollControlled: true,

      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),

      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.all(22),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 45,

                    decoration:
                        BoxDecoration(
                      color: Colors.white24,

                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        careerName,

                        style:
                            const TextStyle(
                          color: Colors.white,

                          fontSize: 22,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    Icon(
                      Icons.bookmark_rounded,

                      color:
                          const Color(0xFF00C2FF),

                      size: 28,
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  "${role.toUpperCase()} • ${formatCategory(category)}",

                  style:
                      const TextStyle(
                    color:
                        Color(0xFF00C2FF),

                    fontSize: 12,

                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  "Career Description",

                  style:
                      TextStyle(
                    color: Colors.white,

                    fontSize: 17,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 9),

                Text(
                  description,

                  style:
                      const TextStyle(
                    color: Colors.white60,

                    fontSize: 14,

                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 25),

                _detailRow(
                  Icons.category_outlined,
                  "Category",
                  formatCategory(category),
                ),

                _detailRow(
                  Icons.person_outline,
                  "Role",
                  role,
                ),

                _detailRow(
                  Icons.bookmark_outline,
                  "Status",
                  "Saved",
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // DETAIL ROW
  // ==========================================================

  Widget _detailRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 10),

      padding:
          const EdgeInsets.all(13),

      decoration: BoxDecoration(
        color: const Color(0xFF0B1220),

        borderRadius:
            BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Icon(
            icon,
            color:
                const Color(0xFF00C2FF),

            size: 20,
          ),

          const SizedBox(width: 12),

          Text(
            "$title: ",

            style:
                const TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),

          Expanded(
            child: Text(
              value,

              style:
                  const TextStyle(
                color: Colors.white,

                fontSize: 13,

                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CONFIRM REMOVE
  // ==========================================================

  void _confirmRemove(
    String careerId,
    String careerName,
  ) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFF151F32),

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18),
          ),

          title: const Text(
            "Remove Saved Career?",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Text(
            "Remove \"$careerName\" from your saved careers?",
            style: const TextStyle(
              color: Colors.white60,
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
              onPressed: () async {
                Navigator.pop(dialogContext);

                await removeSavedCareer(
                  careerId,
                );
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF00C2FF),

                foregroundColor:
                    const Color(0xFF0B1220),
              ),

              child: const Text(
                "Remove",
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _emptyState() {
    return ListView(
      physics:
          const AlwaysScrollableScrollPhysics(),

      padding:
          const EdgeInsets.all(20),

      children: [
        const SizedBox(height: 100),

        Container(
          height: 90,
          width: 90,

          decoration: BoxDecoration(
            color:
                const Color(0xFF00C2FF)
                    .withOpacity(0.08),

            shape: BoxShape.circle,
          ),

          child: const Icon(
            Icons.bookmark_border_rounded,
            color: Color(0xFF00C2FF),
            size: 45,
          ),
        ),

        const SizedBox(height: 22),

        const Text(
          "No Saved Careers",
          textAlign: TextAlign.center,

          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          "Careers you save from the Career Bank will appear here.",
          textAlign: TextAlign.center,

          style: TextStyle(
            color: Colors.white54,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}