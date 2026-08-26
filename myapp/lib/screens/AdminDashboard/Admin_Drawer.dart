import 'package:flutter/material.dart';
import 'package:myapp/screens/AdminDashboard/Admin_Story_Approval.dart';

// Apni actual screen imports yahan add/update kar lena.
import 'package:myapp/screens/AdminDashboard/admin_dashboard.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0B1220),

      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // =====================================================
              // HEADER
              // =====================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),

                decoration: const BoxDecoration(
                  color: Color(0xFF151F32),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Container(
                      width: 65,
                      height: 65,

                      decoration: BoxDecoration(
                        color: const Color(0xFF00C2FF),
                        borderRadius:
                            BorderRadius.circular(18),
                      ),

                      child: const Icon(
                        Icons.admin_panel_settings_outlined,
                        size: 36,
                        color: Color(0xFF0B1220),
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      "Admin Panel",
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

              // =====================================================
              // DASHBOARD
              // =====================================================

              _drawerItem(
                context,
                Icons.dashboard_outlined,
                "Dashboard",
                () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AdminDashboard(),
                    ),
                  );
                },
              ),

              // =====================================================
              // USERS
              // =====================================================

              _drawerItem(
                context,
                Icons.people_outline,
                "Users",
                () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "User Management coming next.",
                      ),
                    ),
                  );
                },
              ),

              // =====================================================
              // CAREER BANK
              // =====================================================

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

              // =====================================================
              // SUCCESS STORIES
              // =====================================================

              // _drawerItem(
              //   context,
              //   Icons.emoji_events_outlined,
              //   "Success Stories",
              //   () {
              //     Navigator.pop(context);

              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) =>
              //             const AdminSuccessStories(),
              //       ),
              //     );
              //   },
              // ),

              // =====================================================
              // APPROVALS
              // =====================================================

              _drawerItem(
                context,
                Icons.pending_actions_outlined,
                "Story Approvals",
                () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AdminSuccessStoryApproval(),
                    ),
                  );
                },
              ),

              // =====================================================
              // REPORTS
              // =====================================================

              _drawerItem(
                context,
                Icons.analytics_outlined,
                "Reports",
                () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Reports coming next.",
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 15),

              const Divider(
                color: Colors.white12,
                indent: 20,
                endIndent: 20,
              ),

              const SizedBox(height: 5),

              // =====================================================
              // SETTINGS
              // =====================================================

              _drawerItem(
                context,
                Icons.settings_outlined,
                "Settings",
                () {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Settings coming next.",
                      ),
                    ),
                  );
                },
              ),

              // =====================================================
              // LOGOUT
              // =====================================================

              _drawerItem(
                context,
                Icons.logout,
                "Logout",
                () {
                  Navigator.pop(context);

                  _showLogoutDialog(context);
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

  // ==========================================================
  // DRAWER ITEM
  // ==========================================================

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

  // ==========================================================
  // LOGOUT DIALOG
  // ==========================================================

  void _showLogoutDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFF151F32),

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18),
          ),

          title: const Text(
            "Logout",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          content: const Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white60,
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Logout coming next.",
                    ),
                  ),
                );
              },

              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}