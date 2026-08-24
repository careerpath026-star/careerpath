import 'seed_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await seedData();   // 👈 ONE TIME ONLY — run ke baad is line ko comment kar dena!

  runApp(const PathSeekerApp());
}

class PathSeekerApp extends StatelessWidget {
  const PathSeekerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'PathSeeker',

      theme: AppTheme.lightTheme,

      home: const SplashScreen(),
    );
  }
}



// muhammadwasaysiddiqui05@gmail.com (wasaysidd123)=>professional
// careerpath026@gmail.com (careerpath123)=> graduate
// abdulwasaysiddiqui20@gmail.com (wasay123)=>student
// sheikhaamina27@gmail.com (aamna123)=>admin