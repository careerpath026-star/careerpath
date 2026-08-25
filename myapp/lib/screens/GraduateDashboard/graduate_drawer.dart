import 'package:flutter/material.dart';
import 'package:myapp/screens/GraduateDashboard/Saved_Careers.dart';
import 'package:myapp/screens/GraduateDashboard/graduate_careers.dart';
import 'package:myapp/screens/GraduateDashboard/graduate_profile.dart';

class GraduateDrawer extends StatelessWidget {
  const GraduateDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0B1220),

      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ==========================================
              // HEADER
              // ==========================================

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
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C2FF),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.school,
                        size: 34,
                        color: Color(0xFF0B1220),
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      "Graduate Panel",
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

              // ==========================================
              // HOME
              // ==========================================

              _drawerItem(
                context,
                Icons.home_outlined,
                "Home",
                () {
                  Navigator.pop(context);
                },
              ),

              // ==========================================
              // CAREER QUIZ
              // ==========================================

              _drawerItem(
                context,
                Icons.quiz_outlined,
                "Career Quiz",
                () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Career Quiz coming next.",
                      ),
                    ),
                  );
                },
              ),

              // ==========================================
              // CAREER BANK
              // ==========================================

              _drawerItem(
                context,
                Icons.work_outline,
                "Career Bank",
                () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Career Bank coming next.",
                      ),
                    ),
                  );
                },
              ),

              // ==========================================
              // VIDEOS
              // ==========================================

              _drawerItem(
                context,
                Icons.video_library_outlined,
                "Videos",
                () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Videos coming next.",
                      ),
                    ),
                  );
                },
              ),

              // ==========================================
              // RESOURCES
              // ==========================================

              _drawerItem(
                context,
                Icons.menu_book_outlined,
                "Resources",
                () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Resources coming next.",
                      ),
                    ),
                  );
                },
              ),

              // ==========================================
              // SUCCESS STORIES
              // ==========================================

              _drawerItem(
                context,
                Icons.emoji_events_outlined,
                "Success Stories",
                () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Success Stories coming next.",
                      ),
                    ),
                  );
                },
              ),

              // ==========================================
              // BOOKMARKS
              // ==========================================

              _drawerItem(
                context,
                Icons.bookmark_outline,
                "Bookmarks",
                () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Bookmarks coming next.",
                      ),
                    ),
                  );
                },
              ),

              // ==========================================
              // PROFILE
              // ==========================================

              _drawerItem(
                context,
                Icons.person_outline,
                "Profile",
                () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GraduateProfile(),
                    ),
                  );
                },
              ),

              _drawerItem(
                context,
                Icons.person_outline,
                "Career Bank",
                () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GraduateCareerBank(),
                    ),
                  );
                },
              ),

              _drawerItem(
                context,
                Icons.person_outline,
                "Saved Career",
                () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const SavedCareersScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              const Divider(
                color: Colors.white12,
                indent: 20,
                endIndent: 20,
              ),

              const SizedBox(height: 5),

              // ==========================================
              // LOGOUT
              // ==========================================

              _drawerItem(
                context,
                Icons.logout,
                "Logout",
                () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Logout coming next.",
                      ),
                    ),
                  );
                },
                color: Colors.redAccent,
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // DRAWER ITEM
  // ==========================================

  Widget _drawerItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color color = Colors.white70,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 1,
      ),

      leading: Icon(
        icon,
        color: color,
        size: 23,
      ),

      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),

      onTap: onTap,
    );
  }
}
