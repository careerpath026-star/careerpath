// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'firebase_options.dart';
// import 'screens/auth/login_screen.dart';
// import 'screens/main_wrapper.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'PathSeeker',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
//         useMaterial3: true,
//       ),
//       home: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }

//           if (snapshot.hasData && snapshot.data != null) {
//             return FutureBuilder<DocumentSnapshot>(
//               future: FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(snapshot.data!.uid)
//                   .get(),
//               builder: (context, userSnapshot) {
//                 if (userSnapshot.connectionState == ConnectionState.waiting) {
//                   return const Scaffold(
//                     body: Center(child: CircularProgressIndicator()),
//                   );
//                 }

//                 if (userSnapshot.hasData && userSnapshot.data!.exists) {
//                   Map<String, dynamic> userData =
//                       userSnapshot.data!.data() as Map<String, dynamic>;

//                   return MainWrapper(userData: userData);
//                 }

//                 return const LoginScreen();
//               },
//             );
//           }

//           return const LoginScreen();
//         },
//       ),
//     );
//   }
// }









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