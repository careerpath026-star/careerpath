// lib/widgets/app_drawer.dart
//
// Reusable drawer — use the SAME drawer in all 4 dashboards.
// Usage inside any dashboard's Scaffold:
//
//   Scaffold(
//     appBar: AppBar(title: const Text('Dashboard')),
//     drawer: const AppDrawer(),
//     body: ...
//   )

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/CareerBank/career_bank_screen.dart';
import '../screens/Quiz/quiz_screen.dart';
import '../screens/Resources/resource_library_screen.dart';
import '../screens/SuccessStories/success_stories_screen.dart';
import '../screens/auth/login_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ---- Header ----
          UserAccountsDrawerHeader(
            accountName: const Text('PathSeeker'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person, size: 32),
            ),
            decoration: const BoxDecoration(color: Colors.indigo),
          ),

          // ---- Career Bank ----
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Career Bank'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CareerBankScreen()),
              );
            },
          ),

          // ---- Interest Quiz ----
          ListTile(
            leading: const Icon(Icons.quiz_outlined),
            title: const Text('Interest Quiz'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QuizScreen()),
              );
            },
          ),

          // ---- Resource Library ----
          ListTile(
            leading: const Icon(Icons.library_books_outlined),
            title: const Text('Resource Library'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ResourceLibraryScreen()),
              );
            },
          ),

          // ---- Success Stories ----
          ListTile(
            leading: const Icon(Icons.emoji_events_outlined),
            title: const Text('Success Stories'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const SuccessStoriesScreen()),
              );
            },
          ),

          const Divider(),

          // ---- Logout ----
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}