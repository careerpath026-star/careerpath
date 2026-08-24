import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../auth/user_type_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  Future<void> registerUser() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showMessage('Please fill all fields.');
      return;
    }

    if (password.length < 6) {
      showMessage('Password must be at least 6 characters.');
      return;
    }

    if (password != confirmPassword) {
      showMessage('Passwords do not match.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Firebase Authentication
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = credential.user;

      if (user == null) {
        showMessage('Registration failed.');
        return;
      }

      // Update Firebase Auth display name
      await user.updateDisplayName(name);

      // Firestore database
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'name': name,
        'email': email,
        'userType': null,
        'education': '',
        'skills': [],
        'interests': [],
        'workExperience': '',
        'profileImage': '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Firebase email verification
      await user.sendEmailVerification();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => UserTypeScreen(
            uid: user.uid,
            name: name,
            email: email,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Registration failed.';

      if (e.code == 'email-already-in-use') {
        message = 'This email is already registered.';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email.';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak.';
      }

      showMessage(message);
    } catch (e) {
      showMessage('Something went wrong. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              const Text(
                'Start Your Journey 🚀',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Create your PathSeeker account.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword =
                            !obscureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : registerUser,
                  child: isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}












// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../../core/constants/app_colors.dart';
// import 'verify_email_screen.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   bool isLoading = false;
//   bool obscurePassword = true;
//   bool obscureConfirmPassword = true;

//   Future<void> registerUser() async {
//     final name = nameController.text.trim();
//     final email = emailController.text.trim().toLowerCase();
//     final password = passwordController.text;
//     final confirmPassword = confirmPasswordController.text;

//     // Validation
//     if (name.isEmpty ||
//         email.isEmpty ||
//         password.isEmpty ||
//         confirmPassword.isEmpty) {
//       showMessage("Please fill all fields.");
//       return;
//     }

//     if (password.length < 6) {
//       showMessage("Password must be at least 6 characters.");
//       return;
//     }

//     if (password != confirmPassword) {
//       showMessage("Passwords do not match.");
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       // =========================================================
//       // 1. CREATE FIREBASE AUTH ACCOUNT
//       // =========================================================

//       final UserCredential credential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       final User? user = credential.user;

//       if (user == null) {
//         showMessage("User creation failed.");
//         return;
//       }

//       // Save name in Firebase Authentication
//       await user.updateDisplayName(name);

//       // =========================================================
//       // 2. CREATE USER DOCUMENT IN FIRESTORE
//       // =========================================================

//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(user.uid)
//           .set({
//         "uid": user.uid,
//         "name": name,
//         "email": email,
//         "userType": null,
//         "education": "",
//         "skills": [],
//         "interests": [],
//         "workExperience": "",
//         "profileImage": "",
//         "emailVerified": false,
//         "createdAt": FieldValue.serverTimestamp(),
//         "updatedAt": FieldValue.serverTimestamp(),
//       });

//       // =========================================================
//       // 3. CALL FIREBASE CLOUD FUNCTION
//       // =========================================================

//       final HttpsCallable sendOtp =
//           FirebaseFunctions.instance.httpsCallable("sendEmailOtp");

//       await sendOtp.call({
//         "email": email,
//       });

//       // =========================================================
//       // 4. OPEN OTP / VERIFICATION SCREEN
//       // =========================================================

//       if (!mounted) return;

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => VerifyEmailScreen(
//             email: email,
//             // uid: user.uid,
//           ),
//         ),
//       );
//     }

//     // =========================================================
//     // FIREBASE AUTH ERRORS
//     // =========================================================

//     on FirebaseAuthException catch (e) {
//       String message = "Registration failed.";

//       if (e.code == "email-already-in-use") {
//         message = "This email is already registered.";
//       } else if (e.code == "invalid-email") {
//         message = "Please enter a valid email.";
//       } else if (e.code == "weak-password") {
//         message = "Password is too weak.";
//       } else if (e.code == "network-request-failed") {
//         message = "Please check your internet connection.";
//       } else {
//         message = e.message ?? "Registration failed.";
//       }

//       showMessage(message);
//     }

//     // =========================================================
//     // CLOUD FUNCTION ERRORS
//     // =========================================================

//     on FirebaseFunctionsException catch (e) {
//       String message = "Unable to send OTP.";

//       if (e.code == "not-found") {
//         message = "OTP service is not available.";
//       } else if (e.code == "permission-denied") {
//         message = "Permission denied.";
//       } else if (e.code == "unauthenticated") {
//         message = "Authentication required.";
//       } else if (e.message != null) {
//         message = e.message!;
//       }

//       showMessage(message);
//     }

//     // =========================================================
//     // OTHER ERRORS
//     // =========================================================

//     catch (e) {
//       showMessage("Something went wrong: $e");
//     }

//     finally {
//       if (mounted) {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }

//   void showMessage(String message) {
//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Create Account"),
//       ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 15),

//               const Text(
//                 "Create Your Account",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimary,
//                 ),
//               ),

//               const SizedBox(height: 8),

//               const Text(
//                 "Enter your details to start your career journey.",
//                 style: TextStyle(
//                   color: AppColors.textSecondary,
//                   fontSize: 15,
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // NAME
//               TextField(
//                 controller: nameController,
//                 textInputAction: TextInputAction.next,
//                 decoration: const InputDecoration(
//                   labelText: "Full Name",
//                   hintText: "Enter your full name",
//                   prefixIcon: Icon(Icons.person_outline),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // EMAIL
//               TextField(
//                 controller: emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 textInputAction: TextInputAction.next,
//                 decoration: const InputDecoration(
//                   labelText: "Email",
//                   hintText: "Enter your email",
//                   prefixIcon: Icon(Icons.email_outlined),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // PASSWORD
//               TextField(
//                 controller: passwordController,
//                 obscureText: obscurePassword,
//                 textInputAction: TextInputAction.next,
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   hintText: "Minimum 6 characters",
//                   prefixIcon: const Icon(Icons.lock_outline),

//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       obscurePassword
//                           ? Icons.visibility_outlined
//                           : Icons.visibility_off_outlined,
//                     ),

//                     onPressed: () {
//                       setState(() {
//                         obscurePassword = !obscurePassword;
//                       });
//                     },
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // CONFIRM PASSWORD
//               TextField(
//                 controller: confirmPasswordController,
//                 obscureText: obscureConfirmPassword,
//                 textInputAction: TextInputAction.done,
//                 decoration: InputDecoration(
//                   labelText: "Confirm Password",
//                   hintText: "Enter password again",
//                   prefixIcon: const Icon(Icons.lock_outline),

//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       obscureConfirmPassword
//                           ? Icons.visibility_outlined
//                           : Icons.visibility_off_outlined,
//                     ),

//                     onPressed: () {
//                       setState(() {
//                         obscureConfirmPassword =
//                             !obscureConfirmPassword;
//                       });
//                     },
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // REGISTER BUTTON
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,

//                 child: ElevatedButton(
//                   onPressed: isLoading ? null : registerUser,

//                   child: isLoading
//                       ? const SizedBox(
//                           height: 23,
//                           width: 23,

//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         )

//                       : const Text(
//                           "Create Account",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               const Center(
//                 child: Text(
//                   "A 6-digit verification code will be sent to your email.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: AppColors.textSecondary,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }