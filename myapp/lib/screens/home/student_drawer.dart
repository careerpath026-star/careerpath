import 'package:flutter/material.dart';
import 'quiz_category.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0B1220),
      child: SafeArea(
        child: Column(
          children: [
            // ==============================
            // HEADER
            // ==============================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF151F32),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C2FF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF0B1220),
                      size: 35,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Student Panel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "Career Path",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ==============================
            // HOME
            // ==============================

            _drawerItem(
              context: context,
              icon: Icons.home_outlined,
              title: "Home",
              onTap: () {
                Navigator.pop(context);
              },
            ),

            // ==============================
            // TAKE QUIZ
            // ==============================

            _drawerItem(
              context: context,
              icon: Icons.quiz_outlined,
              title: "Take Quiz",
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuizCategory(),
                  ),
                );
              },
            ),

            // ==============================
            // CAREER EXPLORER
            // ==============================

            _drawerItem(
              context: context,
              icon: Icons.explore_outlined,
              title: "Explore Careers",
              onTap: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Career Explorer coming soon.",
                    ),
                  ),
                );
              },
            ),

            // ==============================
            // BOOKMARKS
            // ==============================

            _drawerItem(
              context: context,
              icon: Icons.bookmark_outline,
              title: "Bookmarks",
              onTap: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Bookmarks coming soon.",
                    ),
                  ),
                );
              },
            ),

            // ==============================
            // RESOURCES
            // ==============================

            _drawerItem(
              context: context,
              icon: Icons.menu_book_outlined,
              title: "Resources",
              onTap: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Resources coming soon.",
                    ),
                  ),
                );
              },
            ),

            const Spacer(),

            // ==============================
            // LOGOUT
            // ==============================

            const Divider(
              color: Colors.white12,
              indent: 20,
              endIndent: 20,
            ),

            _drawerItem(
              context: context,
              icon: Icons.logout,
              title: "Logout",
              iconColor: Colors.redAccent,
              textColor: Colors.redAccent,
              onTap: () {
                Navigator.pop(context);

                // Firebase logout baad mein add karenge.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Logout will be connected to Firebase Auth.",
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  // ==============================
  // DRAWER ITEM
  // ==============================

  Widget _drawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.white70,
    Color textColor = Colors.white,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 3,
      ),

      leading: Icon(
        icon,
        color: iconColor,
        size: 23,
      ),

      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),

      onTap: onTap,
    );
  }
}