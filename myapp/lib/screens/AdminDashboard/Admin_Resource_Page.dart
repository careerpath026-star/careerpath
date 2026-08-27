import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminResourcePage extends StatefulWidget {
  const AdminResourcePage({super.key});

  @override
  State<AdminResourcePage> createState() => _AdminResourcePageState();
}

class _AdminResourcePageState extends State<AdminResourcePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  String _selectedRole = 'Student';
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  // =====================================================
  // ADD RESOURCE
  // =====================================================

  Future<void> _addResource() async {
    if (_titleController.text.trim().isEmpty) {
      _showMessage('Please enter resource title.', Colors.red);
      return;
    }

    if (_urlController.text.trim().isEmpty) {
      _showMessage('Please enter resource URL.', Colors.red);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await _firestore.collection('resources').add({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'resourceUrl': _urlController.text.trim(),
        'role': _selectedRole,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      _titleController.clear();
      _descriptionController.clear();
      _urlController.clear();

      setState(() {
        _selectedRole = 'Student';
        _isSaving = false;
      });

      _showMessage(
        'Resource added successfully.',
        Colors.green,
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });

      _showMessage(
        'Failed to add resource: $e',
        Colors.red,
      );
    }
  }

  // =====================================================
  // DELETE RESOURCE
  // =====================================================

  Future<void> _deleteResource(String documentId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Resource'),
          content: const Text(
            'Are you sure you want to delete this resource?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      await _firestore
          .collection('resources')
          .doc(documentId)
          .delete();

      if (!mounted) return;

      _showMessage(
        'Resource deleted successfully.',
        Colors.green,
      );
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        'Failed to delete resource: $e',
        Colors.red,
      );
    }
  }

  // =====================================================
  // MESSAGE
  // =====================================================

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
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
        role,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  // =====================================================
  // ADD FORM
  // =====================================================

  Widget _addResourceForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Resource',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172033),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Add PDFs, articles, guides or other learning material.',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 20),

          // TITLE
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Resource Title',
              hintText: 'e.g. Roadmap to Software Engineering',
              prefixIcon: Icon(Icons.title_outlined),
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 14),

          // DESCRIPTION
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Describe this resource...',
              prefixIcon: Icon(Icons.description_outlined),
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),

          const SizedBox(height: 14),

          // URL
          TextField(
            controller: _urlController,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
              labelText: 'Resource URL',
              hintText: 'https://example.com/resource.pdf',
              prefixIcon: Icon(Icons.link_outlined),
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 14),

          // ROLE - LAST FIELD
          DropdownButtonFormField<String>(
            value: _selectedRole,
            decoration: const InputDecoration(
              labelText: 'Role',
              prefixIcon: Icon(Icons.people_outline),
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
              if (value == null) return;

              setState(() {
                _selectedRole = value;
              });
            },
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isSaving ? null : _addResource,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              icon: _isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.add),
              label: Text(
                _isSaving ? 'Adding...' : 'Add Resource',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // RESOURCE LIST
  // =====================================================

  Widget _resourceList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firestore
          .collection('resources')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Text(
            'Unable to load resources: ${snapshot.error}',
            style: const TextStyle(color: Colors.red),
          );
        }

        final resources = snapshot.data?.docs ?? [];

        if (resources.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            child: const Column(
              children: [
                Icon(
                  Icons.menu_book_outlined,
                  size: 50,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Text('No resources added yet.'),
              ],
            ),
          );
        }

        return Column(
          children: resources.map((doc) {
            final data = doc.data();

            final title =
                (data['title'] ?? 'Untitled').toString();

            final description =
                (data['description'] ?? '').toString();

            final url =
                (data['resourceUrl'] ?? '').toString();

            final role =
                (data['role'] ?? 'Unknown').toString();

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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.menu_book_outlined,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        if (description.isNotEmpty) ...[
                          const SizedBox(height: 5),
                          Text(
                            description,
                            maxLines: 2,
                            overflow:
                                TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            _roleChip(role),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                url,
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    tooltip: 'Delete',
                    onPressed: () {
                      _deleteResource(doc.id);
                    },
                    color: Colors.red,
                    icon: const Icon(
                      Icons.delete_outline,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
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
          'Resource Management',
          style: TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _addResourceForm(),

              const SizedBox(height: 25),

              const Text(
                'All Resources',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172033),
                ),
              ),

              const SizedBox(height: 12),

              _resourceList(),
            ],
          ),
        ),
      ),
    );
  }
}
