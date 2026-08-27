import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminSuccessStoriesPage extends StatefulWidget {
  const AdminSuccessStoriesPage({super.key});

  @override
  State<AdminSuccessStoriesPage> createState() =>
      _AdminSuccessStoriesPageState();
}

class _AdminSuccessStoriesPageState
    extends State<AdminSuccessStoriesPage> {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final TextEditingController _searchController =
      TextEditingController();

  String _searchQuery = '';
  String _selectedStatus = 'All';

  final List<String> statuses = [
    'pending',
    'approved',
    'rejected',
  ];

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

  Future<void> _updateStatus(
    String id,
    String status,
  ) async {
    try {
      final updateData = <String, dynamic>{
        'status': status,
        'updatedAt':
            FieldValue.serverTimestamp(),
      };

      if (status == 'approved') {
        updateData['approvedAt'] =
            FieldValue.serverTimestamp();
      }

      await _firestore
          .collection('success_stories')
          .doc(id)
          .update(updateData);

      _showMessage(
        status == 'approved'
            ? 'Story approved successfully'
            : 'Story rejected successfully',
        Colors.green,
      );
    } catch (e) {
      _showMessage(
        'Failed to update story',
        Colors.red,
      );
    }
  }

  Future<void> _deleteStory(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Story'),
          content: const Text(
            'Are you sure you want to permanently delete this success story?',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pop(context, true),
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
      await _firestore
          .collection('success_stories')
          .doc(id)
          .delete();

      _showMessage(
        'Story deleted successfully',
        Colors.green,
      );
    } catch (e) {
      _showMessage(
        'Failed to delete story',
        Colors.red,
      );
    }
  }

  Future<void> _showStoryDetails(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) async {
    final data = document.data() ?? {};

    final title =
        data['title'] ?? 'Success Story';

    final userName =
        data['userName'] ?? 'Unknown User';

    final career =
        data['career'] ?? '';

    final company =
        data['company'] ?? '';

    final category =
        data['category'] ?? '';

    final role =
        data['role'] ?? '';

    final story =
        data['story'] ?? '';

    final achievement =
        data['achievement'] ?? '';

    final status =
        data['status'] ?? 'pending';

    final profileImage =
        data['profileImage'] ?? '';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: 550,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  if (profileImage
                      .toString()
                      .isNotEmpty)
                    Center(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(50),
                        child: Image.network(
                          profileImage.toString(),
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stack) {
                            return const CircleAvatar(
                              radius: 45,
                              child: Icon(
                                Icons.person,
                                size: 45,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                  const SizedBox(height: 15),

                  _detail(
                    'User',
                    userName,
                  ),
                  _detail(
                    'Career',
                    career,
                  ),
                  _detail(
                    'Company',
                    company,
                  ),
                  _detail(
                    'Category',
                    category,
                  ),
                  _detail(
                    'Role',
                    role,
                  ),
                  _detail(
                    'Status',
                    status,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Story',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    story.toString(),
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Achievement',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    achievement.toString(),
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _detail(
    String label,
    dynamic value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black87,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: value.toString(),
            ),
          ],
        ),
      ),
    );
  }

  bool _matchesSearch(
    Map<String, dynamic> data,
  ) {
    if (_searchQuery.isEmpty) return true;

    final values = [
      data['title'],
      data['userName'],
      data['career'],
      data['company'],
      data['category'],
      data['story'],
      data['achievement'],
    ];

    return values.any(
      (value) => value
          .toString()
          .toLowerCase()
          .contains(_searchQuery),
    );
  }

  Widget _statusChip(String status) {
    Color color;

    switch (status) {
      case 'approved':
        color = Colors.green;
        break;
      case 'rejected':
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text(
          'Success Stories Management',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              18,
              18,
              10,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery =
                      value.trim().toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText:
                    'Search stories, users, careers...',
                prefixIcon:
                    const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: InputDecoration(
                labelText: 'Filter by Status',
                prefixIcon:
                    const Icon(Icons.filter_list),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
              items: [
                const DropdownMenuItem(
                  value: 'All',
                  child: Text('All Stories'),
                ),
                ...statuses.map(
                  (status) => DropdownMenuItem(
                    value: status,
                    child: Text(
                      status[0].toUpperCase() +
                          status.substring(1),
                    ),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _selectedStatus = value;
                });
              },
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: StreamBuilder<
                QuerySnapshot<Map<String, dynamic>>>(
              stream: _firestore
                  .collection('success_stories')
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
                      'Error loading stories:\n${snapshot.error}',
                    ),
                  );
                }

                final docs =
                    snapshot.data?.docs ?? [];

                final stories = docs.where((doc) {
                  final data = doc.data();

                  final status =
                      data['status'] ?? 'pending';

                  final statusMatches =
                      _selectedStatus == 'All' ||
                      status ==
                          _selectedStatus;

                  return statusMatches &&
                      _matchesSearch(data);
                }).toList();

                if (stories.isEmpty) {
                  return const Center(
                    child: Text(
                      'No success stories found',
                    ),
                  );
                }

                return ListView.builder(
                  padding:
                      const EdgeInsets.fromLTRB(
                    18,
                    0,
                    18,
                    20,
                  ),
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    final doc = stories[index];
                    final data = doc.data();

                    final title =
                        data['title'] ??
                            'Untitled Story';

                    final userName =
                        data['userName'] ??
                            'Unknown User';

                    final career =
                        data['career'] ?? '';

                    final company =
                        data['company'] ?? '';

                    final status =
                        data['status'] ??
                            'pending';

                    final story =
                        data['story'] ?? '';

                    return Card(
                      margin:
                          const EdgeInsets.only(
                        bottom: 14,
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding:
                            const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Colors.blue.shade50,
                                  child: const Icon(
                                    Icons.person,
                                    color:
                                        Colors.blue,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        title.toString(),
                                        style:
                                            const TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        userName.toString(),
                                        style:
                                            TextStyle(
                                          color: Colors
                                              .grey
                                              .shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                _statusChip(
                                  status.toString(),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Text(
                              '$career • $company',
                              style: const TextStyle(
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              story.toString(),
                              maxLines: 3,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors
                                    .grey
                                    .shade600,
                                height: 1.4,
                              ),
                            ),

                            const SizedBox(height: 14),

                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () =>
                                        _showStoryDetails(
                                      doc,
                                    ),
                                    icon: const Icon(
                                      Icons
                                          .visibility_outlined,
                                    ),
                                    label:
                                        const Text(
                                      'View',
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                if (status !=
                                    'approved')
                                  Expanded(
                                    child:
                                        ElevatedButton.icon(
                                      onPressed: () =>
                                          _updateStatus(
                                        doc.id,
                                        'approved',
                                      ),
                                      style:
                                          ElevatedButton
                                              .styleFrom(
                                        backgroundColor:
                                            Colors.green,
                                        foregroundColor:
                                            Colors.white,
                                      ),
                                      icon:
                                          const Icon(
                                        Icons.check,
                                      ),
                                      label:
                                          const Text(
                                        'Approve',
                                      ),
                                    ),
                                  ),

                                if (status !=
                                    'rejected') ...[
                                  const SizedBox(
                                      width: 8),
                                  Expanded(
                                    child:
                                        ElevatedButton.icon(
                                      onPressed: () =>
                                          _updateStatus(
                                        doc.id,
                                        'rejected',
                                      ),
                                      style:
                                          ElevatedButton
                                              .styleFrom(
                                        backgroundColor:
                                            Colors.red,
                                        foregroundColor:
                                            Colors.white,
                                      ),
                                      icon:
                                          const Icon(
                                        Icons.close,
                                      ),
                                      label:
                                          const Text(
                                        'Reject',
                                      ),
                                    ),
                                  ),
                                ],

                                const SizedBox(width: 8),

                                IconButton(
                                  onPressed: () =>
                                      _deleteStory(
                                    doc.id,
                                  ),
                                  icon: const Icon(
                                    Icons
                                        .delete_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
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