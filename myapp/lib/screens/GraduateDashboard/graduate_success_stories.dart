import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GraduateSuccessStories extends StatefulWidget {
  const GraduateSuccessStories({super.key});

  @override
  State<GraduateSuccessStories> createState() =>
      _GraduateSuccessStoriesState();
}

class _GraduateSuccessStoriesState
    extends State<GraduateSuccessStories> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  bool isLoading = true;
  bool isSubmitting = false;

  String userName = "Graduate";
  String userRole = "graduate";
  String profileImage = "";

  List<Map<String, dynamic>> stories = [];
  List<Map<String, dynamic>> careers = [];

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();
    loadPage();
  }

  // ==========================================================
  // LOAD PAGE
  // ==========================================================

  Future<void> loadPage() async {
    setState(() {
      isLoading = true;
    });

    try {
      await loadUserProfile();
      await loadCareers();
      await loadApprovedStories();
    } catch (e) {
      debugPrint("Success Stories Load Error: $e");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Unable to load success stories.",
            ),
          ),
        );
      }
    }

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  // ==========================================================
  // LOAD USER PROFILE
  // ==========================================================

  Future<void> loadUserProfile() async {
    final User? user = _auth.currentUser;

    if (user == null) return;

    final DocumentSnapshot snapshot =
        await _firestore
            .collection("users")
            .doc(user.uid)
            .get();

    if (!snapshot.exists) return;

    final data =
        snapshot.data() as Map<String, dynamic>;

    // -----------------------------
    // USER NAME
    // -----------------------------

    final name =
        data["name"]?.toString().trim();

    final fullName =
        data["fullName"]?.toString().trim();

    if (name != null && name.isNotEmpty) {
      userName = name;
    } else if (fullName != null &&
        fullName.isNotEmpty) {
      userName = fullName;
    } else {
      userName = "Graduate";
    }

    // -----------------------------
    // ROLE
    // -----------------------------

    final role =
        data["role"]?.toString().trim();

    if (role != null && role.isNotEmpty) {
      userRole = role.toLowerCase();
    } else {
      userRole = "graduate";
    }

    // -----------------------------
    // PROFILE IMAGE
    // -----------------------------

    final possibleImages = [
      data["profileImage"],
      data["profileImageUrl"],
      data["image"],
      data["imageUrl"],
      data["photoURL"],
      data["photoUrl"],
      data["avatar"],
    ];

    for (final image in possibleImages) {
      if (image != null &&
          image.toString().trim().isNotEmpty) {
        profileImage =
            image.toString().trim();
        break;
      }
    }
  }

  // ==========================================================
  // LOAD CAREER BANK
  // ==========================================================

  Future<void> loadCareers() async {
    final QuerySnapshot snapshot =
        await _firestore
            .collection("careerBank")
            .get();

    final List<Map<String, dynamic>> loaded = [];

    for (final doc in snapshot.docs) {
      final data =
          doc.data() as Map<String, dynamic>;

      loaded.add({
        "id": doc.id,
        ...data,
      });
    }

    loaded.sort((a, b) {
      final nameA =
          _getCareerName(a).toLowerCase();

      final nameB =
          _getCareerName(b).toLowerCase();

      return nameA.compareTo(nameB);
    });

    careers = loaded;
  }

  // ==========================================================
  // LOAD ONLY APPROVED GRADUATE STORIES
  // ==========================================================

  Future<void> loadApprovedStories() async {
    final QuerySnapshot snapshot =
        await _firestore
            .collection("successStories")
            .where(
              "role",
              isEqualTo: "graduate",
            )
            .where(
              "status",
              isEqualTo: "approved",
            )
            .get();

    final List<Map<String, dynamic>> loaded = [];

    for (final doc in snapshot.docs) {
      final data =
          doc.data() as Map<String, dynamic>;

      loaded.add({
        "id": doc.id,
        ...data,
      });
    }

    // Newest first
    loaded.sort((a, b) {
      final aTime = a["createdAt"];

      final bTime = b["createdAt"];

      if (aTime is Timestamp &&
          bTime is Timestamp) {
        return bTime.compareTo(aTime);
      }

      return 0;
    });

    if (!mounted) return;

    setState(() {
      stories = loaded;
    });
  }

  // ==========================================================
  // GET CAREER NAME
  // ==========================================================

  String _getCareerName(
    Map<String, dynamic> career,
  ) {
    final possibleNames = [
      "careerName",
      "career_name",
      "name",
      "title",
      "career",
    ];

    for (final key in possibleNames) {
      final value = career[key];

      if (value != null &&
          value.toString().trim().isNotEmpty) {
        return value.toString().trim();
      }
    }

    return "Career";
  }

  // ==========================================================
  // GET CAREER CATEGORY
  // ==========================================================

  String _getCareerCategory(
    Map<String, dynamic> career,
  ) {
    final value = career["category"];

    if (value == null) {
      return "Not added";
    }

    final category =
        value.toString().trim();

    if (category.isEmpty) {
      return "Not added";
    }

    switch (category.toLowerCase()) {
      case "computer":
      case "computerscience":
      case "computer science":
        return "Computer Science";

      case "medical":
        return "Medical & Healthcare";

      case "engineering":
        return "Engineering";

      default:
        return category;
    }
  }

  // ==========================================================
  // ADD SUCCESS STORY
  // ==========================================================

  Future<void> submitSuccessStory({
    required String title,
    required Map<String, dynamic> career,
    required String story,
    String achievement = "",
    String company = "",
  }) async {
    final User? user = _auth.currentUser;

    if (user == null) {
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      final careerName =
          _getCareerName(career);

      final category =
          _getCareerCategory(career);

      // IMPORTANT:
      // Story is NOT immediately approved.
      // Admin must change status to "approved".

      await _firestore
          .collection("successStories")
          .add({
        // =====================================================
        // USER INFORMATION
        // =====================================================

        "userId": user.uid,

        "userName": userName,

        "role": userRole,

        "profileImage": profileImage,

        // =====================================================
        // STORY INFORMATION
        // =====================================================

        "title": title.trim(),

        "career": careerName,

        "careerId":
            career["id"]?.toString(),

        "category": category,

        "story": story.trim(),

        "achievement":
            achievement.trim(),

        "company":
            company.trim(),

        // =====================================================
        // APPROVAL STATUS
        // =====================================================

        "status": "pending",

        // =====================================================
        // TIMESTAMP
        // =====================================================

        "createdAt":
            FieldValue.serverTimestamp(),

        "updatedAt":
            FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Success story submitted for admin approval.",
          ),
          duration:
              Duration(seconds: 3),
        ),
      );

      // Reload approved stories.
      await loadApprovedStories();
    } catch (e) {
      debugPrint(
        "Submit Success Story Error: $e",
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Unable to submit success story.",
          ),
        ),
      );
    }

    if (!mounted) return;

    setState(() {
      isSubmitting = false;
    });
  }

  // ==========================================================
  // ADD STORY MODAL
  // ==========================================================

  void _showAddStoryModal() {
    final titleController =
        TextEditingController();

    final storyController =
        TextEditingController();

    final achievementController =
        TextEditingController();

    final companyController =
        TextEditingController();

    Map<String, dynamic>? selectedCareer;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          const Color(0xFF151F32),
      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (modalContext) {
        return StatefulBuilder(
          builder:
              (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom:
                      MediaQuery.of(context)
                              .viewInsets
                              .bottom +
                          20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // ========================================
                      // HEADER
                      // ========================================

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Add Success Story",
                                  style:
                                      TextStyle(
                                    color:
                                        Colors.white,
                                    fontSize:
                                        22,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Your story will be published after admin approval.",
                                  style:
                                      TextStyle(
                                    color:
                                        Colors.white54,
                                    fontSize:
                                        12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(
                                modalContext,
                              );
                            },
                            icon:
                                const Icon(
                              Icons.close,
                              color:
                                  Colors.white70,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // ========================================
                      // PROFILE PREVIEW
                      // ========================================

                      Row(
                        children: [
                          _profileAvatar(
                            size: 52,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize:
                                      15,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Role: ${_prettyRole(userRole)}",
                                style:
                                    const TextStyle(
                                  color:
                                      Color(0xFF00C2FF),
                                  fontSize:
                                      12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // ========================================
                      // TITLE
                      // ========================================

                      _fieldLabel(
                        "Success Story Title *",
                      ),

                      const SizedBox(
                        height: 7,
                      ),

                      _textField(
                        controller:
                            titleController,
                        hint:
                            "e.g. From Graduate to Software Engineer",
                      ),

                      const SizedBox(
                        height: 17,
                      ),

                      // ========================================
                      // CAREER DROPDOWN
                      // ========================================

                      _fieldLabel(
                        "Career *",
                      ),

                      const SizedBox(
                        height: 7,
                      ),

                      DropdownButtonFormField<
                          Map<String, dynamic>>(
                        value:
                            selectedCareer,
                        dropdownColor:
                            const Color(
                                0xFF151F32),
                        style:
                            const TextStyle(
                          color:
                              Colors.white,
                          fontSize:
                              14,
                        ),
                        decoration:
                            _inputDecoration(
                          "Select your career",
                        ),
                        items: careers
                            .map(
                              (
                                career,
                              ) {
                                return DropdownMenuItem<
                                    Map<String,
                                        dynamic>>(
                                  value:
                                      career,
                                  child:
                                      Text(
                                    _getCareerName(
                                        career),
                                  ),
                                );
                              },
                            )
                            .toList(),
                        onChanged:
                            (value) {
                          setModalState(
                            () {
                              selectedCareer =
                                  value;
                            },
                          );
                        },
                      ),

                      const SizedBox(
                        height: 17,
                      ),

                      // ========================================
                      // CATEGORY AUTO
                      // ========================================

                      _fieldLabel(
                        "Category",
                      ),

                      const SizedBox(
                        height: 7,
                      ),

                      Container(
                        width:
                            double.infinity,
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal:
                              14,
                          vertical: 15,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                                  0xFF0B1220),
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      12),
                          border:
                              Border.all(
                            color:
                                Colors.white12,
                          ),
                        ),
                        child: Text(
                          selectedCareer ==
                                  null
                              ? "Select career first"
                              : _getCareerCategory(
                                  selectedCareer!),
                          style:
                              TextStyle(
                            color:
                                selectedCareer ==
                                        null
                                    ? Colors
                                        .white38
                                    : const Color(
                                        0xFF00C2FF),
                            fontSize:
                                14,
                            fontWeight:
                                FontWeight
                                    .w600,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 17,
                      ),

                      // ========================================
                      // SUCCESS STORY
                      // ========================================

                      _fieldLabel(
                        "Success Story *",
                      ),

                      const SizedBox(
                        height: 7,
                      ),

                      _textField(
                        controller:
                            storyController,
                        hint:
                            "Tell us about your journey...",
                        maxLines: 6,
                      ),

                      const SizedBox(
                        height: 17,
                      ),

                      // ========================================
                      // ACHIEVEMENT
                      // ========================================

                      _fieldLabel(
                        "Achievement",
                      ),

                      const SizedBox(
                        height: 7,
                      ),

                      _textField(
                        controller:
                            achievementController,
                        hint:
                            "Mention your achievements...",
                        maxLines: 4,
                      ),

                      const SizedBox(
                        height: 17,
                      ),

                      // ========================================
                      // COMPANY
                      // ========================================

                      _fieldLabel(
                        "Company / Organization",
                      ),

                      const SizedBox(
                        height: 7,
                      ),

                      _textField(
                        controller:
                            companyController,
                        hint:
                            "e.g. Google, Microsoft, ABC Company",
                      ),

                      const SizedBox(
                        height: 22,
                      ),

                      // ========================================
                      // APPROVAL NOTICE
                      // ========================================

                      Container(
                        width:
                            double.infinity,
                        padding:
                            const EdgeInsets
                                .all(13),
                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                                      0xFFFFA000)
                                  .withOpacity(
                                      0.08),
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      12),
                          border:
                              Border.all(
                            color:
                                const Color(
                                        0xFFFFA000)
                                    .withOpacity(
                                        0.25),
                          ),
                        ),
                        child: const Row(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Icon(
                              Icons
                                  .info_outline,
                              color:
                                  Color(
                                      0xFFFFA000),
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "Your story will remain pending until an admin reviews and approves it.",
                                style:
                                    TextStyle(
                                  color:
                                      Colors.white60,
                                  fontSize:
                                      12,
                                  height:
                                      1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // ========================================
                      // SUBMIT
                      // ========================================

                      SizedBox(
                        width:
                            double.infinity,
                        height: 52,
                        child:
                            ElevatedButton(
                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                const Color(
                                    0xFF00C2FF),
                            foregroundColor:
                                const Color(
                                    0xFF0B1220),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          13),
                            ),
                          ),
                          onPressed:
                              isSubmitting
                                  ? null
                                  : () async {
                                      final title =
                                          titleController
                                              .text
                                              .trim();

                                      final story =
                                          storyController
                                              .text
                                              .trim();

                                      if (title
                                              .isEmpty ||
                                          selectedCareer ==
                                              null ||
                                          story
                                              .isEmpty) {
                                        ScaffoldMessenger
                                                .of(
                                                    context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text(
                                              "Please fill all required fields.",
                                            ),
                                          ),
                                        );
                                        return;
                                      }

                                      setState(
                                        () {
                                          isSubmitting =
                                              true;
                                        },
                                      );

                                      await submitSuccessStory(
                                        title:
                                            title,
                                        career:
                                            selectedCareer!,
                                        story:
                                            story,
                                        achievement:
                                            achievementController
                                                .text
                                                .trim(),
                                        company:
                                            companyController
                                                .text
                                                .trim(),
                                      );
                                    },
                          child:
                              isSubmitting
                                  ? const SizedBox(
                                      height:
                                          22,
                                      width:
                                          22,
                                      child:
                                          CircularProgressIndicator(
                                        strokeWidth:
                                            2,
                                        color:
                                            Color(
                                                0xFF0B1220),
                                      ),
                                    )
                                  : const Text(
                                      "Submit for Approval",
                                      style:
                                          TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                        fontSize:
                                            14,
                                      ),
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF0B1220),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF0B1220),
        elevation: 0,
        iconTheme:
            const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Success Stories",
          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed:
            _showAddStoryModal,
        backgroundColor:
            const Color(0xFF00C2FF),
        foregroundColor:
            const Color(0xFF0B1220),
        icon: const Icon(
          Icons.add,
        ),
        label: const Text(
          "Add Story",
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(
                color:
                    Color(0xFF00C2FF),
              ),
            )
          : RefreshIndicator(
              color:
                  const Color(0xFF00C2FF),
              backgroundColor:
                  const Color(0xFF151F32),
              onRefresh:
                  loadPage,
              child: stories.isEmpty
                  ? _emptyStories()
                  : ListView(
                      padding:
                          const EdgeInsets
                              .fromLTRB(
                        18,
                        18,
                        18,
                        100,
                      ),
                      children: [
                        _buildHeader(),

                        const SizedBox(
                          height: 20,
                        ),

                        ...stories.map(
                          (story) =>
                              _storyCard(
                            story,
                          ),
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
      padding:
          const EdgeInsets.all(22),
      decoration:
          BoxDecoration(
        gradient:
            const LinearGradient(
          colors: [
            Color(0xFF3654E0),
            Color(0xFF6278E8),
          ],
          begin:
              Alignment.topLeft,
          end:
              Alignment.bottomRight,
        ),
        borderRadius:
            BorderRadius.circular(
                22),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            height: 54,
            width: 54,
            decoration:
                BoxDecoration(
              color: Colors.white
                  .withOpacity(0.15),
              borderRadius:
                  BorderRadius.circular(
                      15),
            ),
            child: const Icon(
              Icons.emoji_events_outlined,
              color: Colors.white,
              size: 29,
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          const Text(
            "Graduate Success Stories",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 7,
          ),

          const Text(
            "Read inspiring career journeys and achievements shared by graduates.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration:
                BoxDecoration(
              color: Colors.white
                  .withOpacity(0.14),
              borderRadius:
                  BorderRadius.circular(
                      20),
            ),
            child: Text(
              "${stories.length} Approved Stories",
              style:
                  const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // STORY CARD
  // ==========================================================

  Widget _storyCard(
    Map<String, dynamic> story,
  ) {
    final title =
        _safeString(
      story["title"],
      "Success Story",
    );

    final name =
        _safeString(
      story["userName"],
      "Graduate",
    );

    final career =
        _safeString(
      story["career"],
      "Career",
    );

    final category =
        _safeString(
      story["category"],
      "Not added",
    );

    final storyText =
        _safeString(
      story["story"],
      "No story available.",
    );

    final achievement =
        _safeString(
      story["achievement"],
      "",
    );

    final company =
        _safeString(
      story["company"],
      "",
    );

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 15,
      ),
      padding:
          const EdgeInsets.all(17),
      decoration:
          BoxDecoration(
        color:
            const Color(0xFF151F32),
        borderRadius:
            BorderRadius.circular(
                18),
        border:
            Border.all(
          color: Colors.white10,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // ==============================================
          // USER
          // ==============================================

          Row(
            children: [
              _storyProfileAvatar(
                story,
              ),

              const SizedBox(
                width: 12,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize:
                            14,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 3,
                    ),

                    const Text(
                      "Graduate",
                      style:
                          TextStyle(
                        color:
                            Color(
                                0xFF00C2FF),
                        fontSize:
                            11,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.verified,
                color:
                    Color(0xFF00C2FF),
                size: 20,
              ),
            ],
          ),

          const SizedBox(
            height: 17,
          ),

          // ==============================================
          // TITLE
          // ==============================================

          Text(
            title,
            style:
                const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // ==============================================
          // CAREER + CATEGORY
          // ==============================================

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _storyTag(
                Icons.work_outline,
                career,
              ),
              _storyTag(
                Icons.category_outlined,
                category,
              ),
            ],
          ),

          const SizedBox(
            height: 15,
          ),

          // ==============================================
          // STORY
          // ==============================================

          Text(
            storyText,
            maxLines: 5,
            overflow:
                TextOverflow.ellipsis,
            style:
                const TextStyle(
              color:
                  Colors.white60,
              fontSize: 13,
              height: 1.55,
            ),
          ),

          // ==============================================
          // ACHIEVEMENT
          // ==============================================

          if (achievement
              .isNotEmpty) ...[
            const SizedBox(
              height: 15,
            ),
            _storySection(
              "Achievement",
              achievement,
              Icons.emoji_events_outlined,
            ),
          ],

          // ==============================================
          // COMPANY
          // ==============================================

          if (company.isNotEmpty) ...[
            const SizedBox(
              height: 12,
            ),
            _storySection(
              "Company / Organization",
              company,
              Icons.business_outlined,
            ),
          ],
        ],
      ),
    );
  }

  // ==========================================================
  // STORY SECTION
  // ==========================================================

  Widget _storySection(
    String title,
    String text,
    IconData icon,
  ) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(12),
      decoration:
          BoxDecoration(
        color:
            const Color(0xFF0B1220),
        borderRadius:
            BorderRadius.circular(
                12),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color:
                const Color(0xFF00C2FF),
            size: 19,
          ),
          const SizedBox(
            width: 9,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(
                    color:
                        Color(0xFF00C2FF),
                    fontSize:
                        11,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  text,
                  style:
                      const TextStyle(
                    color:
                        Colors.white70,
                    fontSize:
                        12,
                    height: 1.4,
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
  // STORY TAG
  // ==========================================================

  Widget _storyTag(
    IconData icon,
    String text,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration:
          BoxDecoration(
        color:
            Colors.white.withOpacity(
                0.05),
        borderRadius:
            BorderRadius.circular(
                8),
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            icon,
            color:
                Colors.white38,
            size: 13,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style:
                const TextStyle(
              color:
                  Colors.white54,
              fontSize:
                  10,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PROFILE AVATAR
  // ==========================================================

  Widget _profileAvatar({
    double size = 50,
  }) {
    if (profileImage.isNotEmpty) {
      return CircleAvatar(
        radius: size / 2,
        backgroundColor:
            const Color(0xFF00C2FF),
        backgroundImage:
            NetworkImage(
          profileImage,
        ),
      );
    }

    return CircleAvatar(
      radius: size / 2,
      backgroundColor:
          const Color(0xFF00C2FF),
      child: Text(
        _initials(userName),
        style: const TextStyle(
          color:
              Color(0xFF0B1220),
          fontWeight:
              FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }

  // ==========================================================
  // STORY PROFILE AVATAR
  // ==========================================================

  Widget _storyProfileAvatar(
    Map<String, dynamic> story,
  ) {
    final image =
        _safeString(
      story["profileImage"],
      "",
    );

    final name =
        _safeString(
      story["userName"],
      "Graduate",
    );

    if (image.isNotEmpty) {
      return CircleAvatar(
        radius: 24,
        backgroundColor:
            const Color(0xFF00C2FF),
        backgroundImage:
            NetworkImage(image),
      );
    }

    return CircleAvatar(
      radius: 24,
      backgroundColor:
          const Color(0xFF00C2FF),
      child: Text(
        _initials(name),
        style:
            const TextStyle(
          color:
              Color(0xFF0B1220),
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }

  // ==========================================================
  // EMPTY STORIES
  // ==========================================================

  Widget _emptyStories() {
    return ListView(
      physics:
          const AlwaysScrollableScrollPhysics(),
      padding:
          const EdgeInsets.all(20),
      children: [
        const SizedBox(
          height: 70,
        ),

        const Icon(
          Icons.emoji_events_outlined,
          color: Colors.white24,
          size: 70,
        ),

        const SizedBox(
          height: 20,
        ),

        const Text(
          "No Approved Stories Yet",
          textAlign:
              TextAlign.center,
          style:
              TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        const Text(
          "Be the first graduate to share a success story. Your story will appear here after admin approval.",
          textAlign:
              TextAlign.center,
          style:
              TextStyle(
            color: Colors.white54,
            fontSize: 13,
            height: 1.5,
          ),
        ),

        const SizedBox(
          height: 22,
        ),

        Center(
          child:
              OutlinedButton.icon(
            onPressed:
                _showAddStoryModal,
            icon: const Icon(
              Icons.add,
              color:
                  Color(0xFF00C2FF),
            ),
            label: const Text(
              "Add Your Story",
              style:
                  TextStyle(
                color:
                    Color(0xFF00C2FF),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // FIELD LABEL
  // ==========================================================

  Widget _fieldLabel(
    String text,
  ) {
    return Text(
      text,
      style:
          const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight:
            FontWeight.w600,
      ),
    );
  }

  // ==========================================================
  // TEXT FIELD
  // ==========================================================

  Widget _textField({
    required TextEditingController
        controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style:
          const TextStyle(
        color: Colors.white,
        fontSize: 13,
      ),
      decoration:
          _inputDecoration(hint),
    );
  }

  // ==========================================================
  // INPUT DECORATION
  // ==========================================================

  InputDecoration _inputDecoration(
    String hint,
  ) {
    return InputDecoration(
      hintText: hint,
      hintStyle:
          const TextStyle(
        color: Colors.white30,
        fontSize: 13,
      ),
      filled: true,
      fillColor:
          const Color(0xFF0B1220),
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      border:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
                12),
        borderSide:
            const BorderSide(
          color: Colors.white12,
        ),
      ),
      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
                12),
        borderSide:
            const BorderSide(
          color: Colors.white12,
        ),
      ),
      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
                12),
        borderSide:
            const BorderSide(
          color:
              Color(0xFF00C2FF),
        ),
      ),
    );
  }

  // ==========================================================
  // SAFE STRING
  // ==========================================================

  String _safeString(
    dynamic value,
    String fallback,
  ) {
    if (value == null) {
      return fallback;
    }

    final text =
        value.toString().trim();

    return text.isEmpty
        ? fallback
        : text;
  }

  // ==========================================================
  // INITIALS
  // ==========================================================

  String _initials(
    String name,
  ) {
    final parts = name
        .trim()
        .split(RegExp(r"\s+"));

    if (parts.isEmpty) {
      return "G";
    }

    if (parts.length == 1) {
      return parts[0]
          .substring(
            0,
            parts[0].length >= 1
                ? 1
                : 0,
          )
          .toUpperCase();
    }

    return "${parts[0][0]}${parts[1][0]}"
        .toUpperCase();
  }

  // ==========================================================
  // PRETTY ROLE
  // ==========================================================

  String _prettyRole(
    String role,
  ) {
    if (role.isEmpty) {
      return "Graduate";
    }

    return role[0].toUpperCase() +
        role.substring(1);
  }
}