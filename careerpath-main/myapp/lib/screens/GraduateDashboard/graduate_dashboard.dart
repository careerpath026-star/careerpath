import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/auth/login_screen.dart';
import 'package:myapp/widgets/app_drawer.dart'; // <-- adjust path if your AppDrawer lives elsewhere

class GraduateDashboard extends StatelessWidget {
  const GraduateDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      drawer: const AppDrawer(), // <-- connected here

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),
        title: const Text(
          'Graduate Hub',
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

            // Welcome Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF7C3AED),
                    Color(0xFF9F67F4),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.school_rounded,
                    color: Colors.white,
                    size: 38,
                  ),

                  SizedBox(height: 14),

                  Text(
                    'Welcome, Graduate 🎓',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Your degree is a beginning. Prepare yourself for the next step.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Your Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    icon: Icons.school_outlined,
                    value: '3.6',
                    title: 'CGPA',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _infoCard(
                    icon: Icons.task_alt_rounded,
                    value: '78%',
                    title: 'Career Ready',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    icon: Icons.work_outline_rounded,
                    value: '07',
                    title: 'Jobs Applied',
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _infoCard(
                    icon: Icons.workspace_premium_outlined,
                    value: '05',
                    title: 'Certificates',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Career Readiness
            const Text(
              'Career Readiness',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(20),
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
                        'Career Preparation',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '78%',
                        style: TextStyle(
                          color: Color(0xFF7C3AED),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const LinearProgressIndicator(
                      value: 0.78,
                      minHeight: 9,
                      backgroundColor: Color(0xFFEDE9FE),
                      valueColor: AlwaysStoppedAnimation(
                        Color(0xFF7C3AED),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Complete your CV, improve your skills and prepare for interviews.',
                    style: TextStyle(
                      color: Color(0xFF697386),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C3AED),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Improve My Profile'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Graduate Tools
            const Text(
              'Graduate Tools',
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
              childAspectRatio: 1.15,
              children: [
                _toolCard(
                  icon: Icons.description_outlined,
                  title: 'Build CV',
                  subtitle: 'Create your resume',
                  onTap: () {},
                ),

                _toolCard(
                  icon: Icons.work_outline_rounded,
                  title: 'Find Jobs',
                  subtitle: 'Explore graduate jobs',
                  onTap: () {},
                ),

                _toolCard(
                  icon: Icons.psychology_outlined,
                  title: 'Skills',
                  subtitle: 'Develop new skills',
                  onTap: () {},
                ),

                _toolCard(
                  icon: Icons.workspace_premium_outlined,
                  title: 'Certificates',
                  subtitle: 'Manage certificates',
                  onTap: () {},
                ),

                _toolCard(
                  icon: Icons.record_voice_over_outlined,
                  title: 'Interview Prep',
                  subtitle: 'Practice interviews',
                  onTap: () {},
                ),

                _toolCard(
                  icon: Icons.people_outline_rounded,
                  title: 'Networking',
                  subtitle: 'Connect with people',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Recommended Opportunity
            const Text(
              'Recommended For You',
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
              child: Row(
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.rocket_launch_rounded,
                      color: Color(0xFF7C3AED),
                      size: 27,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Graduate Career Program',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFF172033),
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'A great opportunity to start your professional journey.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF697386),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Color(0xFF7C3AED),
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

  static Widget _infoCard({
    required IconData icon,
    required String value,
    required String title,
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
            color: const Color(0xFF7C3AED),
            size: 27,
          ),

          const SizedBox(height: 13),

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

  static Widget _toolCard({
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
                color: const Color(0xFFF3E8FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF7C3AED),
                size: 24,
              ),
            ),

            const SizedBox(height: 11),

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
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