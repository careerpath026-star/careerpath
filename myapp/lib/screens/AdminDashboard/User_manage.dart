import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  String _selectedRole = 'All';

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // =====================================================
  // USERS STREAM
  // =====================================================

  Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream() {
    return _firestore
        .collection('users')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // =====================================================
  // FILTER USERS
  // =====================================================

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _filterUsers(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> users,
  ) {
    return users.where((doc) {
      final data = doc.data();

      final name = (data['name'] ?? '').toString().toLowerCase();
      final email = (data['email'] ?? '').toString().toLowerCase();
      final uid = (data['uid'] ?? '').toString().toLowerCase();
      final education = (data['education'] ?? '').toString().toLowerCase();
      final interestField =
          (data['interest_field'] ?? '').toString().toLowerCase();
      final userType = (data['userType'] ?? '').toString();

      final skills = _listToString(data['skills']).toLowerCase();
      final interests = _listToString(data['interests']).toLowerCase();

      final matchesSearch =
          _searchQuery.isEmpty ||
          name.contains(_searchQuery) ||
          email.contains(_searchQuery) ||
          uid.contains(_searchQuery) ||
          education.contains(_searchQuery) ||
          interestField.contains(_searchQuery) ||
          skills.contains(_searchQuery) ||
          interests.contains(_searchQuery);

      final matchesRole =
          _selectedRole == 'All' ||
          userType.toLowerCase() == _selectedRole.toLowerCase();

      return matchesSearch && matchesRole;
    }).toList();
  }

  // =====================================================
  // LIST TO STRING
  // =====================================================

  String _listToString(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).join(', ');
    }

    return value?.toString() ?? '';
  }

  // =====================================================
  // DELETE USER
  // =====================================================

  Future<void> _deleteUser(
    QueryDocumentSnapshot<Map<String, dynamic>> user,
  ) async {
    final data = user.data();

    final name = (data['name'] ?? 'this user').toString();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: Text(
            'Are you sure you want to delete "$name"?\n\n'
            'This will delete the user profile from Firestore.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      await _firestore.collection('users').doc(user.id).delete();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete user: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // =====================================================
  // EDIT USER
  // =====================================================

  Future<void> _showEditUserDialog(
    QueryDocumentSnapshot<Map<String, dynamic>> user,
  ) async {
    final data = user.data();

    final nameController = TextEditingController(
      text: (data['name'] ?? '').toString(),
    );

    final emailController = TextEditingController(
      text: (data['email'] ?? '').toString(),
    );

    final educationController = TextEditingController(
      text: (data['education'] ?? '').toString(),
    );

    final interestFieldController = TextEditingController(
      text: (data['interest_field'] ?? '').toString(),
    );

    final workExperienceController = TextEditingController(
      text: (data['workExperience'] ?? '').toString(),
    );

    final skillsController = TextEditingController(
      text: _listToString(data['skills']),
    );

    final interestsController = TextEditingController(
      text: _listToString(data['interests']),
    );

    String selectedUserType =
        (data['userType'] ?? 'Student').toString();

    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) {
        bool saving = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Row(
                children: [
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text('Edit User'),
                ],
              ),

              content: SizedBox(
                width: 520,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // NAME
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Name is required';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 14),

                        // EMAIL
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Email is required';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 14),

                        // ROLE
                        DropdownButtonFormField<String>(
                          value: selectedUserType,
                          decoration: const InputDecoration(
                            labelText: 'User Type',
                            prefixIcon: Icon(Icons.badge_outlined),
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Student',
                              child: Text('Student'),
                            ),
                            DropdownMenuItem(
                              value: 'Graduate',
                              child: Text('Graduate'),
                            ),
                            DropdownMenuItem(
                              value: 'Professional',
                              child: Text('Professional'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() {
                                selectedUserType = value;
                              });
                            }
                          },
                        ),

                        const SizedBox(height: 14),

                        // EDUCATION
                        TextFormField(
                          controller: educationController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Education',
                            prefixIcon: Icon(Icons.school_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // INTEREST FIELD
                        TextFormField(
                          controller: interestFieldController,
                          decoration: const InputDecoration(
                            labelText: 'Interest Field',
                            prefixIcon:
                                Icon(Icons.interests_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // SKILLS
                        TextFormField(
                          controller: skillsController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Skills',
                            hintText:
                                'Separate skills with commas',
                            prefixIcon: Icon(Icons.build_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // INTERESTS
                        TextFormField(
                          controller: interestsController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Interests',
                            hintText:
                                'Separate interests with commas',
                            prefixIcon:
                                Icon(Icons.favorite_border),
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // WORK EXPERIENCE
                        TextFormField(
                          controller: workExperienceController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Work Experience',
                            prefixIcon:
                                Icon(Icons.work_outline),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              actions: [
                TextButton(
                  onPressed: saving
                      ? null
                      : () {
                          Navigator.pop(context);
                        },
                  child: const Text('Cancel'),
                ),

                ElevatedButton.icon(
                  onPressed: saving
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          setDialogState(() {
                            saving = true;
                          });

                          try {
                            final skills = skillsController.text
                                .split(',')
                                .map((e) => e.trim())
                                .where((e) => e.isNotEmpty)
                                .toList();

                            final interests = interestsController
                                .text
                                .split(',')
                                .map((e) => e.trim())
                                .where((e) => e.isNotEmpty)
                                .toList();

                            await _firestore
                                .collection('users')
                                .doc(user.id)
                                .update({
                              'name': nameController.text.trim(),
                              'email': emailController.text.trim(),
                              'userType': selectedUserType,
                              'education':
                                  educationController.text.trim(),
                              'interest_field':
                                  interestFieldController.text.trim(),
                              'skills': skills,
                              'interests': interests,
                              'workExperience':
                                  workExperienceController.text.trim(),
                              'updatedAt':
                                  FieldValue.serverTimestamp(),
                            });

                            if (!context.mounted) return;

                            Navigator.pop(context);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content:
                                    Text('User updated successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } catch (e) {
                            setDialogState(() {
                              saving = false;
                            });

                            if (!context.mounted) return;

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content:
                                    Text('Failed to update user: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                  icon: saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(
                    saving ? 'Saving...' : 'Save Changes',
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    nameController.dispose();
    emailController.dispose();
    educationController.dispose();
    interestFieldController.dispose();
    workExperienceController.dispose();
    skillsController.dispose();
    interestsController.dispose();
  }

  // =====================================================
  // PROFILE AVATAR
  // =====================================================

  Widget _profileAvatar(Map<String, dynamic> data) {
    final image = (data['profileImage'] ?? '').toString().trim();

    if (image.isNotEmpty) {
      return CircleAvatar(
        radius: 21,
        backgroundImage: NetworkImage(image),
        backgroundColor: Colors.grey.shade200,
      );
    }

    final name = (data['name'] ?? 'U').toString();

    return CircleAvatar(
      radius: 21,
      backgroundColor: Colors.blue.shade50,
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : 'U',
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // =====================================================
  // ROLE CHIP
  // =====================================================

  Widget _roleChip(String role) {
    Color color;

    switch (role.toLowerCase()) {
      case 'graduate':
        color = Colors.green;
        break;

      case 'professional':
        color = Colors.orange;
        break;

      default:
        color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        role.isEmpty ? 'Unknown' : role,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // =====================================================
  // DATE FORMAT
  // =====================================================

  String _formatDate(dynamic value) {
    if (value is Timestamp) {
      final date = value.toDate();

      return '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';
    }

    return '-';
  }

  // =====================================================
  // MOBILE USER CARD
  // =====================================================

  Widget _mobileUserCard(
    QueryDocumentSnapshot<Map<String, dynamic>> user,
  ) {
    final data = user.data();

    final name = (data['name'] ?? 'No Name').toString();
    final email = (data['email'] ?? 'No Email').toString();
    final role = (data['userType'] ?? 'Unknown').toString();
    final education = (data['education'] ?? '').toString();
    final interestField =
        (data['interest_field'] ?? '').toString();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _profileAvatar(data),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              _roleChip(role),
            ],
          ),

          const SizedBox(height: 15),

          _mobileInfoRow(
            Icons.school_outlined,
            'Education',
            education.isEmpty ? '-' : education,
          ),

          _mobileInfoRow(
            Icons.interests_outlined,
            'Interest',
            interestField.isEmpty ? '-' : interestField,
          ),

          _mobileInfoRow(
            Icons.calendar_today_outlined,
            'Joined',
            _formatDate(data['createdAt']),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showEditUserDialog(user);
                  },
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 18,
                  ),
                  label: const Text('Edit'),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _deleteUser(user);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 18,
                  ),
                  label: const Text('Delete'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mobileInfoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 17,
            color: Colors.grey.shade600,
          ),

          const SizedBox(width: 8),

          SizedBox(
            width: 75,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // DESKTOP TABLE
  // =====================================================

  Widget _desktopTable(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> users,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor:
                WidgetStateProperty.all(
              const Color(0xFFF7F9FC),
            ),
            columnSpacing: 28,
            horizontalMargin: 20,
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF172033),
            ),
            columns: const [
              DataColumn(
                label: Text('User'),
              ),
              DataColumn(
                label: Text('Role'),
              ),
              DataColumn(
                label: Text('Education'),
              ),
              DataColumn(
                label: Text('Interest'),
              ),
              DataColumn(
                label: Text('Skills'),
              ),
              DataColumn(
                label: Text('Joined'),
              ),
              DataColumn(
                label: Text('Actions'),
              ),
            ],
            rows: users.map((user) {
              final data = user.data();

              final name =
                  (data['name'] ?? 'No Name').toString();

              final email =
                  (data['email'] ?? 'No Email').toString();

              final role =
                  (data['userType'] ?? 'Unknown').toString();

              final education =
                  (data['education'] ?? '').toString();

              final interestField =
                  (data['interest_field'] ?? '').toString();

              final skills =
                  _listToString(data['skills']);

              return DataRow(
                cells: [
                  // USER
                  DataCell(
                    SizedBox(
                      width: 230,
                      child: Row(
                        children: [
                          _profileAvatar(data),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  maxLines: 1,
                                  overflow:
                                      TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 3),

                                Text(
                                  email,
                                  maxLines: 1,
                                  overflow:
                                      TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color:
                                        Colors.grey.shade600,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ROLE
                  DataCell(
                    _roleChip(role),
                  ),

                  // EDUCATION
                  DataCell(
                    SizedBox(
                      width: 150,
                      child: Text(
                        education.isEmpty
                            ? '-'
                            : education,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  // INTEREST
                  DataCell(
                    SizedBox(
                      width: 120,
                      child: Text(
                        interestField.isEmpty
                            ? '-'
                            : interestField,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  // SKILLS
                  DataCell(
                    SizedBox(
                      width: 180,
                      child: Text(
                        skills.isEmpty ? '-' : skills,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  // CREATED AT
                  DataCell(
                    Text(
                      _formatDate(data['createdAt']),
                    ),
                  ),

                  // ACTIONS
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Edit User',
                          onPressed: () {
                            _showEditUserDialog(user);
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            size: 20,
                          ),
                        ),

                        IconButton(
                          tooltip: 'Delete User',
                          onPressed: () {
                            _deleteUser(user);
                          },
                          color: Colors.red,
                          icon: const Icon(
                            Icons.delete_outline,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // FILTER BAR
  // =====================================================

  Widget _filterBar(int totalUsers) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 650;

          if (isSmall) {
            return Column(
              children: [
                _searchBox(),

                const SizedBox(height: 12),

                _roleFilter(),

                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$totalUsers users found',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: _searchBox(),
              ),

              const SizedBox(width: 14),

              SizedBox(
                width: 180,
                child: _roleFilter(),
              ),

              const SizedBox(width: 14),

              Text(
                '$totalUsers users',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _searchBox() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText:
            'Search name, email, education, interest...',
        prefixIcon: const Icon(
          Icons.search,
        ),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _searchController.clear();
                },
                icon: const Icon(Icons.clear),
              )
            : null,
        filled: true,
        fillColor: const Color(0xFFF7F9FC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _roleFilter() {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      decoration: InputDecoration(
        labelText: 'Filter by Role',
        prefixIcon: const Icon(
          Icons.filter_list_outlined,
        ),
        filled: true,
        fillColor: const Color(0xFFF7F9FC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: 'All',
          child: Text('All Users'),
        ),
        DropdownMenuItem(
          value: 'Student',
          child: Text('Students'),
        ),
        DropdownMenuItem(
          value: 'Graduate',
          child: Text('Graduates'),
        ),
        DropdownMenuItem(
          value: 'Professional',
          child: Text('Professionals'),
        ),
      ],
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          _selectedRole = value;
        });
      },
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF172033),
        ),
        title: const Text(
          'User Management',
          style: TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: StreamBuilder<
            QuerySnapshot<Map<String, dynamic>>>(
          stream: _usersStream(),

          builder: (context, snapshot) {
            // =================================================
            // LOADING
            // =================================================

            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // =================================================
            // ERROR
            // =================================================

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 55,
                        color: Colors.red,
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        'Unable to load users',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        snapshot.error.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final allUsers = snapshot.data?.docs ?? [];

            final filteredUsers = _filterUsers(allUsers);

            return LayoutBuilder(
              builder: (context, constraints) {
                final isMobile =
                    constraints.maxWidth < 850;

                return SingleChildScrollView(
                  padding: EdgeInsets.all(
                    isMobile ? 14 : 24,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // =================================================
                      // HEADER
                      // =================================================

                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'User Management',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Color(0xFF172033),
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  'Manage registered users and their profile information.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color:
                                        Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          if (!isMobile)
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.people_outline,
                                    size: 19,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    '${allUsers.length} Total',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight:
                                          FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // =================================================
                      // FILTER
                      // =================================================

                      _filterBar(filteredUsers.length),

                      const SizedBox(height: 18),

                      // =================================================
                      // EMPTY
                      // =================================================

                      if (filteredUsers.isEmpty)
                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 70,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.person_search_outlined,
                                size: 60,
                                color: Colors.grey.shade400,
                              ),

                              const SizedBox(height: 15),

                              const Text(
                                'No users found',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                'Try changing your search or filter.',
                                style: TextStyle(
                                  color:
                                      Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        )

                      // =================================================
                      // MOBILE
                      // =================================================

                      else if (isMobile)
                        Column(
                          children: filteredUsers
                              .map(
                                (user) =>
                                    _mobileUserCard(user),
                              )
                              .toList(),
                        )

                      // =================================================
                      // DESKTOP / TABLET
                      // =================================================

                      else
                        _desktopTable(filteredUsers),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}