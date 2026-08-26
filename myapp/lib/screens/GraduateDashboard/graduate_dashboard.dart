// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:myapp/screens/auth/login_screen.dart';

// class GraduateDashboard extends StatelessWidget {
//   const GraduateDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F8FC),

//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: const Color(0xFF172033),
//         title: const Text(
//           'Graduate Hub',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//   IconButton(
//     icon: const Icon(Icons.notifications_none_rounded),
//     onPressed: () {},
//   ),

//   IconButton(
//     icon: const Icon(
//       Icons.logout_rounded,
//       color: Colors.red,
//     ),
//     tooltip: 'Logout',
//     onPressed: () async {
//       final shouldLogout = await showDialog<bool>(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Logout'),
//             content: const Text(
//               'Are you sure you want to logout?',
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context, false);
//                 },
//                 child: const Text('Cancel'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context, true);
//                 },
//                 child: const Text('Logout'),
//               ),
//             ],
//           );
//         },
//       );

//       if (shouldLogout == true) {
//         await FirebaseAuth.instance.signOut();

//         if (!context.mounted) return;

//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (_) => const LoginScreen(),
//           ),
//           (route) => false,
//         );
//       }
//     },
//   ),

//   const SizedBox(width: 8),
// ],
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             // Welcome Banner
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(22),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color(0xFF7C3AED),
//                     Color(0xFF9F67F4),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.school_rounded,
//                     color: Colors.white,
//                     size: 38,
//                   ),

//                   SizedBox(height: 14),

//                   Text(
//                     'Welcome, Graduate 🎓',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   SizedBox(height: 8),

//                   Text(
//                     'Your degree is a beginning. Prepare yourself for the next step.',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                       height: 1.4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 28),

//             const Text(
//               'Your Progress',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF172033),
//               ),
//             ),

//             const SizedBox(height: 15),

//             Row(
//               children: [
//                 Expanded(
//                   child: _infoCard(
//                     icon: Icons.school_outlined,
//                     value: '3.6',
//                     title: 'CGPA',
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: _infoCard(
//                     icon: Icons.task_alt_rounded,
//                     value: '78%',
//                     title: 'Career Ready',
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),

//             Row(
//               children: [
//                 Expanded(
//                   child: _infoCard(
//                     icon: Icons.work_outline_rounded,
//                     value: '07',
//                     title: 'Jobs Applied',
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: _infoCard(
//                     icon: Icons.workspace_premium_outlined,
//                     value: '05',
//                     title: 'Certificates',
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),

//             // Career Readiness
//             const Text(
//               'Career Readiness',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF172033),
//               ),
//             ),

//             const SizedBox(height: 12),

//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.04),
//                     blurRadius: 12,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text(
//                         'Career Preparation',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 15,
//                         ),
//                       ),
//                       Text(
//                         '78%',
//                         style: TextStyle(
//                           color: Color(0xFF7C3AED),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 12),

//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: const LinearProgressIndicator(
//                       value: 0.78,
//                       minHeight: 9,
//                       backgroundColor: Color(0xFFEDE9FE),
//                       valueColor: AlwaysStoppedAnimation(
//                         Color(0xFF7C3AED),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 15),

//                   const Text(
//                     'Complete your CV, improve your skills and prepare for interviews.',
//                     style: TextStyle(
//                       color: Color(0xFF697386),
//                       fontSize: 13,
//                       height: 1.4,
//                     ),
//                   ),

//                   const SizedBox(height: 15),

//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF7C3AED),
//                       foregroundColor: Colors.white,
//                       elevation: 0,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 12,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text('Improve My Profile'),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 28),

//             // Graduate Tools
//             const Text(
//               'Graduate Tools',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF172033),
//               ),
//             ),

//             const SizedBox(height: 15),

//             GridView.count(
//               crossAxisCount: 2,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//               childAspectRatio: 1.15,
//               children: [
//                 _toolCard(
//                   icon: Icons.description_outlined,
//                   title: 'Build CV',
//                   subtitle: 'Create your resume',
//                   onTap: () {},
//                 ),

//                 _toolCard(
//                   icon: Icons.work_outline_rounded,
//                   title: 'Find Jobs',
//                   subtitle: 'Explore graduate jobs',
//                   onTap: () {},
//                 ),

//                 _toolCard(
//                   icon: Icons.psychology_outlined,
//                   title: 'Skills',
//                   subtitle: 'Develop new skills',
//                   onTap: () {},
//                 ),

//                 _toolCard(
//                   icon: Icons.workspace_premium_outlined,
//                   title: 'Certificates',
//                   subtitle: 'Manage certificates',
//                   onTap: () {},
//                 ),

//                 _toolCard(
//                   icon: Icons.record_voice_over_outlined,
//                   title: 'Interview Prep',
//                   subtitle: 'Practice interviews',
//                   onTap: () {},
//                 ),

//                 _toolCard(
//                   icon: Icons.people_outline_rounded,
//                   title: 'Networking',
//                   subtitle: 'Connect with people',
//                   onTap: () {},
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),

//             // Recommended Opportunity
//             const Text(
//               'Recommended For You',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF172033),
//               ),
//             ),

//             const SizedBox(height: 12),

//             Container(
//               padding: const EdgeInsets.all(18),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.04),
//                     blurRadius: 12,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 52,
//                     width: 52,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF3E8FF),
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: const Icon(
//                       Icons.rocket_launch_rounded,
//                       color: Color(0xFF7C3AED),
//                       size: 27,
//                     ),
//                   ),

//                   const SizedBox(width: 14),

//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Graduate Career Program',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                             color: Color(0xFF172033),
//                           ),
//                         ),

//                         SizedBox(height: 5),

//                         Text(
//                           'A great opportunity to start your professional journey.',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Color(0xFF697386),
//                             height: 1.3,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const Icon(
//                     Icons.arrow_forward_ios_rounded,
//                     size: 16,
//                     color: Color(0xFF7C3AED),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 25),
//           ],
//         ),
//       ),
//     );
//   }

//   static Widget _infoCard({
//     required IconData icon,
//     required String value,
//     required String title,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.035),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             icon,
//             color: const Color(0xFF7C3AED),
//             size: 27,
//           ),

//           const SizedBox(height: 13),

//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 23,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF172033),
//             ),
//           ),

//           const SizedBox(height: 4),

//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Color(0xFF697386),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget _toolCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(18),
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.035),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF3E8FF),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 icon,
//                 color: const Color(0xFF7C3AED),
//                 size: 24,
//               ),
//             ),

//             const SizedBox(height: 11),

//             Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//                 color: Color(0xFF172033),
//               ),
//             ),

//             const SizedBox(height: 4),

//             Text(
//               subtitle,
//               style: const TextStyle(
//                 fontSize: 11,
//                 color: Color(0xFF697386),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import './graduate_sidebar.dart';

// class GraduateHomePage extends StatefulWidget {
//   const GraduateHomePage({super.key});

//   @override
//   State<GraduateHomePage> createState() => _GraduateHomePageState();
// }

// class _GraduateHomePageState extends State<GraduateHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F8FC),

//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black87),
//         title: const Text(
//           'PathSeeker',
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.notifications_none),
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),

//       // Separate sidebar
//       drawer: GraduateSidebar(
//         onItemSelected: (index) {
//           Navigator.pop(context);

//           // Navigation will be connected later.
//           debugPrint('Sidebar item: $index');
//         },
//       ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               // ==========================================
//               // WELCOME SECTION
//               // ==========================================

//               const Text(
//                 'Good Morning, Graduate 👋',
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF172033),
//                 ),
//               ),

//               const SizedBox(height: 6),

//               Text(
//                 'Continue your career journey and discover opportunities that match your skills.',
//                 style: TextStyle(
//                   fontSize: 14,
//                   height: 1.5,
//                   color: Colors.grey.shade600,
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // ==========================================
//               // PROFILE COMPLETION
//               // ==========================================

//               _sectionTitle('Profile Progress'),

//               const SizedBox(height: 12),

//               _profileProgressCard(),

//               const SizedBox(height: 24),

//               // ==========================================
//               // CAREER ASSESSMENT
//               // ==========================================

//               _sectionTitle('Career Assessment'),

//               const SizedBox(height: 12),

//               _careerAssessmentCard(),

//               const SizedBox(height: 28),

//               // ==========================================
//               // TOP PICKS
//               // ==========================================

//               _sectionTitle(
//                 'Top Picks For You',
//                 actionText: 'View All',
//                 onAction: () {},
//               ),

//               const SizedBox(height: 12),

//               SizedBox(
//                 height: 190,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     _careerCard(
//                       icon: Icons.code,
//                       title: 'Software Engineer',
//                       category: 'Technology',
//                       match: '88%',
//                     ),

//                     _careerCard(
//                       icon: Icons.analytics_outlined,
//                       title: 'Data Scientist',
//                       category: 'Technology',
//                       match: '83%',
//                     ),

//                     _careerCard(
//                       icon: Icons.security_outlined,
//                       title: 'Cyber Security',
//                       category: 'Technology',
//                       match: '78%',
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 28),

//               // ==========================================
//               // TRENDING CAREERS
//               // ==========================================

//               _sectionTitle(
//                 'Trending Careers',
//                 actionText: 'Explore',
//                 onAction: () {},
//               ),

//               const SizedBox(height: 12),

//               _trendingCareer(
//                 number: '01',
//                 title: 'AI / Machine Learning Engineer',
//                 category: 'Technology',
//                 icon: Icons.smart_toy_outlined,
//               ),

//               _trendingCareer(
//                 number: '02',
//                 title: 'Cloud Engineer',
//                 category: 'Technology',
//                 icon: Icons.cloud_outlined,
//               ),

//               _trendingCareer(
//                 number: '03',
//                 title: 'Data Scientist',
//                 category: 'Technology',
//                 icon: Icons.bar_chart_outlined,
//               ),

//               _trendingCareer(
//                 number: '04',
//                 title: 'Cyber Security Analyst',
//                 category: 'Technology',
//                 icon: Icons.shield_outlined,
//               ),

//               const SizedBox(height: 28),

//               // ==========================================
//               // RECENTLY VIEWED
//               // ==========================================

//               _sectionTitle(
//                 'Recently Viewed',
//                 actionText: 'View All',
//                 onAction: () {},
//               ),

//               const SizedBox(height: 12),

//               _recentItem(
//                 icon: Icons.code,
//                 title: 'Software Engineer',
//                 subtitle: 'Technology',
//               ),

//               _recentItem(
//                 icon: Icons.data_object,
//                 title: 'Data Scientist',
//                 subtitle: 'Technology',
//               ),

//               _recentItem(
//                 icon: Icons.security,
//                 title: 'Cyber Security Analyst',
//                 subtitle: 'Technology',
//               ),

//               const SizedBox(height: 28),

//               // ==========================================
//               // RECOMMENDED LEARNING
//               // ==========================================

//               _sectionTitle(
//                 'Recommended Learning',
//                 actionText: 'View All',
//                 onAction: () {},
//               ),

//               const SizedBox(height: 12),

//               _learningCard(
//                 icon: Icons.play_circle_outline,
//                 title: 'Introduction to Data Science',
//                 subtitle: 'Video • 12 min',
//               ),

//               _learningCard(
//                 icon: Icons.picture_as_pdf_outlined,
//                 title: 'Roadmap to Software Engineering',
//                 subtitle: 'PDF • Beginner',
//               ),

//               _learningCard(
//                 icon: Icons.play_circle_outline,
//                 title: 'Cyber Security Fundamentals',
//                 subtitle: 'Video • 18 min',
//               ),

//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // =====================================================
//   // SECTION TITLE
//   // =====================================================

//   Widget _sectionTitle(
//     String title, {
//     String? actionText,
//     VoidCallback? onAction,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 19,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF172033),
//           ),
//         ),

//         if (actionText != null)
//           TextButton(
//             onPressed: onAction,
//             child: Text(
//               actionText,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   // =====================================================
//   // PROFILE PROGRESS CARD
//   // =====================================================

//   Widget _profileProgressCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               SizedBox(
//                 height: 70,
//                 width: 70,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     CircularProgressIndicator(
//                       value: 0.80,
//                       strokeWidth: 7,
//                       backgroundColor: Colors.grey.shade200,
//                       color: Colors.blue,
//                     ),
//                     const Text(
//                       '80%',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(width: 18),

//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Complete your profile',
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 6),
//                     Text(
//                       'A complete profile helps us provide better career recommendations.',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 13,
//                         height: 1.4,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 18),

//           Row(
//             children: [
//               _checkItem('Education', true),
//               _checkItem('Skills', true),
//               _checkItem('Interests', true),
//               _checkItem('Resume', false),
//             ],
//           ),

//           const SizedBox(height: 16),

//           SizedBox(
//             width: double.infinity,
//             child: OutlinedButton(
//               onPressed: () {},
//               child: const Text('Complete Profile'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _checkItem(String title, bool completed) {
//     return Expanded(
//       child: Row(
//         children: [
//           Icon(
//             completed
//                 ? Icons.check_circle
//                 : Icons.radio_button_unchecked,
//             size: 16,
//             color: completed ? Colors.green : Colors.grey,
//           ),
//           const SizedBox(width: 4),
//           Flexible(
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 11,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // CAREER ASSESSMENT
//   // =====================================================

//   Widget _careerAssessmentCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(22),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [
//             Color(0xFF2563EB),
//             Color(0xFF4F46E5),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Icon(
//             Icons.psychology_outlined,
//             color: Colors.white,
//             size: 35,
//           ),

//           const SizedBox(height: 15),

//           const Text(
//             'Discover Your Career Path',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 21,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 8),

//           const Text(
//             'Take our interest assessment and discover career fields that match your skills and interests.',
//             style: TextStyle(
//               color: Colors.white70,
//               height: 1.5,
//               fontSize: 13,
//             ),
//           ),

//           const SizedBox(height: 18),

//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.white,
//               foregroundColor: Colors.blue,
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 12,
//               ),
//             ),
//             child: const Text(
//               'Take Career Quiz',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // CAREER CARD
//   // =====================================================

//   Widget _careerCard({
//     required IconData icon,
//     required String title,
//     required String category,
//     required String match,
//   }) {
//     return Container(
//       width: 220,
//       margin: const EdgeInsets.only(right: 14),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(
//           color: Colors.grey.shade200,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   icon,
//                   color: Colors.blue,
//                 ),
//               ),

//               const Spacer(),

//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 8,
//                   vertical: 5,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade50,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   '$match Match',
//                   style: TextStyle(
//                     color: Colors.green.shade700,
//                     fontSize: 11,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const Spacer(),

//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 5),

//           Text(
//             category,
//             style: TextStyle(
//               color: Colors.grey.shade600,
//               fontSize: 12,
//             ),
//           ),

//           const SizedBox(height: 10),

//           const Text(
//             'Explore Career →',
//             style: TextStyle(
//               color: Colors.blue,
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // TRENDING CAREER
//   // =====================================================

//   Widget _trendingCareer({
//     required String number,
//     required String title,
//     required String category,
//     required IconData icon,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Row(
//         children: [
//           Text(
//             number,
//             style: TextStyle(
//               color: Colors.grey.shade400,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),

//           const SizedBox(width: 15),

//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade50,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: Colors.blue,
//               size: 20,
//             ),
//           ),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   category,
//                   style: TextStyle(
//                     color: Colors.grey.shade600,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const Icon(
//             Icons.arrow_forward_ios,
//             size: 15,
//             color: Colors.grey,
//           ),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // RECENTLY VIEWED
//   // =====================================================

//   Widget _recentItem({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(11),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               icon,
//               color: Colors.blueGrey,
//             ),
//           ),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     color: Colors.grey.shade600,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const Icon(
//             Icons.arrow_forward_ios,
//             size: 14,
//             color: Colors.grey,
//           ),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // LEARNING CARD
//   // =====================================================

//   Widget _learningCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade50,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               icon,
//               color: Colors.blue,
//               size: 25,
//             ),
//           ),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     color: Colors.grey.shade600,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const Icon(
//             Icons.arrow_forward_ios,
//             size: 14,
//             color: Colors.grey,
//           ),
//         ],
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './graduate_sidebar.dart';

class GraduateHomePage extends StatefulWidget {
  const GraduateHomePage({super.key});

  @override
  State<GraduateHomePage> createState() => _GraduateHomePageState();
}

class _GraduateHomePageState extends State<GraduateHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // =====================================================
  // DYNAMIC COUNTS
  // =====================================================

  int quizAttemptCount = 0;
  int savedCareerCount = 0;
  int totalCareerCount = 0;

  bool isLoadingStats = true;

  // =====================================================
  // INIT
  // =====================================================

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  // =====================================================
  // LOAD ALL DASHBOARD DATA
  // =====================================================

  Future<void> _loadDashboardData() async {
    final User? user = _auth.currentUser;

    if (user == null) {
      if (mounted) {
        setState(() {
          isLoadingStats = false;
        });
      }
      return;
    }

    try {
      // -------------------------------------------------
      // 1. LOAD PROFILE
      // -------------------------------------------------

      final DocumentSnapshot<Map<String, dynamic>> profileSnapshot =
          await _firestore
              .collection('users')
              .doc(user.uid)
              .get();

      final Map<String, dynamic>? profileData = profileSnapshot.data();

      // -------------------------------------------------
      // 2. GET INTERESTED FIELDS
      // -------------------------------------------------

      List<String> interestedFields = [];

      if (profileData != null) {
        // Supports:
        // interestedFields: ["Technology", "Medical"]
        //
        // OR:
        // interestedField: "Technology"

        final dynamic fields = profileData['interestedFields'];

        if (fields is List) {
          interestedFields = fields
              .map(
                (e) => e.toString().trim().toLowerCase(),
              )
              .where((e) => e.isNotEmpty)
              .toList();
        }

        final dynamic singleField = profileData['interestedField'];

        if (singleField is String &&
            singleField.trim().isNotEmpty) {
          interestedFields.add(
            singleField.trim().toLowerCase(),
          );
        }
      }

      // Remove duplicate interests
      interestedFields = interestedFields.toSet().toList();

      // -------------------------------------------------
      // 3. QUIZ ATTEMPTS
      // -------------------------------------------------

      final QuerySnapshot<Map<String, dynamic>> quizSnapshot =
          await _firestore
              .collection('users')
              .doc(user.uid)
              .collection('quizAttempts')
              .get();

      final int fetchedQuizAttempts =
          quizSnapshot.docs.length;

      // -------------------------------------------------
      // 4. SAVED CAREERS
      // -------------------------------------------------

      final QuerySnapshot<Map<String, dynamic>> savedSnapshot =
          await _firestore
              .collection('users')
              .doc(user.uid)
              .collection('savedCareers')
              .get();

      final int fetchedSavedCareers =
          savedSnapshot.docs.length;

      // -------------------------------------------------
      // 5. CAREER BANK
      // -------------------------------------------------

      final QuerySnapshot<Map<String, dynamic>> careerSnapshot =
          await _firestore
              .collection('career_bank')
              .get();

      int fetchedTotalCareers = 0;

      // -------------------------------------------------
      // FILTER CAREERS ACCORDING TO INTEREST
      // -------------------------------------------------

      for (final doc in careerSnapshot.docs) {
        final data = doc.data();

        // Career category
        final dynamic categoryValue = data['category'];

        if (interestedFields.isEmpty) {
          // If user has no interest selected,
          // don't show any filtered count.
          fetchedTotalCareers = 0;
          break;
        }

        bool matchesInterest = false;

        // -------------------------------------------------
        // CATEGORY IS STRING
        // -------------------------------------------------

        if (categoryValue is String) {
          final String category =
              categoryValue.trim().toLowerCase();

          if (interestedFields.contains(category)) {
            matchesInterest = true;
          }
        }

        // -------------------------------------------------
        // CATEGORY IS LIST
        // -------------------------------------------------

        if (categoryValue is List) {
          final List<String> categories = categoryValue
              .map(
                (e) => e.toString().trim().toLowerCase(),
              )
              .toList();

          for (final interest in interestedFields) {
            if (categories.contains(interest)) {
              matchesInterest = true;
              break;
            }
          }
        }

        if (matchesInterest) {
          fetchedTotalCareers++;
        }
      }

      // -------------------------------------------------
      // UPDATE UI
      // -------------------------------------------------

      if (!mounted) return;

      setState(() {
        quizAttemptCount = fetchedQuizAttempts;
        savedCareerCount = fetchedSavedCareers;
        totalCareerCount = fetchedTotalCareers;
        isLoadingStats = false;
      });
    } catch (e) {
      debugPrint(
        'Error loading graduate dashboard data: $e',
      );

      if (!mounted) return;

      setState(() {
        isLoadingStats = false;
      });
    }
  }

  // =====================================================
  // REFRESH
  // =====================================================

  Future<void> _refreshDashboard() async {
    setState(() {
      isLoadingStats = true;
    });

    await _loadDashboardData();
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        title: const Text(
          'PathSeeker',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _refreshDashboard,
            icon: const Icon(Icons.refresh),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),

      drawer: GraduateSidebar(
        onItemSelected: (index) {
          Navigator.pop(context);

          debugPrint(
            'Sidebar item: $index',
          );
        },
      ),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshDashboard,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                // ==========================================
                // WELCOME
                // ==========================================

                const Text(
                  'Good Morning, Graduate 👋',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Continue your career journey and discover opportunities that match your skills.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 24),

                // ==========================================
                // DASHBOARD STATS
                // ==========================================

                _sectionTitle(
                  'Your Progress',
                ),

                const SizedBox(height: 12),

                _statsGrid(),

                const SizedBox(height: 24),

                // ==========================================
                // PROFILE PROGRESS
                // ==========================================

                _sectionTitle(
                  'Profile Progress',
                ),

                const SizedBox(height: 12),

                _profileProgressCard(),

                const SizedBox(height: 24),

                // ==========================================
                // CAREER ASSESSMENT
                // ==========================================

                _sectionTitle(
                  'Career Assessment',
                ),

                const SizedBox(height: 12),

                _careerAssessmentCard(),

                const SizedBox(height: 28),

                // ==========================================
                // TOP PICKS
                // ==========================================

                _sectionTitle(
                  'Top Picks For You',
                  actionText: 'View All',
                  onAction: () {},
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 190,
                  child: ListView(
                    scrollDirection:
                        Axis.horizontal,
                    children: [
                      _careerCard(
                        icon: Icons.code,
                        title: 'Software Engineer',
                        category: 'Technology',
                        match: '88%',
                      ),

                      _careerCard(
                        icon:
                            Icons.analytics_outlined,
                        title: 'Data Scientist',
                        category: 'Technology',
                        match: '83%',
                      ),

                      _careerCard(
                        icon:
                            Icons.security_outlined,
                        title: 'Cyber Security',
                        category: 'Technology',
                        match: '78%',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ==========================================
                // TRENDING CAREERS
                // ==========================================

                _sectionTitle(
                  'Trending Careers',
                  actionText: 'Explore',
                  onAction: () {},
                ),

                const SizedBox(height: 12),

                _trendingCareer(
                  number: '01',
                  title:
                      'AI / Machine Learning Engineer',
                  category: 'Technology',
                  icon:
                      Icons.smart_toy_outlined,
                ),

                _trendingCareer(
                  number: '02',
                  title: 'Cloud Engineer',
                  category: 'Technology',
                  icon: Icons.cloud_outlined,
                ),

                _trendingCareer(
                  number: '03',
                  title: 'Data Scientist',
                  category: 'Technology',
                  icon: Icons.bar_chart_outlined,
                ),

                _trendingCareer(
                  number: '04',
                  title:
                      'Cyber Security Analyst',
                  category: 'Technology',
                  icon: Icons.shield_outlined,
                ),

                const SizedBox(height: 28),

                // ==========================================
                // RECENTLY VIEWED
                // ==========================================

                _sectionTitle(
                  'Recently Viewed',
                  actionText: 'View All',
                  onAction: () {},
                ),

                const SizedBox(height: 12),

                _recentItem(
                  icon: Icons.code,
                  title: 'Software Engineer',
                  subtitle: 'Technology',
                ),

                _recentItem(
                  icon: Icons.data_object,
                  title: 'Data Scientist',
                  subtitle: 'Technology',
                ),

                _recentItem(
                  icon: Icons.security,
                  title:
                      'Cyber Security Analyst',
                  subtitle: 'Technology',
                ),

                const SizedBox(height: 28),

                // ==========================================
                // RECOMMENDED LEARNING
                // ==========================================

                _sectionTitle(
                  'Recommended Learning',
                  actionText: 'View All',
                  onAction: () {},
                ),

                const SizedBox(height: 12),

                _learningCard(
                  icon:
                      Icons.play_circle_outline,
                  title:
                      'Introduction to Data Science',
                  subtitle: 'Video • 12 min',
                ),

                _learningCard(
                  icon:
                      Icons.picture_as_pdf_outlined,
                  title:
                      'Roadmap to Software Engineering',
                  subtitle: 'PDF • Beginner',
                ),

                _learningCard(
                  icon:
                      Icons.play_circle_outline,
                  title:
                      'Cyber Security Fundamentals',
                  subtitle: 'Video • 18 min',
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // STATS GRID
  // =====================================================

  Widget _statsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.65,
      children: [
        _statCard(
          icon: Icons.quiz_outlined,
          title: 'Quiz Attempts',
          value: quizAttemptCount.toString(),
          iconColor: Colors.blue,
        ),

        _statCard(
          icon: Icons.work_outline,
          title: 'Career Matches',
          value: totalCareerCount.toString(),
          iconColor: Colors.deepPurple,
        ),

        _statCard(
          icon: Icons.bookmark_outline,
          title: 'Saved Careers',
          value: savedCareerCount.toString(),
          iconColor: Colors.orange,
        ),

        _statCard(
          icon: Icons.explore_outlined,
          title: 'Career Bank',
          value: totalCareerCount.toString(),
          iconColor: Colors.green,
        ),
      ],
    );
  }

  // =====================================================
  // STAT CARD
  // =====================================================

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.035),
            blurRadius: 12,
            offset:
                const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  iconColor.withOpacity(0.10),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 23,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                if (isLoadingStats)
                  Container(
                    width: 35,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          BorderRadius.circular(5),
                    ),
                  )
                else
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Color(0xFF172033),
                    ),
                  ),

                const SizedBox(height: 3),

                Text(
                  title,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color:
                        Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // SECTION TITLE
  // =====================================================

  Widget _sectionTitle(
    String title, {
    String? actionText,
    VoidCallback? onAction,
  }) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Color(0xFF172033),
          ),
        ),

        if (actionText != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              actionText,
              style: const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  // =====================================================
  // PROFILE PROGRESS
  // =====================================================

  Widget _profileProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset:
                const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: Stack(
                  alignment:
                      Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 0.80,
                      strokeWidth: 7,
                      backgroundColor:
                          Colors.grey.shade200,
                      color: Colors.blue,
                    ),

                    const Text(
                      '80%',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 18),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete your profile',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      'A complete profile helps us provide better career recommendations.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              _checkItem(
                'Education',
                true,
              ),
              _checkItem(
                'Skills',
                true,
              ),
              _checkItem(
                'Interests',
                true,
              ),
              _checkItem(
                'Resume',
                false,
              ),
            ],
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text(
                'Complete Profile',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkItem(
    String title,
    bool completed,
  ) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            completed
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            size: 16,
            color: completed
                ? Colors.green
                : Colors.grey,
          ),

          const SizedBox(width: 4),

          Flexible(
            child: Text(
              title,
              style:
                  const TextStyle(
                fontSize: 11,
              ),
              overflow:
                  TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // CAREER ASSESSMENT
  // =====================================================

  Widget _careerAssessmentCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2563EB),
            Color(0xFF4F46E5),
          ],
        ),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.psychology_outlined,
            color: Colors.white,
            size: 35,
          ),

          const SizedBox(height: 15),

          const Text(
            'Discover Your Career Path',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Take our interest assessment and discover career fields that match your skills and interests.',
            style: TextStyle(
              color: Colors.white70,
              height: 1.5,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 18),

          ElevatedButton(
            onPressed: () {},
            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.white,
              foregroundColor:
                  Colors.blue,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
            ),
            child: const Text(
              'Take Career Quiz',
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // CAREER CARD
  // =====================================================

  Widget _careerCard({
    required IconData icon,
    required String title,
    required String category,
    required String match,
  }) {
    return Container(
      width: 220,
      margin:
          const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.blue,
                ),
              ),

              const Spacer(),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(
                  '$match Match',
                  style: TextStyle(
                    color:
                        Colors.green.shade700,
                    fontSize: 11,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            category,
            style: TextStyle(
              color:
                  Colors.grey.shade600,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Explore Career →',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // TRENDING CAREER
  // =====================================================

  Widget _trendingCareer({
    required String number,
    required String title,
    required String category,
    required IconData icon,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text(
            number,
            style: TextStyle(
              color:
                  Colors.grey.shade400,
              fontWeight:
                  FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(width: 15),

          Container(
            padding:
                const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 20,
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
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  category,
                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  // =====================================================
  // RECENTLY VIEWED
  // =====================================================

  Widget _recentItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color:
                  Colors.grey.shade100,
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.blueGrey,
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
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  // =====================================================
  // LEARNING CARD
  // =====================================================

  Widget _learningCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 25,
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
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}