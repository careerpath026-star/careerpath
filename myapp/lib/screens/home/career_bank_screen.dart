// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class CareerBankScreen extends StatefulWidget {
//   const CareerBankScreen({super.key});

//   @override
//   State<CareerBankScreen> createState() => _CareerBankScreenState();
// }

// class _CareerBankScreenState extends State<CareerBankScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   String searchQuery = "";
//   String selectedCategory = "All";

//   final List<String> categories = ["All", "engineering", "computer", "medical"];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0B1220),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0B1220),
//         elevation: 0,
//         title: const Text(
//           "Career Bank",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Column(
//         children: [
//           // Search & Filter Section
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   onChanged: (val) => setState(() => searchQuery = val.toLowerCase()),
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: "Search careers or skills...",
//                     hintStyle: const TextStyle(color: Colors.white54),
//                     prefixIcon: const Icon(Icons.search, color: Color(0xFF00C2FF)),
//                     filled: true,
//                     fillColor: const Color(0xFF151F32),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 SizedBox(
//                   height: 40,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: categories.length,
//                     itemBuilder: (context, index) {
//                       final cat = categories[index];
//                       final isSelected = selectedCategory == cat;
//                       return Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: ChoiceChip(
//                           label: Text(cat.toUpperCase()),
//                           selected: isSelected,
//                           onSelected: (bool selected) {
//                             setState(() => selectedCategory = cat);
//                           },
//                           backgroundColor: const Color(0xFF151F32),
//                           selectedColor: const Color(0xFF00C2FF),
//                           labelStyle: TextStyle(
//                             color: isSelected ? const Color(0xFF0B1220) : Colors.white70,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
          
//           // Career List from Firestore
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _firestore.collection("careerBank").snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(color: Color(0xFF00C2FF)),
//                   );
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(
//                     child: Text("No careers found.", style: TextStyle(color: Colors.white54)),
//                   );
//                 }

//                 final docs = snapshot.data!.docs.where((doc) {
//                   final data = doc.data() as Map<String, dynamic>;
//                   final name = (data["careerName"] ?? "").toString().toLowerCase();
//                   final cat = (data["category"] ?? "").toString().toLowerCase();
                  
//                   final matchesSearch = name.contains(searchQuery);
//                   final matchesCategory = selectedCategory == "All" || cat == selectedCategory.toLowerCase();
                  
//                   return matchesSearch && matchesCategory;
//                 }).toList();

//                 if (docs.isEmpty) {
//                   return const Center(
//                     child: Text("No matching careers match your filter.", style: TextStyle(color: Colors.white54)),
//                   );
//                 }

//                 return ListView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   itemCount: docs.length,
//                   itemBuilder: (context, index) {
//                     final data = docs[index].data() as Map<String, dynamic>;
//                     return CareerCard(data: data);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CareerCard extends StatelessWidget {
//   final Map<String, dynamic> data;
//   const CareerCard({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     final List skills = data["skills"] ?? [];
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF151F32),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: Colors.white12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   data["careerName"] ?? "Unknown Career",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF00C2FF).withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Text(
//                   data["categoryName"] ?? "General",
//                   style: const TextStyle(color: Color(0xFF00C2FF), fontSize: 10, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             data["description"] ?? "",
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(color: Colors.white60, fontSize: 13),
//           ),
//           const SizedBox(height: 12),
//           Wrap(
//             spacing: 6,
//             runSpacing: 4,
//             children: skills.take(3).map((skill) {
//               return Chip(
//                 label: Text(skill.toString()),
//                 labelStyle: const TextStyle(color: Colors.white70, fontSize: 10),
//                 backgroundColor: const Color(0xFF0B1220),
//                 padding: EdgeInsets.zero,
//                 visualDensity: VisualDensity.compact,
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CareerBankScreen extends StatefulWidget {
  const CareerBankScreen({super.key});

  @override
  State<CareerBankScreen> createState() => _CareerBankScreenState();
}

class _CareerBankScreenState extends State<CareerBankScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String searchQuery = "";
  String selectedCategory = "All";

  final List<String> categories = ["All", "engineering", "computer", "medical"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        title: const Text(
          "Career Bank",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Search & Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => setState(() => searchQuery = val.toLowerCase()),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search careers or skills...",
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF00C2FF)),
                    filled: true,
                    fillColor: const Color(0xFF151F32),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      final isSelected = selectedCategory == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(cat.toUpperCase()),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            setState(() => selectedCategory = cat);
                          },
                          backgroundColor: const Color(0xFF151F32),
                          selectedColor: const Color(0xFF00C2FF),
                          labelStyle: TextStyle(
                            color: isSelected ? const Color(0xFF0B1220) : Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Career List from Firestore
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("careerBank").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF00C2FF)),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No careers found.", style: TextStyle(color: Colors.white54)),
                  );
                }

                final docs = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final name = (data["careerName"] ?? "").toString().toLowerCase();
                  final cat = (data["category"] ?? "").toString().toLowerCase();
                  
                  final matchesSearch = name.contains(searchQuery);
                  final matchesCategory = selectedCategory == "All" || cat == selectedCategory.toLowerCase();
                  
                  return matchesSearch && matchesCategory;
                }).toList();

                if (docs.isEmpty) {
                  return const Center(
                    child: Text("No matching careers match your filter.", style: TextStyle(color: Colors.white54)),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    return CareerCard(data: data);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CareerCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const CareerCard({super.key, required this.data});

  // Bookmark Functionality with Optional Note (Visibility Fixed)
  void _addBookmark(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please login to save bookmarks")),
      );
      return;
    }

    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF151F32),
        title: Text(
          "Bookmark '${data["careerName"] ?? "Career"}'",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        content: TextField(
          controller: noteController,
          style: const TextStyle(color: Colors.white), // Input text clear white visible hoga
          cursorColor: const Color(0xFF00C2FF),
          decoration: const InputDecoration(
            hintText: "Add a personal note (optional)...",
            hintStyle: TextStyle(color: Colors.white54),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white30),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00C2FF)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel", style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00C2FF),
            ),
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(user.uid)
                  .collection("bookmarks")
                  .add({
                "title": data["careerName"] ?? "Career Path",
                "note": noteController.text.trim(),
                "timestamp": FieldValue.serverTimestamp(),
              });

              if (dialogContext.mounted) {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Saved to Bookmarks!"),
                  ),
                );
              }
            },
            child: const Text("Save", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List skills = data["skills"] ?? [];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151F32),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data["careerName"] ?? "Unknown Career",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C2FF).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      data["categoryName"] ?? "General",
                      style: const TextStyle(color: Color(0xFF00C2FF), fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.bookmark_add_outlined, color: Color(0xFF00C2FF), size: 22),
                    onPressed: () => _addBookmark(context),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            data["description"] ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white60, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: skills.take(3).map((skill) {
              return Chip(
                label: Text(skill.toString()),
                labelStyle: const TextStyle(color: Colors.white70, fontSize: 10),
                backgroundColor: const Color(0xFF0B1220),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}