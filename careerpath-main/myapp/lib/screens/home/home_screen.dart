import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/app_drawer.dart'; // <-- adjust path if your AppDrawer lives elsewhere
import '../auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout(BuildContext context) async {
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

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      drawer: const AppDrawer(), // <-- connected here

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),

        title: const Row(
          children: [
            Icon(
              Icons.explore_rounded,
              color: AppColors.primary,
              size: 27,
            ),
            SizedBox(width: 8),
            Text(
              'PathSeeker',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),

          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.red,
            ),
            tooltip: 'Logout',
          ),

          const SizedBox(width: 8),
        ],
      ),

      // ================= BODY =================
      body: StreamBuilder<DocumentSnapshot>(
        stream: user == null
            ? null
            : FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .snapshots(),

        builder: (context, snapshot) {
          final data =
              snapshot.data?.data() as Map<String, dynamic>?;

          final userType =
              data?['userType']?.toString() ?? 'student';

          final name =
              data?['name']?.toString() ??
              data?['fullName']?.toString() ??
              'Student';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                // ================= WELCOME CARD =================
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF3654E0),
                        Color(0xFF6278E8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),

                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Row(
                        children: [
                          Container(
                            height: 52,
                            width: 52,

                            decoration: BoxDecoration(
                              color: Colors.white
                                  .withOpacity(0.18),
                              borderRadius:
                                  BorderRadius.circular(16),
                            ),

                            child: const Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),

                          const Spacer(),

                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white
                                  .withOpacity(0.15),
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),

                            child: Text(
                              userType.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Text(
                        'Welcome, $name 👋',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        user?.email ?? '',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'Your personalized career journey starts here.',
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

                // ================= CAREER PROGRESS =================
                const Text(
                  'Career Progress',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 14),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),

                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: const [
                          Text(
                            'Profile Completion',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Text(
                            '65%',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(20),

                        child:
                            const LinearProgressIndicator(
                          value: 0.65,
                          minHeight: 9,

                          backgroundColor:
                              Color(0xFFE7EAF2),

                          valueColor:
                              AlwaysStoppedAnimation(
                            AppColors.primary,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        'Complete your profile to unlock better career opportunities.',
                        style: TextStyle(
                          color: Color(0xFF697386),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 15),

                      OutlinedButton(
                        onPressed: () {},
                        child:
                            const Text('Complete Profile'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ================= QUICK ACTIONS =================
                const Text(
                  'Explore PathSeeker',
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

                  physics:
                      const NeverScrollableScrollPhysics(),

                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,

                  childAspectRatio: 1.2,

                  children: [

                    _actionCard(
                      icon: Icons.explore_outlined,
                      title: 'Explore Careers',
                      subtitle:
                          'Discover career paths',
                      onTap: () {},
                    ),

                    _actionCard(
                      icon: Icons.work_outline_rounded,
                      title: 'Find Opportunities',
                      subtitle:
                          'Explore jobs & internships',
                      onTap: () {},
                    ),

                    _actionCard(
                      icon: Icons.psychology_outlined,
                      title: 'Skills',
                      subtitle:
                          'Build useful skills',
                      onTap: () {},
                    ),

                    _actionCard(
                      icon: Icons.school_outlined,
                      title: 'Learning',
                      subtitle:
                          'Learn something new',
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ================= RECOMMENDED =================
                const Text(
                  'Recommended For You',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 14),

                _recommendationCard(
                  icon: Icons.rocket_launch_rounded,
                  title: 'Build Your Career Profile',
                  subtitle:
                      'Add your education, skills and interests to get personalized recommendations.',
                ),

                const SizedBox(height: 12),

                _recommendationCard(
                  icon: Icons.trending_up_rounded,
                  title: 'Improve Your Skills',
                  subtitle:
                      'Explore skills that can help you prepare for your future career.',
                ),

                const SizedBox(height: 25),
              ],
            ),
          );
        },
      ),
    );
  }

  // ================= ACTION CARD =================

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
          crossAxisAlignment:
              CrossAxisAlignment.start,

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Container(
              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: Icon(
                icon,
                color: AppColors.primary,
                size: 25,
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

  // ================= RECOMMENDATION CARD =================

  static Widget _recommendationCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(
            height: 50,
            width: 50,

            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: Icon(
              icon,
              color: AppColors.primary,
              size: 26,
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
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF697386),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}