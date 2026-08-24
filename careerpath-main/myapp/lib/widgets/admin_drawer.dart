// lib/widgets/admin_drawer.dart
//
// Use ONLY inside AdminDashboard. Regular users get AppDrawer instead.
//
// Usage inside AdminDashboard's Scaffold:
//
//   Scaffold(
//     appBar: AppBar(title: const Text('Admin Dashboard')),
//     drawer: const AdminDrawer(),
//     body: ...
//   )

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/AdminDashboard/manage_careers_screen.dart';
import '../screens/AdminDashboard/manage_feedback_screen.dart';
import '../screens/auth/login_screen.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ---- Header ----
          UserAccountsDrawerHeader(
            accountName: const Text('PathSeeker Admin'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.admin_panel_settings, size: 32),
            ),
            decoration: const BoxDecoration(color: Colors.deepPurple),
          ),

          // ---- Manage Careers ----
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Manage Careers'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ManageCareersScreen()),
              );
            },
          ),

          // ---- Manage Feedback ----
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: const Text('User Feedback'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ManageFeedbackScreen()),
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