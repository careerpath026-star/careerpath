import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GraduateProfile extends StatefulWidget {
  const GraduateProfile({super.key});

  @override
  State<GraduateProfile> createState() => _GraduateProfileState();
}

class _GraduateProfileState extends State<GraduateProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? userData;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  // ==========================================================
  // FETCH PROFILE
  // ==========================================================

  Future<void> fetchProfile() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final DocumentSnapshot snapshot = await _firestore
          .collection("users")
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          userData = snapshot.data() as Map<String, dynamic>;
          isLoading = false;
        });
      } else {
        setState(() {
          userData = {
            "name": user.displayName ?? "",
            "email": user.email ?? "",
            "phone": user.phoneNumber ?? "",
            "qualification": "",
            "institute": "",
            "graduationYear": "",
            "skills": "",
            "interests": "",
          };

          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Profile fetch error: $e");

      setState(() {
        isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to load profile: $e"),
          ),
        );
      }
    }
  }

  // ==========================================================
  // GET VALUE
  // ==========================================================

  String getValue(String key, String defaultValue) {
    final value = userData?[key];

    if (value == null || value.toString().trim().isEmpty) {
      return defaultValue;
    }

    return value.toString();
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
          "My Profile",
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
          : SingleChildScrollView(
              padding: const EdgeInsets.all(18),

              child: Column(
                children: [

                  // ==================================================
                  // PROFILE HEADER
                  // ==================================================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),

                    decoration: BoxDecoration(
                      color: const Color(0xFF151F32),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      children: [

                        Container(
                          width: 90,
                          height: 90,

                          decoration: BoxDecoration(
                            color: const Color(0xFF00C2FF),
                            borderRadius: BorderRadius.circular(45),
                          ),

                          child: const Icon(
                            Icons.person,
                            size: 48,
                            color: Color(0xFF0B1220),
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          getValue(
                            "name",
                            "Graduate User",
                          ),

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          getValue(
                            "email",
                            _auth.currentUser?.email ??
                                "No email",
                          ),

                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xFF00C2FF)
                                .withOpacity(0.12),

                            borderRadius:
                                BorderRadius.circular(20),
                          ),

                          child: const Text(
                            "Graduate",
                            style: TextStyle(
                              color: Color(0xFF00C2FF),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // ==================================================
                  // PERSONAL INFORMATION
                  // ==================================================

                  _sectionTitle("Personal Information"),

                  const SizedBox(height: 10),

                  _profileItem(
                    icon: Icons.person_outline,
                    title: "Full Name",
                    value: getValue(
                      "name",
                      "Not added",
                    ),
                  ),

                  _profileItem(
                    icon: Icons.email_outlined,
                    title: "Email",
                    value: getValue(
                      "email",
                      _auth.currentUser?.email ??
                          "Not added",
                    ),
                  ),

                  _profileItem(
                    icon: Icons.phone_outlined,
                    title: "Phone",
                    value: getValue(
                      "phone",
                      "Not added",
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // EDUCATION
                  // ==================================================

                  _sectionTitle("Education"),

                  const SizedBox(height: 10),

                  _profileItem(
                    icon: Icons.school_outlined,
                    title: "Qualification",
                    value: getValue(
                      "qualification",
                      "Not added",
                    ),
                  ),

                  _profileItem(
                    icon: Icons.account_balance_outlined,
                    title: "Institute",
                    value: getValue(
                      "institute",
                      "Not added",
                    ),
                  ),

                  _profileItem(
                    icon: Icons.calendar_today_outlined,
                    title: "Graduation Year",
                    value: getValue(
                      "graduationYear",
                      "Not added",
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // SKILLS & INTERESTS
                  // ==================================================

                  _sectionTitle("Skills & Interests"),

                  const SizedBox(height: 10),

                  _profileItem(
                    icon: Icons.lightbulb_outline,
                    title: "Skills",
                    value: getValue(
                      "skills",
                      "Not added",
                    ),
                  ),

                  _profileItem(
                    icon: Icons.favorite_border,
                    title: "Interests",
                    value: getValue(
                      "interests",
                      "Not added",
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ==================================================
                  // EDIT PROFILE BUTTON
                  // ==================================================

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton.icon(
                      onPressed: () {
                        _openEditProfile();
                      },

                      icon: const Icon(
                        Icons.edit_outlined,
                      ),

                      label: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF00C2FF),

                        foregroundColor:
                            const Color(0xFF0B1220),

                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 15,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }

  // ==========================================================
  // SECTION TITLE
  // ==========================================================

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Text(
        title,

        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ==========================================================
  // PROFILE ITEM
  // ==========================================================

  Widget _profileItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: const Color(0xFF151F32),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [

          Container(
            width: 42,
            height: 42,

            decoration: BoxDecoration(
              color: const Color(0xFF00C2FF)
                  .withOpacity(0.10),

              borderRadius:
                  BorderRadius.circular(10),
            ),

            child: Icon(
              icon,
              color: const Color(0xFF00C2FF),
              size: 21,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right,
            color: Colors.white38,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // OPEN EDIT PROFILE
  // ==========================================================

  void _openEditProfile() {
    final nameController = TextEditingController(
      text: getValue("name", ""),
    );

    final phoneController = TextEditingController(
      text: getValue("phone", ""),
    );

    final qualificationController = TextEditingController(
      text: getValue("qualification", ""),
    );

    final instituteController = TextEditingController(
      text: getValue("institute", ""),
    );

    final graduationYearController = TextEditingController(
      text: getValue("graduationYear", ""),
    );

    final skillsController = TextEditingController(
      text: getValue("skills", ""),
    );

    final interestsController = TextEditingController(
      text: getValue("interests", ""),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0B1220),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),

      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom +
                20,
          ),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // ==================================================
                // HEADER
                // ==================================================

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "Edit Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.close,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ==================================================
                // NAME
                // ==================================================

                _editField(
                  controller: nameController,
                  label: "Full Name",
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 14),

                // ==================================================
                // EMAIL
                // ==================================================

                _editField(
                  controller: TextEditingController(
                    text: getValue(
                      "email",
                      _auth.currentUser?.email ?? "",
                    ),
                  ),
                  label: "Email",
                  icon: Icons.email_outlined,
                  enabled: false,
                ),

                const SizedBox(height: 14),

                // ==================================================
                // PHONE
                // ==================================================

                _editField(
                  controller: phoneController,
                  label: "Phone",
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 14),

                // ==================================================
                // QUALIFICATION
                // ==================================================

                _editField(
                  controller: qualificationController,
                  label: "Qualification",
                  icon: Icons.school_outlined,
                ),

                const SizedBox(height: 14),

                // ==================================================
                // INSTITUTE
                // ==================================================

                _editField(
                  controller: instituteController,
                  label: "Institute",
                  icon: Icons.account_balance_outlined,
                ),

                const SizedBox(height: 14),

                // ==================================================
                // GRADUATION YEAR
                // ==================================================

                _editField(
                  controller: graduationYearController,
                  label: "Graduation Year",
                  icon: Icons.calendar_today_outlined,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 14),

                // ==================================================
                // SKILLS
                // ==================================================

                _editField(
                  controller: skillsController,
                  label: "Skills",
                  icon: Icons.lightbulb_outline,
                  hint: "e.g. Flutter, Python, Communication",
                  maxLines: 2,
                ),

                const SizedBox(height: 14),

                // ==================================================
                // INTERESTS
                // ==================================================

                _editField(
                  controller: interestsController,
                  label: "Interests",
                  icon: Icons.favorite_border,
                  hint: "e.g. AI, Web Development, Business",
                  maxLines: 2,
                ),

                const SizedBox(height: 25),

                // ==================================================
                // SAVE BUTTON
                // ==================================================

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await _saveProfile(
                        name: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        qualification:
                            qualificationController.text.trim(),
                        institute:
                            instituteController.text.trim(),
                        graduationYear:
                            graduationYearController.text.trim(),
                        skills:
                            skillsController.text.trim(),
                        interests:
                            interestsController.text.trim(),
                      );

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },

                    icon: const Icon(
                      Icons.save_outlined,
                    ),

                    label: const Text(
                      "Save Changes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF00C2FF),

                      foregroundColor:
                          const Color(0xFF0B1220),

                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 15,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // EDIT FIELD
  // ==========================================================

  Widget _editField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    bool enabled = true,
    TextInputType keyboardType =
        TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,

        labelStyle: const TextStyle(
          color: Colors.white60,
        ),

        hintStyle: const TextStyle(
          color: Colors.white30,
        ),

        prefixIcon: Icon(
          icon,
          color: const Color(0xFF00C2FF),
        ),

        filled: true,

        fillColor: const Color(0xFF151F32),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),

          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),

          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),

          borderSide: const BorderSide(
            color: Color(0xFF00C2FF),
          ),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ==========================================================
  // SAVE PROFILE TO FIRESTORE
  // ==========================================================

  Future<void> _saveProfile({
    required String name,
    required String phone,
    required String qualification,
    required String institute,
    required String graduationYear,
    required String skills,
    required String interests,
  }) async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        return;
      }

      // --------------------------------------------------------
      // SAVE TO FIRESTORE
      // --------------------------------------------------------

      await _firestore
          .collection("users")
          .doc(user.uid)
          .set(
        {
          "name": name,
          "email": user.email ?? "",
          "phone": phone,
          "qualification": qualification,
          "institute": institute,
          "graduationYear": graduationYear,
          "skills": skills,
          "interests": interests,
          "role": "graduate",
          "updatedAt": FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      // --------------------------------------------------------
      // UPDATE LOCAL DATA
      // --------------------------------------------------------

      setState(() {
        userData = {
          ...?userData,
          "name": name,
          "email": user.email ?? "",
          "phone": phone,
          "qualification": qualification,
          "institute": institute,
          "graduationYear": graduationYear,
          "skills": skills,
          "interests": interests,
          "role": "graduate",
        };
      });

      // --------------------------------------------------------
      // UPDATE FIREBASE AUTH DISPLAY NAME
      // --------------------------------------------------------

      if (name.isNotEmpty &&
          name != user.displayName) {
        await user.updateDisplayName(name);
        await user.reload();
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Profile updated successfully!",
            ),
          ),
        );
      }

    } catch (e) {
      debugPrint("Profile update error: $e");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Failed to update profile: $e",
            ),
          ),
        );
      }
    }
  }
}
