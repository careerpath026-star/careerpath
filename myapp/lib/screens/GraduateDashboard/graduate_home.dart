import 'package:flutter/material.dart';
import 'graduate_drawer.dart';

class GraduateHome extends StatelessWidget {
  const GraduateHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),

      // Separate Drawer
      drawer: const GraduateDrawer(),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Graduate Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // WELCOME
            // ==========================================

            const Text(
              "Welcome back, Graduate! 👋",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              "Explore careers and discover your next opportunity.",
              style: TextStyle(
                color: Colors.white60,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 22),

            // ==========================================
            // QUIZ CARD
            // ==========================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF151F32),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF00C2FF).withOpacity(0.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.psychology_outlined,
                    color: Color(0xFF00C2FF),
                    size: 40,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Career Assessment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Take the career quiz to identify career paths "
                    "that match your skills, interests and education.",
                    style: TextStyle(
                      color: Colors.white60,
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Graduate quiz screen yahan connect hoga
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Graduate Career Quiz coming next.",
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C2FF),
                        foregroundColor: const Color(0xFF0B1220),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Take Career Quiz",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==========================================
            // ACTIVITY
            // ==========================================

            const Text(
              "Your Activity",
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.quiz_outlined,
                    value: "0",
                    title: "Quizzes",
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    icon: Icons.work_outline,
                    value: "0",
                    title: "Careers",
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _statCard(
                    icon: Icons.bookmark_outline,
                    value: "0",
                    title: "Saved",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ==========================================
            // RECOMMENDED CAREERS
            // ==========================================

            const Text(
              "Recommended Careers",
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            _careerCard(
              icon: Icons.code,
              title: "Software Developer",
              subtitle: "Technology • Programming",
            ),

            _careerCard(
              icon: Icons.analytics_outlined,
              title: "Data Analyst",
              subtitle: "Technology • Data",
            ),

            _careerCard(
              icon: Icons.design_services_outlined,
              title: "UI/UX Designer",
              subtitle: "Design • Technology",
            ),

            const SizedBox(height: 25),

            // ==========================================
            // TRENDING CAREERS
            // ==========================================

            const Text(
              "Trending Careers",
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 125,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _trendingCard(
                    "Artificial Intelligence",
                    Icons.smart_toy_outlined,
                  ),

                  _trendingCard(
                    "Cyber Security",
                    Icons.security_outlined,
                  ),

                  _trendingCard(
                    "Cloud Computing",
                    Icons.cloud_outlined,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==========================================
            // QUICK ACCESS
            // ==========================================

            const Text(
              "Quick Access",
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _quickCard(
                    Icons.video_library_outlined,
                    "Videos",
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _quickCard(
                    Icons.menu_book_outlined,
                    "Resources",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // STAT CARD
  // ==========================================

  Widget _statCard({
    required IconData icon,
    required String value,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF151F32),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFF00C2FF),
            size: 25,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // CAREER CARD
  // ==========================================

  Widget _careerCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF151F32),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF00C2FF).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF00C2FF),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white38,
            size: 16,
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TRENDING CARD
  // ==========================================

  Widget _trendingCard(
    String title,
    IconData icon,
  ) {
    return Container(
      width: 155,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151F32),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF00C2FF),
            size: 30,
          ),

          const Spacer(),

          Text(
            title,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // QUICK ACCESS CARD
  // ==========================================

  Widget _quickCard(
    IconData icon,
    String title,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF151F32),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF00C2FF),
          ),

          const SizedBox(width: 10),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}