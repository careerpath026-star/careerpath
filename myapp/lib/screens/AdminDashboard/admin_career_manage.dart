import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminCareerPage extends StatefulWidget {
  const AdminCareerPage({super.key});

  @override
  State<AdminCareerPage> createState() => _AdminCareerPageState();
}

class _AdminCareerPageState extends State<AdminCareerPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showMessage(String message, Color color) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  Future<void> _deleteCareer(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Career'),
          content: const Text(
            'Are you sure you want to delete this career?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      await _firestore.collection('careerBank').doc(id).delete();

      _showMessage(
        'Career deleted successfully',
        Colors.green,
      );
    } catch (e) {
      _showMessage(
        'Failed to delete career',
        Colors.red,
      );
    }
  }

  Future<void> _showCareerForm({
    DocumentSnapshot<Map<String, dynamic>>? document,
  }) async {
    final data = document?.data();

    final careerNameController = TextEditingController(
      text: data?['careerName'] ?? '',
    );

    final categoryController = TextEditingController(
      text: data?['category'] ?? '',
    );

    final categoryNameController = TextEditingController(
      text: data?['categoryName'] ?? '',
    );

    final descriptionController = TextEditingController(
      text: data?['description'] ?? '',
    );

    final educationController = TextEditingController(
      text: data?['education'] ?? '',
    );

    final salaryController = TextEditingController(
      text: data?['salaryRange'] ?? '',
    );

    final scopeController = TextEditingController(
      text: data?['scope'] ?? '',
    );

    final skillsController = TextEditingController(
      text: data?['skills'] is List
          ? (data?['skills'] as List).join(', ')
          : '',
    );

    String role = data?['role'] ?? 'graduate';

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                document == null
                    ? 'Add Career'
                    : 'Edit Career',
              ),
              content: SizedBox(
                width: 500,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _field(
                        careerNameController,
                        'Career Name',
                        Icons.work_outline,
                      ),
                      _field(
                        categoryController,
                        'Category ID',
                        Icons.category_outlined,
                      ),
                      _field(
                        categoryNameController,
                        'Category Name',
                        Icons.label_outline,
                      ),
                      _field(
                        descriptionController,
                        'Description',
                        Icons.description_outlined,
                        maxLines: 3,
                      ),
                      _field(
                        educationController,
                        'Education',
                        Icons.school_outlined,
                        maxLines: 2,
                      ),
                      _field(
                        salaryController,
                        'Salary Range',
                        Icons.payments_outlined,
                      ),
                      _field(
                        scopeController,
                        'Scope',
                        Icons.trending_up,
                        maxLines: 3,
                      ),
                      _field(
                        skillsController,
                        'Skills (comma separated)',
                        Icons.psychology_outlined,
                        maxLines: 2,
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        value: role,
                        decoration: InputDecoration(
                          labelText: 'Role',
                          prefixIcon: const Icon(
                            Icons.person_outline,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'student',
                            child: Text('Student'),
                          ),
                          DropdownMenuItem(
                            value: 'graduate',
                            child: Text('Graduate'),
                          ),
                          DropdownMenuItem(
                            value: 'professional',
                            child: Text('Professional'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              role = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (careerNameController.text
                        .trim()
                        .isEmpty) {
                      return;
                    }

                    final skills = skillsController.text
                        .split(',')
                        .map((e) => e.trim())
                        .where((e) => e.isNotEmpty)
                        .toList();

                    final careerData = {
                      'careerName':
                          careerNameController.text.trim(),
                      'category':
                          categoryController.text.trim(),
                      'categoryName':
                          categoryNameController.text.trim(),
                      'description':
                          descriptionController.text.trim(),
                      'education':
                          educationController.text.trim(),
                      'salaryRange':
                          salaryController.text.trim(),
                      'scope':
                          scopeController.text.trim(),
                      'skills': skills,
                      'role': role,
                      'updatedAt':
                          FieldValue.serverTimestamp(),
                    };

                    try {
                      if (document == null) {
                        careerData['createdAt'] =
                            FieldValue.serverTimestamp();

                        await _firestore
                            .collection('careerBank')
                            .add(careerData);

                        _showMessage(
                          'Career added successfully',
                          Colors.green,
                        );
                      } else {
                        await _firestore
                            .collection('careerBank')
                            .doc(document.id)
                            .update(careerData);

                        _showMessage(
                          'Career updated successfully',
                          Colors.green,
                        );
                      }

                      if (mounted) {
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      _showMessage(
                        'Failed to save career',
                        Colors.red,
                      );
                    }
                  },
                  child: Text(
                    document == null ? 'Add Career' : 'Update',
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    careerNameController.dispose();
    categoryController.dispose();
    categoryNameController.dispose();
    descriptionController.dispose();
    educationController.dispose();
    salaryController.dispose();
    scopeController.dispose();
    skillsController.dispose();
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  bool _matchesSearch(Map<String, dynamic> data) {
    if (_searchQuery.isEmpty) return true;

    final values = [
      data['careerName'],
      data['categoryName'],
      data['description'],
      data['education'],
      data['role'],
    ];

    return values.any(
      (value) => value
          .toString()
          .toLowerCase()
          .contains(_searchQuery),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(
          'Career Management',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF172033),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF172033),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCareerForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Career'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.trim().toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search careers...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<
                QuerySnapshot<Map<String, dynamic>>>(
              stream: _firestore
                  .collection('careerBank')
                  .orderBy(
                    'createdAt',
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading careers:\n${snapshot.error}',
                    ),
                  );
                }

                final docs = snapshot.data?.docs ?? [];

                final careers = docs
                    .where(
                      (doc) => _matchesSearch(doc.data()),
                    )
                    .toList();

                if (careers.isEmpty) {
                  return const Center(
                    child: Text('No careers found'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    18,
                    0,
                    18,
                    90,
                  ),
                  itemCount: careers.length,
                  itemBuilder: (context, index) {
                    final doc = careers[index];
                    final data = doc.data();

                    final name =
                        data['careerName'] ?? 'Unnamed Career';

                    final category =
                        data['categoryName'] ?? '';

                    final role =
                        data['role'] ?? '';

                    return Card(
                      margin: const EdgeInsets.only(
                        bottom: 12,
                      ),
                      color: Colors.white,
                      elevation: 1,
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.all(14),
                        leading: CircleAvatar(
                          backgroundColor:
                              Colors.blue.shade50,
                          child: const Icon(
                            Icons.work_outline,
                            color: Colors.blue,
                          ),
                        ),
                        title: Text(
                          name.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding:
                              const EdgeInsets.only(top: 6),
                          child: Text(
                            '$category • $role',
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.blue,
                              ),
                              onPressed: () =>
                                  _showCareerForm(
                                document: doc,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  _deleteCareer(doc.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}