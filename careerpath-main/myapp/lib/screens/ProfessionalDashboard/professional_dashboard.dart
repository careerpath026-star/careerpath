import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/auth/login_screen.dart';
import 'package:myapp/widgets/app_drawer.dart'; // <-- adjust path if your AppDrawer lives elsewhere

class ProfessionalDashboard extends StatelessWidget {
  const ProfessionalDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      drawer: const AppDrawer(), // <-- connected here

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),
        title: const Text(
          'Professional Hub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
  IconButton(
    icon: const Icon(Icons.notifications_none_rounded),
    onPressed: () {},
  ),

  IconButton(
    icon: const Icon(
      Icons.logout_rounded,
      color: Colors.red,
    ),
    tooltip: 'Logout',
    onPressed: () async {
      final shouldLogout = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const Text(
              'Are you sure you want to logout?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Logout'),
              ),
            ],
          );
        },
      );

      if (shouldLogout == true) {
        await FirebaseAuth.instance.signOut();

        if (!context.mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    },
  ),

  const SizedBox(width: 8),
],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3654E0),
                    Color(0xFF6278E8),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.workspace_premium_rounded,
                    color: Colors.white,
                    size: 38,
                  ),

                  SizedBox(height: 15),

                  Text(
                    'Welcome, Professional 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Build your career, discover opportunities and grow professionally.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Career Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 15),

            // Statistics
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.work_outline_rounded,
                    title: 'Applications',
                    value: '12',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    icon: Icons.event_available_rounded,
                    title: 'Interviews',
                    value: '04',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.bookmark_outline_rounded,
                    title: 'Saved Jobs',
                    value: '08',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    icon: Icons.auto_graph_rounded,
                    title: 'Profile Score',
                    value: '82%',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Profile Strength
            const Text(
              'Profile Strength',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Your profile is 82% complete',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '82%',
                        style: TextStyle(
                          color: Color(0xFF3654E0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const LinearProgressIndicator(
                      value: 0.82,
                      minHeight: 9,
                      backgroundColor: Color(0xFFE5E9F5),
                      valueColor: AlwaysStoppedAnimation(
                        Color(0xFF3654E0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Add certifications and update your skills to improve your profile.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF697386),
                    ),
                  ),

                  const SizedBox(height: 15),

                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Complete Profile'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Quick Actions
            const Text(
              'Professional Tools',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 15),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.25,
              children: [
                _actionCard(
                  icon: Icons.search_rounded,
                  title: 'Find Jobs',
                  subtitle: 'Explore opportunities',
                  onTap: () {},
                ),

                _actionCard(
                  icon: Icons.description_outlined,
                  title: 'My Applications',
                  subtitle: 'Track applications',
                  onTap: () {},
                ),

                _actionCard(
                  icon: Icons.psychology_outlined,
                  title: 'Skills',
                  subtitle: 'Improve your skills',
                  onTap: () {},
                ),

                _actionCard(
                  icon: Icons.school_outlined,
                  title: 'Certifications',
                  subtitle: 'Manage certificates',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Career Insight
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    color: Color(0xFF3654E0),
                    size: 30,
                  ),

                  SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Career Insight',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF172033),
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          'Keep your profile updated and add relevant skills to increase your chances of getting noticed by employers.',
                          style: TextStyle(
                            color: Color(0xFF697386),
                            height: 1.4,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  static Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF3654E0),
            size: 27,
          ),

          const SizedBox(height: 14),

          Text(
            value,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172033),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF697386),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF3654E0),
                size: 25,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 4),

            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF697386),
              ),
            ),
          ],
        ),
      ),
    );
  }
}