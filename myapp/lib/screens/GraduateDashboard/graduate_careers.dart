// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class GraduateCareerBank extends StatefulWidget {
//   const GraduateCareerBank({super.key});

//   @override
//   State<GraduateCareerBank> createState() =>
//       _GraduateCareerBankState();
// }

// class _GraduateCareerBankState extends State<GraduateCareerBank> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore =
//       FirebaseFirestore.instance;

//   bool isLoading = true;

//   String interestField = "";
//   String userName = "Graduate";

//   List<Map<String, dynamic>> careers = [];

//   // ==========================================================
//   // INIT
//   // ==========================================================

//   @override
//   void initState() {
//     super.initState();
//     loadCareerBank();
//   }

//   // ==========================================================
//   // LOAD USER + CAREERS
//   // ==========================================================

//   Future<void> loadCareerBank() async {
//     try {
//       final User? user = _auth.currentUser;

//       if (user == null) {
//         setState(() {
//           isLoading = false;
//         });
//         return;
//       }

//       // --------------------------------------------------------
//       // GET USER PROFILE
//       // --------------------------------------------------------

//       final userSnapshot = await _firestore
//           .collection("users")
//           .doc(user.uid)
//           .get();

//       if (userSnapshot.exists) {
//         final userData =
//             userSnapshot.data() as Map<String, dynamic>;

//         userName =
//             userData["name"]?.toString().trim().isNotEmpty == true
//                 ? userData["name"].toString().trim()
//                 : "Graduate";

//         interestField =
//             userData["interest_field"]
//                     ?.toString()
//                     .trim()
//                     .toLowerCase() ??
//                 "";
//       }

//       // --------------------------------------------------------
//       // GET CAREERS
//       // --------------------------------------------------------

//       if (interestField.isEmpty) {
//         setState(() {
//           careers = [];
//           isLoading = false;
//         });
//         return;
//       }

//       final QuerySnapshot careerSnapshot =
//           await _firestore
//               .collection("career_bank")
//               .where(
//                 "role",
//                 isEqualTo: "graduate",
//               )
//               .where(
//                 "category",
//                 isEqualTo: interestField,
//               )
//               .get();

//       final List<Map<String, dynamic>> loadedCareers = [];

//       for (final doc in careerSnapshot.docs) {
//         final data =
//             doc.data() as Map<String, dynamic>;

//         loadedCareers.add({
//           "id": doc.id,
//           ...data,
//         });
//       }

//       // --------------------------------------------------------
//       // SORT BY CAREER NAME
//       // --------------------------------------------------------

//       loadedCareers.sort(
//         (a, b) => (a["careerName"] ?? "")
//             .toString()
//             .compareTo(
//               (b["careerName"] ?? "").toString(),
//             ),
//       );

//       if (!mounted) return;

//       setState(() {
//         careers = loadedCareers;
//         isLoading = false;
//       });
//     } catch (e) {
//       debugPrint(
//         "Career Bank Error: $e",
//       );

//       if (!mounted) return;

//       setState(() {
//         isLoading = false;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Unable to load career bank.",
//           ),
//         ),
//       );
//     }
//   }

//   // ==========================================================
//   // SAVE CAREER
//   // ==========================================================

//   Future<void> toggleSaveCareer(
//     Map<String, dynamic> career,
//   ) async {
//     final User? user = _auth.currentUser;

//     if (user == null) return;

//     final String careerId =
//         career["id"].toString();

//     final DocumentReference savedRef =
//         _firestore
//             .collection("users")
//             .doc(user.uid)
//             .collection("savedCareers")
//             .doc(careerId);

//     try {
//       final savedSnapshot =
//           await savedRef.get();

//       if (savedSnapshot.exists) {
//         // ======================================================
//         // REMOVE FROM SAVED
//         // ======================================================

//         await savedRef.delete();

//         if (!mounted) return;

//         setState(() {
//           career["_saved"] = false;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               "Career removed from saved careers.",
//             ),
//             duration: Duration(seconds: 1),
//           ),
//         );
//       } else {
//         // ======================================================
//         // SAVE CAREER
//         // ======================================================

//         await savedRef.set({
//           "careerId": careerId,
//           "careerName":
//               career["careerName"] ?? "",
//           "category":
//               career["category"] ?? "",
//           "role":
//               career["role"] ?? "graduate",
//           "description":
//               career["description"] ?? "",
//           "savedAt":
//               FieldValue.serverTimestamp(),
//         });

//         if (!mounted) return;

//         setState(() {
//           career["_saved"] = true;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               "Career saved successfully.",
//             ),
//             duration: Duration(seconds: 1),
//           ),
//         );
//       }
//     } catch (e) {
//       debugPrint(
//         "Save career error: $e",
//       );

//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Could not update saved career.",
//           ),
//         ),
//       );
//     }
//   }

//   // ==========================================================
//   // CHECK SAVED CAREERS
//   // ==========================================================

//   Future<void> loadSavedStatus() async {
//     final User? user = _auth.currentUser;

//     if (user == null || careers.isEmpty) {
//       return;
//     }

//     try {
//       final savedSnapshot =
//           await _firestore
//               .collection("users")
//               .doc(user.uid)
//               .collection("savedCareers")
//               .get();

//       final Set<String> savedIds =
//           savedSnapshot.docs
//               .map((doc) => doc.id)
//               .toSet();

//       if (!mounted) return;

//       setState(() {
//         for (final career in careers) {
//           career["_saved"] =
//               savedIds.contains(
//             career["id"].toString(),
//           );
//         }
//       });
//     } catch (e) {
//       debugPrint(
//         "Saved status error: $e",
//       );
//     }
//   }

//   // ==========================================================
//   // FORMAT CATEGORY
//   // ==========================================================

//   String formatCategory(String category) {
//     switch (category.toLowerCase()) {
//       case "computer":
//         return "Computer Science";

//       case "medical":
//         return "Medical & Healthcare";

//       case "engineering":
//         return "Engineering";

//       default:
//         return category;
//     }
//   }

//   // ==========================================================
//   // CATEGORY ICON
//   // ==========================================================

//   IconData categoryIcon(String category) {
//     switch (category.toLowerCase()) {
//       case "computer":
//         return Icons.computer_outlined;

//       case "medical":
//         return Icons.medical_services_outlined;

//       case "engineering":
//         return Icons.engineering_outlined;

//       default:
//         return Icons.work_outline;
//     }
//   }

//   // ==========================================================
//   // BUILD
//   // ==========================================================

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           const Color(0xFF0B1220),

//       appBar: AppBar(
//         backgroundColor:
//             const Color(0xFF0B1220),

//         elevation: 0,

//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),

//         title: const Text(
//           "Career Bank",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),

//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(
//                 color: Color(0xFF00C2FF),
//               ),
//             )
//           : RefreshIndicator(
//               color: const Color(0xFF00C2FF),

//               onRefresh: () async {
//                 await loadCareerBank();
//                 await loadSavedStatus();
//               },

//               child: careers.isEmpty
//                   ? _emptyCareerBank()
//                   : ListView(
//                       padding:
//                           const EdgeInsets.all(18),

//                       children: [
//                         _buildHeader(),

//                         const SizedBox(
//                           height: 20,
//                         ),

//                         ...careers.map(
//                           (career) =>
//                               _careerCard(career),
//                         ),

//                         const SizedBox(
//                           height: 20,
//                         ),
//                       ],
//                     ),
//             ),
//     );
//   }

//   // ==========================================================
//   // HEADER
//   // ==========================================================

//   Widget _buildHeader() {
//     return Container(
//       width: double.infinity,

//       padding:
//           const EdgeInsets.all(22),

//       decoration: BoxDecoration(
//         gradient:
//             const LinearGradient(
//           colors: [
//             Color(0xFF3654E0),
//             Color(0xFF6278E8),
//           ],

//           begin:
//               Alignment.topLeft,

//           end:
//               Alignment.bottomRight,
//         ),

//         borderRadius:
//             BorderRadius.circular(22),
//       ),

//       child: Column(
//         crossAxisAlignment:
//             CrossAxisAlignment.start,

//         children: [
//           Container(
//             height: 52,
//             width: 52,

//             decoration: BoxDecoration(
//               color: Colors.white
//                   .withOpacity(0.16),

//               borderRadius:
//                   BorderRadius.circular(15),
//             ),

//             child: Icon(
//               categoryIcon(
//                 interestField,
//               ),
//               color: Colors.white,
//               size: 28,
//             ),
//           ),

//           const SizedBox(height: 15),

//           Text(
//             "Career Bank",
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 6),

//           Text(
//             "Career options for $userName",
//             style: const TextStyle(
//               color: Colors.white70,
//               fontSize: 13,
//             ),
//           ),

//           const SizedBox(height: 15),

//           Container(
//             padding:
//                 const EdgeInsets.symmetric(
//               horizontal: 12,
//               vertical: 7,
//             ),

//             decoration: BoxDecoration(
//               color: Colors.white
//                   .withOpacity(0.14),

//               borderRadius:
//                   BorderRadius.circular(20),
//             ),

//             child: Text(
//               formatCategory(
//                 interestField,
//               ),
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ==========================================================
//   // CAREER CARD
//   // ==========================================================

//   Widget _careerCard(
//     Map<String, dynamic> career,
//   ) {
//     final String careerName =
//         career["careerName"]
//                 ?.toString()
//                 .trim()
//                 .isNotEmpty ==
//             true
//             ? career["careerName"].toString()
//             : "Career";

//     final String description =
//         career["description"]
//                 ?.toString()
//                 .trim()
//                 .isNotEmpty ==
//             true
//             ? career["description"].toString()
//             : "Explore this career path and learn more about its opportunities.";

//     final bool saved =
//         career["_saved"] == true;

//     return Container(
//       margin:
//           const EdgeInsets.only(bottom: 14),

//       decoration: BoxDecoration(
//         color:
//             const Color(0xFF151F32),

//         borderRadius:
//             BorderRadius.circular(18),

//         border: Border.all(
//           color: saved
//               ? const Color(0xFF00C2FF)
//                   .withOpacity(0.35)
//               : Colors.white10,
//         ),
//       ),

//       child: InkWell(
//         borderRadius:
//             BorderRadius.circular(18),

//         onTap: () {
//           _showCareerDetails(
//             career,
//           );
//         },

//         child: Padding(
//           padding:
//               const EdgeInsets.all(17),

//           child: Column(
//             crossAxisAlignment:
//                 CrossAxisAlignment.start,

//             children: [
//               Row(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,

//                 children: [
//                   Container(
//                     height: 52,
//                     width: 52,

//                     decoration: BoxDecoration(
//                       color:
//                           const Color(
//                         0xFF00C2FF,
//                       ).withOpacity(0.10),

//                       borderRadius:
//                           BorderRadius.circular(
//                               14),
//                     ),

//                     child: Icon(
//                       categoryIcon(
//                         interestField,
//                       ),

//                       color:
//                           const Color(
//                         0xFF00C2FF,
//                       ),

//                       size: 27,
//                     ),
//                   ),

//                   const SizedBox(
//                     width: 13,
//                   ),

//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment:
//                           CrossAxisAlignment
//                               .start,

//                       children: [
//                         Text(
//                           careerName,

//                           style:
//                               const TextStyle(
//                             color:
//                                 Colors.white,

//                             fontSize:
//                                 16,

//                             fontWeight:
//                                 FontWeight.bold,
//                           ),
//                         ),

//                         const SizedBox(
//                           height: 5,
//                         ),

//                         Text(
//                           "Graduate Career",

//                           style:
//                               const TextStyle(
//                             color:
//                                 Color(
//                               0xFF00C2FF,
//                             ),

//                             fontSize:
//                                 11,

//                             fontWeight:
//                                 FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // =================================================
//                   // WORKING SAVE ICON
//                   // =================================================

//                   IconButton(
//                     tooltip: saved
//                         ? "Remove from saved"
//                         : "Save career",

//                     onPressed: () {
//                       toggleSaveCareer(
//                         career,
//                       );
//                     },

//                     icon: Icon(
//                       saved
//                           ? Icons.bookmark
//                           : Icons.bookmark_border,

//                       color: saved
//                           ? const Color(
//                               0xFF00C2FF,
//                             )
//                           : Colors.white54,

//                       size: 27,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(
//                 height: 15,
//               ),

//               Text(
//                 description,

//                 maxLines: 3,

//                 overflow:
//                     TextOverflow.ellipsis,

//                 style:
//                     const TextStyle(
//                   color:
//                       Colors.white60,

//                   fontSize:
//                       13,

//                   height:
//                       1.5,
//                 ),
//               ),

//               const SizedBox(
//                 height: 14,
//               ),

//               Row(
//                 children: [
//                   _smallTag(
//                     Icons.school_outlined,
//                     "Post-Graduation",
//                   ),

//                   const SizedBox(
//                     width: 8,
//                   ),

//                   _smallTag(
//                     Icons.category_outlined,
//                     formatCategory(
//                       interestField,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(
//                 height: 10,
//               ),

//               const Row(
//                 mainAxisAlignment:
//                     MainAxisAlignment.end,

//                 children: [
//                   Text(
//                     "View Details",
//                     style: TextStyle(
//                       color:
//                           Color(0xFF00C2FF),
//                       fontSize: 12,
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),

//                   SizedBox(
//                     width: 4,
//                   ),

//                   Icon(
//                     Icons.arrow_forward_ios,
//                     color:
//                         Color(0xFF00C2FF),
//                     size: 12,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ==========================================================
//   // SMALL TAG
//   // ==========================================================

//   Widget _smallTag(
//     IconData icon,
//     String text,
//   ) {
//     return Container(
//       padding:
//           const EdgeInsets.symmetric(
//         horizontal: 9,
//         vertical: 6,
//       ),

//       decoration: BoxDecoration(
//         color: Colors.white
//             .withOpacity(0.05),

//         borderRadius:
//             BorderRadius.circular(8),
//       ),

//       child: Row(
//         mainAxisSize:
//             MainAxisSize.min,

//         children: [
//           Icon(
//             icon,
//             color: Colors.white38,
//             size: 13,
//           ),

//           const SizedBox(
//             width: 5,
//           ),

//           Text(
//             text,
//             style:
//                 const TextStyle(
//               color:
//                   Colors.white54,
//               fontSize:
//                   10,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ==========================================================
//   // CAREER DETAILS
//   // ==========================================================

//   void _showCareerDetails(
//     Map<String, dynamic> career,
//   ) {
//     final String careerName =
//         career["careerName"]
//                 ?.toString() ??
//             "Career";

//     final String description =
//         career["description"]
//                 ?.toString() ??
//             "No description available.";

//     final bool saved =
//         career["_saved"] == true;

//     showModalBottomSheet(
//       context: context,

//       backgroundColor:
//           const Color(0xFF151F32),

//       isScrollControlled: true,

//       shape:
//           const RoundedRectangleBorder(
//         borderRadius:
//             BorderRadius.vertical(
//           top: Radius.circular(25),
//         ),
//       ),

//       builder: (context) {
//         return SafeArea(
//           child: SingleChildScrollView(
//             padding:
//                 const EdgeInsets.all(22),

//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,

//               children: [
//                 Center(
//                   child: Container(
//                     height: 5,
//                     width: 45,

//                     decoration:
//                         BoxDecoration(
//                       color: Colors.white24,
//                       borderRadius:
//                           BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 22,
//                 ),

//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         careerName,
//                         style:
//                             const TextStyle(
//                           color:
//                               Colors.white,
//                           fontSize:
//                               22,
//                           fontWeight:
//                               FontWeight.bold,
//                         ),
//                       ),
//                     ),

//                     IconButton(
//                       onPressed: () {
//                         toggleSaveCareer(
//                           career,
//                         );

//                         Navigator.pop(
//                           context,
//                         );
//                       },

//                       icon: Icon(
//                         saved
//                             ? Icons.bookmark
//                             : Icons.bookmark_border,

//                         color:
//                             const Color(
//                           0xFF00C2FF,
//                         ),

//                         size: 29,
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(
//                   height: 8,
//                 ),

//                 Text(
//                   "Graduate • ${formatCategory(interestField)}",

//                   style:
//                       const TextStyle(
//                     color:
//                         Color(0xFF00C2FF),
//                     fontSize:
//                         12,
//                     fontWeight:
//                         FontWeight.w600,
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 22,
//                 ),

//                 const Text(
//                   "Career Description",

//                   style:
//                       TextStyle(
//                     color:
//                         Colors.white,
//                     fontSize:
//                         17,
//                     fontWeight:
//                         FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 9,
//                 ),

//                 Text(
//                   description,

//                   style:
//                       const TextStyle(
//                     color:
//                         Colors.white60,
//                     fontSize:
//                         14,
//                     height:
//                         1.6,
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 25,
//                 ),

//                 _detailRow(
//                   Icons.school_outlined,
//                   "Level",
//                   "Post-Graduation",
//                 ),

//                 _detailRow(
//                   Icons.category_outlined,
//                   "Category",
//                   formatCategory(
//                     interestField,
//                   ),
//                 ),

//                 _detailRow(
//                   Icons.person_outline,
//                   "Role",
//                   "Graduate",
//                 ),

//                 const SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // ==========================================================
//   // DETAIL ROW
//   // ==========================================================

//   Widget _detailRow(
//     IconData icon,
//     String title,
//     String value,
//   ) {
//     return Container(
//       margin:
//           const EdgeInsets.only(
//         bottom: 10,
//       ),

//       padding:
//           const EdgeInsets.all(13),

//       decoration: BoxDecoration(
//         color:
//             const Color(0xFF0B1220),

//         borderRadius:
//             BorderRadius.circular(12),
//       ),

//       child: Row(
//         children: [
//           Icon(
//             icon,
//             color:
//                 const Color(0xFF00C2FF),
//             size: 20,
//           ),

//           const SizedBox(
//             width: 12,
//           ),

//           Text(
//             "$title: ",
//             style:
//                 const TextStyle(
//               color:
//                   Colors.white54,
//               fontSize:
//                   13,
//             ),
//           ),

//           Expanded(
//             child: Text(
//               value,
//               style:
//                   const TextStyle(
//                 color:
//                     Colors.white,
//                 fontSize:
//                     13,
//                 fontWeight:
//                     FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ==========================================================
//   // EMPTY CAREER BANK
//   // ==========================================================

//   Widget _emptyCareerBank() {
//     return ListView(
//       padding:
//           const EdgeInsets.all(20),

//       children: [
//         const SizedBox(
//           height: 80,
//         ),

//         Icon(
//           interestField.isEmpty
//               ? Icons.explore_off_outlined
//               : Icons.work_off_outlined,

//           color:
//               Colors.white24,

//           size: 70,
//         ),

//         const SizedBox(
//           height: 20,
//         ),

//         Text(
//           interestField.isEmpty
//               ? "Career field not selected"
//               : "No careers available",

//           textAlign:
//               TextAlign.center,

//           style:
//               const TextStyle(
//             color:
//                 Colors.white,

//             fontSize:
//                 20,

//             fontWeight:
//                 FontWeight.bold,
//           ),
//         ),

//         const SizedBox(
//           height: 10,
//         ),

//         Text(
//           interestField.isEmpty
//               ? "Please select your career field from your profile first."
//               : "There are currently no graduate careers added for ${formatCategory(interestField)}.",

//           textAlign:
//               TextAlign.center,

//           style:
//               const TextStyle(
//             color:
//                 Colors.white54,

//             fontSize:
//                 13,

//             height:
//                 1.5,
//           ),
//         ),
//       ],
//     );
//   }
// }





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GraduateCareerBank extends StatefulWidget {
  const GraduateCareerBank({super.key});

  @override
  State<GraduateCareerBank> createState() =>
      _GraduateCareerBankState();
}

class _GraduateCareerBankState extends State<GraduateCareerBank> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  bool isLoading = true;

  String userName = "Graduate";

  List<Map<String, dynamic>> careers = [];

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();
    loadCareerBank();
  }

  // ==========================================================
  // LOAD ALL CAREERS
  // ==========================================================

  Future<void> loadCareerBank() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        return;
      }

      // ========================================================
      // GET USER NAME
      // ========================================================

      final userSnapshot = await _firestore
          .collection("users")
          .doc(user.uid)
          .get();

      if (userSnapshot.exists) {
        final data =
            userSnapshot.data() as Map<String, dynamic>;

        userName =
            data["name"]?.toString().trim().isNotEmpty == true
                ? data["name"].toString().trim()
                : data["fullName"]?.toString().trim().isNotEmpty ==
                        true
                    ? data["fullName"].toString().trim()
                    : "Graduate";
      }

      // ========================================================
      // FETCH ALL CAREER BANK DOCUMENTS
      // ========================================================
      //
      // NO ROLE FILTER
      // NO CATEGORY FILTER
      //
      // Every document inside career_bank will be displayed.
      // ========================================================

      final QuerySnapshot careerSnapshot =
          await _firestore
              .collection("careerBank")
              .get();

      final List<Map<String, dynamic>> loadedCareers = [];

      for (final doc in careerSnapshot.docs) {
        final data =
            doc.data() as Map<String, dynamic>;

        loadedCareers.add({
          "id": doc.id,
          ...data,
        });
      }

      // ========================================================
      // SORT CAREERS
      // ========================================================

      loadedCareers.sort(
        (a, b) {
          final nameA =
              _getCareerName(a).toLowerCase();

          final nameB =
              _getCareerName(b).toLowerCase();

          return nameA.compareTo(nameB);
        },
      );

      if (!mounted) return;

      setState(() {
        careers = loadedCareers;
        isLoading = false;
      });

      // ========================================================
      // LOAD SAVED STATUS
      // ========================================================

      await loadSavedStatus();
    } catch (e) {
      debugPrint(
        "Career Bank Error: $e",
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Unable to load career bank.",
          ),
        ),
      );
    }
  }

  // ==========================================================
  // GET CAREER NAME
  // ==========================================================

  String _getCareerName(
    Map<String, dynamic> career,
  ) {
    final possibleNames = [
      "careerName",
      "career_name",
      "name",
      "title",
      "career",
    ];

    for (final key in possibleNames) {
      final value = career[key];

      if (value != null &&
          value.toString().trim().isNotEmpty) {
        return value.toString().trim();
      }
    }

    return "Career";
  }

  // ==========================================================
  // GET DESCRIPTION
  // ==========================================================

  String _getDescription(
    Map<String, dynamic> career,
  ) {
    final possibleKeys = [
      "description",
      "careerDescription",
      "career_description",
      "details",
      "about",
    ];

    for (final key in possibleKeys) {
      final value = career[key];

      if (value != null &&
          value.toString().trim().isNotEmpty) {
        return value.toString().trim();
      }
    }

    return "No description available.";
  }

  // ==========================================================
  // FORMAT FIELD NAME
  // ==========================================================

  String _formatValue(
    dynamic value,
  ) {
    if (value == null) {
      return "Not added";
    }

    final text = value.toString().trim();

    if (text.isEmpty) {
      return "Not added";
    }

    return text;
  }

  // ==========================================================
  // FORMAT CATEGORY
  // ==========================================================

  String formatCategory(
    dynamic category,
  ) {
    final value =
        _formatValue(category);

    switch (value.toLowerCase()) {
      case "computer":
      case "computerscience":
      case "computer science":
        return "Computer Science";

      case "medical":
        return "Medical & Healthcare";

      case "engineering":
        return "Engineering";

      default:
        return value;
    }
  }

  // ==========================================================
  // CATEGORY ICON
  // ==========================================================

  IconData categoryIcon(
    dynamic category,
  ) {
    switch (
        _formatValue(category).toLowerCase()) {
      case "computer":
      case "computerscience":
      case "computer science":
        return Icons.computer_outlined;

      case "medical":
        return Icons.medical_services_outlined;

      case "engineering":
        return Icons.engineering_outlined;

      default:
        return Icons.work_outline;
    }
  }

  // ==========================================================
  // LOAD SAVED STATUS
  // ==========================================================

  Future<void> loadSavedStatus() async {
    final User? user =
        _auth.currentUser;

    if (user == null ||
        careers.isEmpty) {
      return;
    }

    try {
      final savedSnapshot =
          await _firestore
              .collection("users")
              .doc(user.uid)
              .collection("savedCareers")
              .get();

      final Set<String> savedIds =
          savedSnapshot.docs
              .map(
                (doc) => doc.id,
              )
              .toSet();

      if (!mounted) return;

      setState(() {
        for (final career in careers) {
          career["_saved"] =
              savedIds.contains(
            career["id"].toString(),
          );
        }
      });
    } catch (e) {
      debugPrint(
        "Saved status error: $e",
      );
    }
  }

  // ==========================================================
  // SAVE / REMOVE CAREER
  // ==========================================================

  Future<void> toggleSaveCareer(
    Map<String, dynamic> career,
  ) async {
    final User? user =
        _auth.currentUser;

    if (user == null) {
      return;
    }

    final String careerId =
        career["id"].toString();

    if (careerId.isEmpty) {
      return;
    }

    final DocumentReference savedRef =
        _firestore
            .collection("users")
            .doc(user.uid)
            .collection("savedCareers")
            .doc(careerId);

    try {
      final savedSnapshot =
          await savedRef.get();

      // ========================================================
      // REMOVE
      // ========================================================

      if (savedSnapshot.exists) {
        await savedRef.delete();

        if (!mounted) return;

        setState(() {
          career["_saved"] = false;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "Removed from saved careers.",
            ),
            duration:
                Duration(seconds: 1),
          ),
        );
      }

      // ========================================================
      // SAVE
      // ========================================================

      else {
        await savedRef.set({
          "careerId": careerId,

          "careerName":
              _getCareerName(career),

          "description":
              _getDescription(career),

          // Save ALL career-bank fields
          // so the Saved page can display them.
          ...career,

          "savedAt":
              FieldValue.serverTimestamp(),
        });

        if (!mounted) return;

        setState(() {
          career["_saved"] = true;
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "Career saved successfully.",
            ),
            duration:
                Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      debugPrint(
        "Save career error: $e",
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Could not update saved career.",
          ),
        ),
      );
    }
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF0B1220),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF0B1220),

        elevation: 0,

        iconTheme:
            const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(
          "Career Bank",
          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(
                color:
                    Color(0xFF00C2FF),
              ),
            )
          : RefreshIndicator(
              color:
                  const Color(0xFF00C2FF),

              backgroundColor:
                  const Color(0xFF151F32),

              onRefresh:
                  loadCareerBank,

              child: careers.isEmpty
                  ? _emptyCareerBank()
                  : ListView(
                      padding:
                          const EdgeInsets.all(
                              18),

                      children: [
                        _buildHeader(),

                        const SizedBox(
                            height: 20),

                        ...careers.map(
                          (career) =>
                              _careerCard(
                            career,
                          ),
                        ),

                        const SizedBox(
                            height: 20),
                      ],
                    ),
            ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(22),

      decoration:
          BoxDecoration(
        gradient:
            const LinearGradient(
          colors: [
            Color(0xFF3654E0),
            Color(0xFF6278E8),
          ],

          begin:
              Alignment.topLeft,

          end:
              Alignment.bottomRight,
        ),

        borderRadius:
            BorderRadius.circular(
                22),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Container(
            height: 52,
            width: 52,

            decoration:
                BoxDecoration(
              color: Colors.white
                  .withOpacity(0.16),

              borderRadius:
                  BorderRadius.circular(
                      15),
            ),

            child: const Icon(
              Icons.work_outline,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(
              height: 15),

          const Text(
            "Career Bank",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 6),

          Text(
            "Explore available career opportunities, requirements and career information.",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.4,
            ),
          ),

          const SizedBox(
              height: 15),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),

            decoration:
                BoxDecoration(
              color: Colors.white
                  .withOpacity(0.14),

              borderRadius:
                  BorderRadius.circular(
                      20),
            ),

            child: Text(
              "${careers.length} Careers Available",
              style:
                  const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CAREER CARD
  // ==========================================================

  Widget _careerCard(
    Map<String, dynamic> career,
  ) {
    final String careerName =
        _getCareerName(career);

    final String description =
        _getDescription(career);

    final String category =
        formatCategory(
      career["category"],
    );

    final String role =
        _formatValue(
      career["role"],
    );

    final bool saved =
        career["_saved"] == true;

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 14,
      ),

      decoration:
          BoxDecoration(
        color:
            const Color(0xFF151F32),

        borderRadius:
            BorderRadius.circular(
                18),

        border: Border.all(
          color: saved
              ? const Color(
                  0xFF00C2FF,
                ).withOpacity(0.40)
              : Colors.white10,
        ),
      ),

      child: Padding(
        padding:
            const EdgeInsets.all(17),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ====================================================
            // TOP ROW
            // ====================================================

            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Container(
                  height: 54,
                  width: 54,

                  decoration:
                      BoxDecoration(
                    color:
                        const Color(
                      0xFF00C2FF,
                    ).withOpacity(0.10),

                    borderRadius:
                        BorderRadius.circular(
                            14),
                  ),

                  child: Icon(
                    categoryIcon(
                      career["category"],
                    ),

                    color:
                        const Color(
                      0xFF00C2FF,
                    ),

                    size: 28,
                  ),
                ),

                const SizedBox(
                    width: 13),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [
                      Text(
                        careerName,

                        style:
                            const TextStyle(
                          color:
                              Colors.white,

                          fontSize:
                              17,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                          height: 6),

                      Text(
                        role ==
                                "Not added"
                            ? "Career"
                            : role,

                        style:
                            const TextStyle(
                          color:
                              Color(
                            0xFF00C2FF,
                          ),

                          fontSize:
                              11,

                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // =================================================
                // WORKING BOOKMARK
                // =================================================

                IconButton(
                  tooltip: saved
                      ? "Remove saved career"
                      : "Save career",

                  onPressed: () {
                    toggleSaveCareer(
                      career,
                    );
                  },

                  icon: Icon(
                    saved
                        ? Icons.bookmark
                        : Icons.bookmark_border,

                    color: saved
                        ? const Color(
                            0xFF00C2FF,
                          )
                        : Colors.white54,

                    size: 28,
                  ),
                ),
              ],
            ),

            const SizedBox(
                height: 15),

            // ====================================================
            // DESCRIPTION
            // ====================================================

            Text(
              description,

              maxLines: 4,

              overflow:
                  TextOverflow.ellipsis,

              style:
                  const TextStyle(
                color:
                    Colors.white60,

                fontSize:
                    13,

                height:
                    1.5,
              ),
            ),

            const SizedBox(
                height: 15),

            // ====================================================
            // BASIC INFORMATION
            // ====================================================

            Wrap(
              spacing: 8,
              runSpacing: 8,

              children: [
                _smallTag(
                  Icons.category_outlined,
                  category,
                ),

                _smallTag(
                  Icons.person_outline,
                  role,
                ),

                _smallTag(
                  Icons.school_outlined,
                  "Graduate",
                ),
              ],
            ),

            const SizedBox(
                height: 14),

            // ====================================================
            // VIEW DETAILS
            // ====================================================

            Align(
              alignment:
                  Alignment.centerRight,

              child:
                  TextButton.icon(
                onPressed: () {
                  _showCareerDetails(
                    career,
                  );
                },

                icon: const Icon(
                  Icons.visibility_outlined,
                  color:
                      Color(0xFF00C2FF),
                  size: 16,
                ),

                label:
                    const Text(
                  "View All Fields",
                  style:
                      TextStyle(
                    color:
                        Color(
                      0xFF00C2FF,
                    ),

                    fontSize:
                        12,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SMALL TAG
  // ==========================================================

  Widget _smallTag(
    IconData icon,
    String text,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),

      decoration:
          BoxDecoration(
        color: Colors.white
            .withOpacity(0.05),

        borderRadius:
            BorderRadius.circular(
                8),
      ),

      child: Row(
        mainAxisSize:
            MainAxisSize.min,

        children: [
          Icon(
            icon,
            color: Colors.white38,
            size: 13,
          ),

          const SizedBox(
              width: 5),

          Text(
            text,

            style:
                const TextStyle(
              color:
                  Colors.white54,

              fontSize:
                  10,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // CAREER DETAILS
  // ==========================================================

  void _showCareerDetails(
    Map<String, dynamic> career,
  ) {
    final String careerName =
        _getCareerName(career);

    final bool saved =
        career["_saved"] == true;

    // Remove internal fields.
    final Map<String, dynamic>
        displayFields = {};

    career.forEach(
      (key, value) {
        if (key != "id" &&
            key != "_saved" &&
            value != null) {
          displayFields[key] = value;
        }
      },
    );

    showModalBottomSheet(
      context: context,

      backgroundColor:
          const Color(0xFF151F32),

      isScrollControlled: true,

      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),

      builder: (bottomSheetContext) {
        return SafeArea(
          child:
              DraggableScrollableSheet(
            expand: false,

            initialChildSize:
                0.80,

            minChildSize:
                0.55,

            maxChildSize:
                0.95,

            builder:
                (context, scrollController) {
              return Column(
                children: [
                  const SizedBox(
                      height: 10),

                  Container(
                    height: 5,
                    width: 45,

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.white24,

                      borderRadius:
                          BorderRadius.circular(
                              10),
                    ),
                  ),

                  const SizedBox(
                      height: 18),

                  // ==================================================
                  // TITLE
                  // ==================================================

                  Padding(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 20,
                    ),

                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            careerName,

                            style:
                                const TextStyle(
                              color:
                                  Colors.white,

                              fontSize:
                                  22,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        IconButton(
                          tooltip: saved
                              ? "Remove from saved"
                              : "Save career",

                          onPressed: () {
                            toggleSaveCareer(
                              career,
                            );

                            Navigator.pop(
                              bottomSheetContext,
                            );
                          },

                          icon: Icon(
                            saved
                                ? Icons.bookmark
                                : Icons
                                    .bookmark_border,

                            color:
                                const Color(
                              0xFF00C2FF,
                            ),

                            size: 29,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                      height: 5),

                  Expanded(
                    child:
                        ListView(
                      controller:
                          scrollController,

                      padding:
                          const EdgeInsets
                              .fromLTRB(
                        20,
                        10,
                        20,
                        30,
                      ),

                      children: [
                        const Text(
                          "Career Information",

                          style:
                              TextStyle(
                            color:
                                Colors.white,
                            fontSize:
                                17,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                            height: 12),

                        // ==================================================
                        // SHOW EVERY FIELD
                        // ==================================================

                        ...displayFields
                            .entries
                            .map(
                          (
                            entry,
                          ) {
                            return _detailField(
                              entry.key,
                              entry.value,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  // ==========================================================
  // DETAIL FIELD
  // ==========================================================

  Widget _detailField(
    String key,
    dynamic value,
  ) {
    String title =
        _prettyFieldName(key);

    String text;

    if (value is List) {
      text = value.join(", ");
    } else if (value is Map) {
      text = value.entries
          .map(
            (entry) =>
                "${entry.key}: ${entry.value}",
          )
          .join("\n");
    } else {
      text = _formatValue(value);
    }

    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),

      padding:
          const EdgeInsets.all(14),

      decoration:
          BoxDecoration(
        color:
            const Color(0xFF0B1220),

        borderRadius:
            BorderRadius.circular(
                13),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            title,

            style:
                const TextStyle(
              color:
                  Color(0xFF00C2FF),

              fontSize:
                  12,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 6),

          Text(
            text,

            style:
                const TextStyle(
              color:
                  Colors.white,

              fontSize:
                  13,

              height:
                  1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PRETTY FIELD NAME
  // ==========================================================

  String _prettyFieldName(
    String key,
  ) {
    String result =
        key.replaceAll(
      RegExp(r'[_-]+'),
      ' ',
    );

    result =
        result.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) =>
          "${match.group(1)} ${match.group(2)}",
    );

    return result
        .split(" ")
        .where(
          (word) => word.isNotEmpty,
        )
        .map(
          (word) =>
              word[0].toUpperCase() +
              word.substring(1),
        )
        .join(" ");
  }

  // ==========================================================
  // EMPTY
  // ==========================================================

  Widget _emptyCareerBank() {
    return ListView(
      physics:
          const AlwaysScrollableScrollPhysics(),

      padding:
          const EdgeInsets.all(20),

      children: [
        const SizedBox(
            height: 90),

        const Icon(
          Icons.work_off_outlined,
          color:
              Colors.white24,
          size: 70,
        ),

        const SizedBox(
            height: 20),

        const Text(
          "No Careers Available",

          textAlign:
              TextAlign.center,

          style:
              TextStyle(
            color:
                Colors.white,

            fontSize:
                20,

            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(
            height: 10),

        const Text(
          "There are currently no careers in the career bank.",

          textAlign:
              TextAlign.center,

          style:
              TextStyle(
            color:
                Colors.white54,

            fontSize:
                13,

            height:
                1.5,
          ),
        ),

        const SizedBox(
            height: 20),

        Center(
          child: OutlinedButton.icon(
            onPressed:
                loadCareerBank,

            icon: const Icon(
              Icons.refresh,
              color:
                  Color(0xFF00C2FF),
            ),

            label:
                const Text(
              "Refresh",
              style:
                  TextStyle(
                color:
                    Color(
                  0xFF00C2FF,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}