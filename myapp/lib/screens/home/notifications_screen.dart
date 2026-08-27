import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ==============================================================
// FIRESTORE SCHEMA
//
// notifications/{notifId}
//   title       : String
//   message     : String
//   type        : "announcement" | "response" | "system"
//   targetUid   : String?  (null/empty = broadcast to ALL students;
//                           otherwise shown only to that student —
//                           used for admin replies to Feedback)
//   createdAt   : Timestamp
//   readBy      : List<String>  (uids that have opened this notif)
//
// Admin side (separate app/panel, not built here) just needs to
// create docs in this collection with these fields.
// ==============================================================

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==========================================================
  // MARK AS READ
  // ==========================================================

  Future<void> _markAsRead(String notifId, List<dynamic> readBy) async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    if (readBy.contains(user.uid)) return; // already read

    try {
      await _firestore.collection('notifications').doc(notifId).update({
        'readBy': FieldValue.arrayUnion([user.uid]),
      });
    } catch (e) {
      debugPrint("Failed to mark notification as read: $e");
    }
  }

  // ==========================================================
  // OPEN DETAIL
  // ==========================================================

  void _openDetail(String notifId, Map<String, dynamic> data) {
    final List<dynamic> readBy = data['readBy'] ?? [];
    _markAsRead(notifId, readBy);

    final String type = data['type']?.toString() ?? 'announcement';
    final String title = data['title']?.toString() ?? 'Notification';
    final String message = data['message']?.toString() ?? '';
    final Timestamp? createdAt = data['createdAt'] is Timestamp
        ? data['createdAt'] as Timestamp
        : null;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151F32),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: _typeColor(type).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(_typeIcon(type), color: _typeColor(type)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (createdAt != null)
                          Text(
                            _formatFullDate(createdAt.toDate()),
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 11,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // HELPERS
  // ==========================================================

  IconData _typeIcon(String type) {
    switch (type) {
      case 'response':
        return Icons.chat_bubble_outline;
      case 'system':
        return Icons.info_outline;
      case 'announcement':
      default:
        return Icons.campaign_outlined;
    }
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'response':
        return const Color(0xFF00C2FF);
      case 'system':
        return Colors.orangeAccent;
      case 'announcement':
      default:
        return const Color(0xFF6278E8);
    }
  }

  String _timeAgo(dynamic timestamp) {
    if (timestamp is! Timestamp) return "";

    final DateTime date = timestamp.toDate();
    final Duration diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    if (diff.inDays < 7) return "${diff.inDays}d ago";

    return "${date.day}/${date.month}/${date.year}";
  }

  String _formatFullDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} • "
        "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: user == null
          ? const Center(
              child: Text(
                "Please log in to see notifications.",
                style: TextStyle(color: Colors.white54),
              ),
            )
          // ====================================================
          // NOTE: This query pulls the most recent broadcast +
          // targeted notifications together and filters client
          // side. This keeps the Firestore rules/index simple.
          // If your notification volume grows large, split into
          // two queries (targetUid == null, targetUid == uid) or
          // add a composite index and filter server-side instead.
          // ====================================================
          : StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('notifications')
                  .orderBy('createdAt', descending: true)
                  .limit(50)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF00C2FF),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Failed to load notifications: ${snapshot.error}",
                      style: const TextStyle(color: Colors.white54),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final allDocs = snapshot.data?.docs ?? [];

                final docs = allDocs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final String? target = data['targetUid']?.toString();
                  return target == null ||
                      target.isEmpty ||
                      target == user.uid;
                }).toList();

                if (docs.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            color: Colors.white24,
                            size: 50,
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            "No notifications yet",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Admin responses and announcements will appear here.",
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: docs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    final String type =
                        data['type']?.toString() ?? 'announcement';
                    final String title =
                        data['title']?.toString() ?? 'Notification';
                    final String message = data['message']?.toString() ?? '';
                    final List<dynamic> readBy = data['readBy'] ?? [];
                    final bool isUnread = !readBy.contains(user.uid);
                    final String when = _timeAgo(data['createdAt']);

                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => _openDetail(doc.id, data),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF151F32),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isUnread
                                ? const Color(0xFF00C2FF).withOpacity(0.3)
                                : Colors.white12,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                color: _typeColor(type).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                _typeIcon(type),
                                color: _typeColor(type),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: isUnread
                                                ? FontWeight.bold
                                                : FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      if (isUnread)
                                        Container(
                                          height: 8,
                                          width: 8,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF00C2FF),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    message,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                      height: 1.4,
                                    ),
                                  ),
                                  if (when.isNotEmpty) ...[
                                    const SizedBox(height: 6),
                                    Text(
                                      when,
                                      style: const TextStyle(
                                        color: Colors.white38,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}