import 'package:flutter/material.dart';

class GraduateSidebar extends StatelessWidget {
  final Function(int) onItemSelected;

  const GraduateSidebar({
    super.key,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // =========================
            // PROFILE HEADER
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    child: Icon(
                      Icons.person,
                      size: 35,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Graduate',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Career Passport',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            // =========================
            // MENU ITEMS
            // =========================
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _menuItem(
                    icon: Icons.dashboard_outlined,
                    title: 'Dashboard',
                    index: 0,
                  ),

                  _menuItem(
                    icon: Icons.person_outline,
                    title: 'My Profile',
                    index: 1,
                  ),

                  _menuItem(
                    icon: Icons.psychology_outlined,
                    title: 'Career Quiz',
                    index: 2,
                  ),

                  _menuItem(
                    icon: Icons.work_outline,
                    title: 'Career Bank',
                    index: 3,
                  ),

                  _menuItem(
                    icon: Icons.auto_awesome_outlined,
                    title: 'Recommendations',
                    index: 4,
                  ),

                  _menuItem(
                    icon: Icons.video_library_outlined,
                    title: 'Multimedia',
                    index: 5,
                  ),

                  _menuItem(
                    icon: Icons.library_books_outlined,
                    title: 'Resources',
                    index: 6,
                  ),

                  _menuItem(
                    icon: Icons.star_outline,
                    title: 'Success Stories',
                    index: 7,
                  ),

                  _menuItem(
                    icon: Icons.bookmark_outline,
                    title: 'My Bookmarks',
                    index: 8,
                  ),

                  _menuItem(
                    icon: Icons.note_alt_outlined,
                    title: 'My Notes',
                    index: 9,
                  ),

                  _menuItem(
                    icon: Icons.history,
                    title: 'Recently Viewed',
                    index: 10,
                  ),

                  _menuItem(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    index: 11,
                  ),

                  _menuItem(
                    icon: Icons.feedback_outlined,
                    title: 'Feedback',
                    index: 12,
                  ),
                ],
              ),
            ),

            const Divider(),

            // =========================
            // SETTINGS
            // =========================
            _menuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              index: 13,
            ),

            // =========================
            // LOGOUT
            // =========================
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Add logout logic later
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // =========================
  // MENU ITEM
  // =========================
  Widget _menuItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        onItemSelected(index);
      },
    );
  }
}