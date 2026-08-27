// import 'package:flutter/material.dart';
// import 'package:myapp/screens/home/student_profile_screen.dart';
// import 'quiz_category.dart';

// class StudentDrawer extends StatelessWidget {
//   const StudentDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: const Color(0xFF0B1220),
//       child: SafeArea(
//         child: Column(
//           children: [
//             // ==============================
//             // HEADER
//             // ==============================

//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),
//               decoration: const BoxDecoration(
//                 color: Color(0xFF151F32),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 65,
//                     width: 65,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF00C2FF),
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     child: const Icon(
//                       Icons.person,
//                       color: Color(0xFF0B1220),
//                       size: 35,
//                     ),
//                   ),

//                   const SizedBox(height: 15),

//                   const Text(
//                     "Student Panel",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 21,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 4),

//                   const Text(
//                     "Career Path",
//                     style: TextStyle(
//                       color: Colors.white60,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 12),

//             // ==============================
//             // HOME
//             // ==============================

//             _drawerItem(
//               context: context,
//               icon: Icons.home_outlined,
//               title: "Home",
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),

//             // ==============================
//             // TAKE QUIZ
//             // ==============================

//             _drawerItem(
//               context: context,
//               icon: Icons.quiz_outlined,
//               title: "Take Quiz",
//               onTap: () {
//                 Navigator.pop(context);

//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const QuizCategory(),
//                   ),
//                 );
//               },
//             ),

//             // ==============================
//             // CAREER EXPLORER
//             // ==============================

//             _drawerItem(
//               context: context,
//               icon: Icons.explore_outlined,
//               title: "Explore Careers",
//               onTap: () {
//                 Navigator.pop(context);

//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text(
//                       "Career Explorer coming soon.",
//                     ),
//                   ),
//                 );
//               },
//             ),

//             _drawerItem(
//         context: context,
//         icon: Icons.person_outline,
//         title: "Student Profile",
//         onTap: () {
//           Navigator.pop(context); // Close the drawer

//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const StudentProfileScreen(), // No UID needed here anymore!
//             ),
//           );
//         },
//       ),


//             // ==============================
//             // BOOKMARKS
//             // ==============================

//             _drawerItem(
//               context: context,
//               icon: Icons.bookmark_outline,
//               title: "Bookmarks",
//               onTap: () {
//                 Navigator.pop(context);

//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text(
//                       "Bookmarks coming soon.",
//                     ),
//                   ),
//                 );
//               },
//             ),

//             // ==============================
//             // RESOURCES
//             // ==============================

//             _drawerItem(
//               context: context,
//               icon: Icons.menu_book_outlined,
//               title: "Resources",
//               onTap: () {
//                 Navigator.pop(context);

//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text(
//                       "Resources coming soon.",
//                     ),
//                   ),
//                 );
//               },
//             ),

//             const Spacer(),

//             // ==============================
//             // LOGOUT
//             // ==============================

//             const Divider(
//               color: Colors.white12,
//               indent: 20,
//               endIndent: 20,
//             ),

//             _drawerItem(
//               context: context,
//               icon: Icons.logout,
//               title: "Logout",
//               iconColor: Colors.redAccent,
//               textColor: Colors.redAccent,
//               onTap: () {
//                 Navigator.pop(context);

//                 // Firebase logout baad mein add karenge.
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text(
//                       "Logout will be connected to Firebase Auth.",
//                     ),
//                   ),
//                 );
//               },
//             ),

//             const SizedBox(height: 15),
//           ],
//         ),
//       ),
//     );
//   }

//   // ==============================
//   // DRAWER ITEM
//   // ==============================

//   Widget _drawerItem({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     Color iconColor = Colors.white70,
//     Color textColor = Colors.white,
//   }) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(
//         horizontal: 22,
//         vertical: 3,
//       ),

//       leading: Icon(
//         icon,
//         color: iconColor,
//         size: 23,
//       ),

//       title: Text(
//         title,
//         style: TextStyle(
//           color: textColor,
//           fontSize: 15,
//           fontWeight: FontWeight.w500,
//         ),
//       ),

//       onTap: onTap,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:myapp/screens/home/career_bank_screen.dart';
import 'package:myapp/screens/home/career_quiz_screen.dart';
import 'package:myapp/screens/home/engage_screen.dart';
import 'package:myapp/screens/home/notifications_screen.dart';
import 'package:myapp/screens/home/student_profile_screen.dart';
import 'quiz_category.dart';
import 'explore_hub_screen.dart';
import 'success_stories_screen.dart';

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
            // STYLISH HEADER
            // ==============================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF151F32), Color(0xFF0B1220)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                border: Border(
                  bottom: BorderSide(color: Colors.white12, width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00C2FF), Color(0xFF0072FF)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00C2FF).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Student Panel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "Career Path Guidance",
                    style: TextStyle(
                      color: Color(0xFF00C2FF),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // ==============================
            // SCROLLABLE MENU ITEMS (PREVENTS OVERFLOW)
            // ==============================
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    _drawerItem(
                      context: context,
                      icon: Icons.home_rounded,
                      title: "Home",
                      onTap: () => Navigator.pop(context),
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.category_outlined,
                      title: "Quiz Categories",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const QuizCategory()),
                        );
                      },
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.quiz_outlined,
                      title: "Career Quiz",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CareerQuizScreen()),
                        );
                      },
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.explore_outlined,
                      title: "Explore Careers",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CareerBankScreen()),
                        );
                      },
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.person_outline_rounded,
                      title: "Student Profile",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const StudentProfileScreen()),
                        );
                      },
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.dynamic_feed_outlined,
                      title: "Engage Community",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const EngageScreen()),
                        );
                      },
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.star_outline_rounded,
                      title: "Success Stories",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SuccessStoriesScreen()),
                        );
                      },
                    ),
                     _drawerItem(
                      context: context,
                      icon: Icons.rowing_rounded,
                      title: "notifications",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                        );
                      },
                    ),
                    _drawerItem(
                      context: context,
                      icon: Icons.menu_book_rounded,
                      title: "Resources & Library",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ExploreHubScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ==============================
            // LOGOUT AT BOTTOM
            // ==============================
            const Divider(color: Colors.white12, height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: _drawerItem(
                context: context,
                icon: Icons.logout_rounded,
                title: "Logout",
                iconColor: const Color(0xFFFF5252),
                textColor: const Color(0xFFFF5252),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Logged out successfully"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = const Color(0xFF00C2FF),
    Color textColor = Colors.white,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          dense: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          leading: Icon(icon, color: iconColor, size: 22),
          title: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: onTap,
          hoverColor: const Color(0xFF151F32),
        ),
      ),
    );
  }
}