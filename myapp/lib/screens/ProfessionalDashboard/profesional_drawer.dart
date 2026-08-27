
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/career_bank_screen.dart';
import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/feedback_analytics_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/professional_dashboard.dart';
import 'package:myapp/screens/ProfessionalDashboard/success_stories_page.dart';


class NavigationDrawerHolder extends StatefulWidget {
  final String userId;
  const NavigationDrawerHolder({Key? key, required this.userId}) : super(key: key);

  @override
  State<NavigationDrawerHolder> createState() => _NavigationDrawerHolderState();
}

class _NavigationDrawerHolderState extends State<NavigationDrawerHolder> {
  int _currentIndex = 0;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  late final List<Widget> _pages;

  final List<String> _pageTitles = [
    'Personalized Dashboard',
    'Career Bank',
    'AI Interest Quiz',
    'Multimedia Center',
    'Success Stories Hub',
    'Document Library',
    'Saved Bookmarks & Notes',
    'Feedback & Analytics',
  ];

  @override
  void initState() {
    super.initState();
    _pages = [
      PersonalizedDashboardPage(userId: widget.userId),
      CareerBankPage(userId: widget.userId),
      InterestQuizPage(userId: widget.userId),
      MultimediaCenterPage(userId: widget.userId),
      SuccessStoriesPage(userId: widget.userId),
      DocumentLibraryPage(userId: widget.userId),
      BookmarksNotesPage(userId: widget.userId),
      FeedbackAnalyticsPage(userId: widget.userId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFE0F2F1), // Soft Light Mint Teal
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00796B),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _pageTitles[_currentIndex],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        // Drawer Navigation Menu
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Dynamic Header fetching user profile info from Firestore DB
              StreamBuilder<DocumentSnapshot>(
                stream: _db.collection('users').doc(widget.userId).snapshots(),
                builder: (context, snapshot) {
                  String name = 'PathSeeker User';
                  String email = 'user@pathseeker.com';
                  String role = 'Student';

                  if (snapshot.hasData && snapshot.data!.exists) {
                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    name = data['uname'] ?? name;
                    email = data['email'] ?? email;
                    role = data['role'] ?? role;
                  }

                  return UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF00796B), Color(0xFF26A69A)],
                      ),
                    ),
                    accountName: Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    accountEmail: Text('$email | Stage: $role'),
                    currentAccountPicture: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Color(0xFF00796B), size: 40),
                    ),
                  );
                },
              ),

              // Drawer Navigation Items
              _buildDrawerItem(0, Icons.dashboard_outlined, 'Personalized Dashboard'),
              _buildDrawerItem(1, Icons.work_outline, 'Career Bank'),
              _buildDrawerItem(2, Icons.quiz_outlined, 'AI Interest Quiz'),
              _buildDrawerItem(3, Icons.play_circle_outline, 'Multimedia Center'),
              _buildDrawerItem(4, Icons.stars_outlined, 'Success Stories Hub'),
              _buildDrawerItem(5, Icons.folder_open_outlined, 'Document Library'),
              _buildDrawerItem(6, Icons.bookmark_outline, 'Bookmarks & Notes'),
              _buildDrawerItem(7, Icons.feedback_outlined, 'Feedback & Analytics'),

              const Divider(color: Color(0xFFB2DFDB)),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(int index, IconData icon, String title) {
    bool isSelected = _currentIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? const Color(0xFF00796B) : const Color(0xFF78909C),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFF00796B) : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: const Color(0xFFE0F2F1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        Navigator.pop(context); // Close drawer after selection
      },
    );
  }
}