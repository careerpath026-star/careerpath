// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class GraduateResourcesPage extends StatefulWidget {
//   const GraduateResourcesPage({super.key});

//   @override
//   State<GraduateResourcesPage> createState() =>
//       _GraduateResourcesPageState();
// }

// class _GraduateResourcesPageState
//     extends State<GraduateResourcesPage> {
//   final FirebaseFirestore _firestore =
//       FirebaseFirestore.instance;

//   final TextEditingController _searchController =
//       TextEditingController();

//   String _searchQuery = '';
//   String _selectedCategory = 'All';
//   String _selectedType = 'All';

//   @override
//   void initState() {
//     super.initState();

//     _searchController.addListener(() {
//       setState(() {
//         _searchQuery =
//             _searchController.text.trim().toLowerCase();
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   // =====================================================
//   // RESOURCES STREAM
//   // =====================================================

//   Stream<QuerySnapshot<Map<String, dynamic>>>
//       _resourcesStream() {
//     return _firestore
//         .collection('resources')
//         .where('role', isEqualTo: 'graduate')
//         .snapshots();
//   }

//   // =====================================================
//   // OPEN RESOURCE
//   // =====================================================

//   Future<void> _openResource(String url) async {
//     final uri = Uri.tryParse(url.trim());

//     if (uri == null) {
//       _showMessage(
//         'Invalid resource link',
//         Colors.red,
//       );
//       return;
//     }

//     try {
//       final launched = await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication,
//       );

//       if (!launched) {
//         _showMessage(
//           'Could not open resource',
//           Colors.red,
//         );
//       }
//     } catch (e) {
//       _showMessage(
//         'Could not open resource',
//         Colors.red,
//       );
//     }
//   }

//   // =====================================================
//   // MESSAGE
//   // =====================================================

//   void _showMessage(String message, Color color) {
//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: color,
//       ),
//     );
//   }

//   // =====================================================
//   // FILTER RESOURCES
//   // =====================================================

//   List<QueryDocumentSnapshot<Map<String, dynamic>>>
//       _filterResources(
//     List<QueryDocumentSnapshot<Map<String, dynamic>>>
//         resources,
//   ) {
//     return resources.where((doc) {
//       final data = doc.data();

//       final title =
//           (data['title'] ?? '').toString().toLowerCase();

//       final description =
//           (data['description'] ?? '')
//               .toString()
//               .toLowerCase();

//       final category =
//           (data['category'] ?? '')
//               .toString()
//               .toLowerCase();

//       final career =
//           (data['career'] ?? '')
//               .toString()
//               .toLowerCase();

//       final type =
//           (data['resourceType'] ??
//                   data['type'] ??
//                   '')
//               .toString()
//               .toLowerCase();

//       final matchesSearch =
//           _searchQuery.isEmpty ||
//           title.contains(_searchQuery) ||
//           description.contains(_searchQuery) ||
//           category.contains(_searchQuery) ||
//           career.contains(_searchQuery) ||
//           type.contains(_searchQuery);

//       final matchesCategory =
//           _selectedCategory == 'All' ||
//           category ==
//               _selectedCategory.toLowerCase();

//       final matchesType =
//           _selectedType == 'All' ||
//           type == _selectedType.toLowerCase();

//       return matchesSearch &&
//           matchesCategory &&
//           matchesType;
//     }).toList();
//   }

//   // =====================================================
//   // CATEGORIES
//   // =====================================================

//   List<String> _getCategories(
//     List<QueryDocumentSnapshot<Map<String, dynamic>>>
//         resources,
//   ) {
//     final categories = <String>{};

//     for (final resource in resources) {
//       final category =
//           (resource.data()['category'] ?? '')
//               .toString()
//               .trim();

//       if (category.isNotEmpty) {
//         categories.add(category);
//       }
//     }

//     final result = categories.toList();
//     result.sort();

//     return ['All', ...result];
//   }

//   // =====================================================
//   // RESOURCE TYPES
//   // =====================================================

//   List<String> _getTypes(
//     List<QueryDocumentSnapshot<Map<String, dynamic>>>
//         resources,
//   ) {
//     final types = <String>{};

//     for (final resource in resources) {
//       final type =
//           (resource.data()['resourceType'] ??
//                   resource.data()['type'] ??
//                   '')
//               .toString()
//               .trim();

//       if (type.isNotEmpty) {
//         types.add(type);
//       }
//     }

//     final result = types.toList();
//     result.sort();

//     return ['All', ...result];
//   }

//   // =====================================================
//   // RESOURCE ICON
//   // =====================================================

//   IconData _resourceIcon(String type) {
//     final value = type.toLowerCase();

//     if (value.contains('pdf')) {
//       return Icons.picture_as_pdf_outlined;
//     }

//     if (value.contains('check')) {
//       return Icons.checklist_outlined;
//     }

//     if (value.contains('image') ||
//         value.contains('infographic')) {
//       return Icons.image_outlined;
//     }

//     if (value.contains('article')) {
//       return Icons.article_outlined;
//     }

//     return Icons.menu_book_outlined;
//   }

//   // =====================================================
//   // RESOURCE CARD
//   // =====================================================

//   Widget _resourceCard(
//     QueryDocumentSnapshot<Map<String, dynamic>>
//         resource,
//   ) {
//     final data = resource.data();

//     final title =
//         (data['title'] ?? 'Untitled Resource')
//             .toString();

//     final description =
//         (data['description'] ?? '').toString();

//     final category =
//         (data['category'] ?? 'Career Resource')
//             .toString();

//     final career =
//         (data['career'] ?? '').toString();

//     final type =
//         (data['resourceType'] ??
//                 data['type'] ??
//                 'Resource')
//             .toString();

//     final url =
//         (data['resourceUrl'] ??
//                 data['url'] ??
//                 data['downloadUrl'] ??
//                 '')
//             .toString();

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(
//           color: Colors.grey.shade200,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.03),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 58,
//             height: 58,
//             decoration: BoxDecoration(
//               color: Colors.orange.shade50,
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: Icon(
//               _resourceIcon(type),
//               color: Colors.orange.shade700,
//               size: 30,
//             ),
//           ),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF172033),
//                   ),
//                 ),

//                 const SizedBox(height: 8),

//                 Wrap(
//                   spacing: 7,
//                   runSpacing: 6,
//                   children: [
//                     _chip(
//                       type,
//                       Colors.orange,
//                     ),

//                     _chip(
//                       category,
//                       Colors.blue,
//                     ),

//                     if (career.isNotEmpty)
//                       _chip(
//                         career,
//                         Colors.green,
//                       ),
//                   ],
//                 ),

//                 if (description.isNotEmpty) ...[
//                   const SizedBox(height: 12),

//                   Text(
//                     description,
//                     maxLines: 3,
//                     overflow:
//                         TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: 13,
//                       height: 1.5,
//                     ),
//                   ),
//                 ],

//                 const SizedBox(height: 14),

//                 SizedBox(
//                   width: double.infinity,
//                   child: OutlinedButton.icon(
//                     onPressed: url.trim().isEmpty
//                         ? null
//                         : () => _openResource(url),
//                     style:
//                         OutlinedButton.styleFrom(
//                       foregroundColor:
//                           const Color(0xFF2563EB),
//                       side: const BorderSide(
//                         color: Color(0xFF2563EB),
//                       ),
//                       padding:
//                           const EdgeInsets.symmetric(
//                         vertical: 12,
//                       ),
//                       shape:
//                           RoundedRectangleBorder(
//                         borderRadius:
//                             BorderRadius.circular(11),
//                       ),
//                     ),
//                     icon: const Icon(
//                       Icons.download_outlined,
//                       size: 20,
//                     ),
//                     label: const Text(
//                       'Open Resource',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // CHIP
//   // =====================================================

//   Widget _chip(
//     String text,
//     Color color,
//   ) {
//     return Container(
//       constraints: const BoxConstraints(
//         maxWidth: 180,
//       ),
//       padding: const EdgeInsets.symmetric(
//         horizontal: 9,
//         vertical: 5,
//       ),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.08),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         text,
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//           color: color,
//           fontSize: 10,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }

//   // =====================================================
//   // FILTER BAR
//   // =====================================================

//   Widget _filterBar(
//     List<String> categories,
//     List<String> types,
//   ) {
//     return Column(
//       children: [
//         TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText:
//                 'Search resources, careers, categories...',
//             prefixIcon:
//                 const Icon(Icons.search),
//             suffixIcon:
//                 _searchQuery.isNotEmpty
//                     ? IconButton(
//                         onPressed: () {
//                           _searchController.clear();
//                         },
//                         icon:
//                             const Icon(Icons.clear),
//                       )
//                     : null,
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderRadius:
//                   BorderRadius.circular(14),
//               borderSide: BorderSide(
//                 color: Colors.grey.shade200,
//               ),
//             ),
//             enabledBorder:
//                 OutlineInputBorder(
//               borderRadius:
//                   BorderRadius.circular(14),
//               borderSide: BorderSide(
//                 color: Colors.grey.shade200,
//               ),
//             ),
//           ),
//         ),

//         const SizedBox(height: 12),

//         Row(
//           children: [
//             Expanded(
//               child:
//                   DropdownButtonFormField<String>(
//                 value: categories
//                         .contains(
//                             _selectedCategory)
//                     ? _selectedCategory
//                     : 'All',
//                 decoration:
//                     InputDecoration(
//                   labelText: 'Category',
//                   prefixIcon: const Icon(
//                     Icons.category_outlined,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   border:
//                       OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(
//                             14),
//                     borderSide: BorderSide(
//                       color:
//                           Colors.grey.shade200,
//                     ),
//                   ),
//                 ),
//                 items:
//                     categories.map((item) {
//                   return DropdownMenuItem(
//                     value: item,
//                     child: Text(
//                       item,
//                       overflow:
//                           TextOverflow.ellipsis,
//                     ),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   if (value == null) return;

//                   setState(() {
//                     _selectedCategory =
//                         value;
//                   });
//                 },
//               ),
//             ),

//             const SizedBox(width: 10),

//             Expanded(
//               child:
//                   DropdownButtonFormField<String>(
//                 value: types.contains(
//                         _selectedType)
//                     ? _selectedType
//                     : 'All',
//                 decoration:
//                     InputDecoration(
//                   labelText: 'Type',
//                   prefixIcon: const Icon(
//                     Icons.description_outlined,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   border:
//                       OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(
//                             14),
//                     borderSide: BorderSide(
//                       color:
//                           Colors.grey.shade200,
//                     ),
//                   ),
//                 ),
//                 items:
//                     types.map((item) {
//                   return DropdownMenuItem(
//                     value: item,
//                     child: Text(
//                       item,
//                       overflow:
//                           TextOverflow.ellipsis,
//                     ),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   if (value == null) return;

//                   setState(() {
//                     _selectedType = value;
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   // =====================================================
//   // EMPTY
//   // =====================================================

//   Widget _emptyState() {
//     return Container(
//       width: double.infinity,
//       padding:
//           const EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 70,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius:
//             BorderRadius.circular(18),
//         border: Border.all(
//           color: Colors.grey.shade200,
//         ),
//       ),
//       child: Column(
//         children: [
//           Icon(
//             Icons.library_books_outlined,
//             size: 65,
//             color: Colors.grey.shade400,
//           ),

//           const SizedBox(height: 16),

//           const Text(
//             'No Resources Found',
//             style: TextStyle(
//               fontSize: 19,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 7),

//           Text(
//             'No graduate learning resources are available yet.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // BUILD
//   // =====================================================

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           const Color(0xFFF6F8FC),

//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme:
//             const IconThemeData(
//           color: Color(0xFF172033),
//         ),
//         title: const Text(
//           'Learning Resources',
//           style: TextStyle(
//             color: Color(0xFF172033),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),

//       body: SafeArea(
//         child: StreamBuilder<
//             QuerySnapshot<Map<String, dynamic>>>(
//           stream: _resourcesStream(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState ==
//                 ConnectionState.waiting) {
//               return const Center(
//                 child:
//                     CircularProgressIndicator(),
//               );
//             }

//             if (snapshot.hasError) {
//               return Center(
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.all(24),
//                   child: Text(
//                     'Unable to load resources.\n\n${snapshot.error}',
//                     textAlign:
//                         TextAlign.center,
//                   ),
//                 ),
//               );
//             }

//             final allResources =
//                 snapshot.data?.docs ?? [];

//             final categories =
//                 _getCategories(
//               allResources,
//             );

//             final types =
//                 _getTypes(
//               allResources,
//             );

//             final resources =
//                 _filterResources(
//               allResources,
//             );

//             return SingleChildScrollView(
//               padding:
//                   const EdgeInsets.all(18),
//               child: Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Learning Resources',
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight:
//                           FontWeight.bold,
//                       color:
//                           Color(0xFF172033),
//                     ),
//                   ),

//                   const SizedBox(height: 6),

//                   Text(
//                     'Access PDFs, articles, checklists and other career learning materials.',
//                     style: TextStyle(
//                       color:
//                           Colors.grey.shade600,
//                       fontSize: 13,
//                       height: 1.5,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   _filterBar(
//                     categories,
//                     types,
//                   ),

//                   const SizedBox(height: 20),

//                   Text(
//                     '${resources.length} resource${resources.length == 1 ? '' : 's'} found',
//                     style: TextStyle(
//                       color:
//                           Colors.grey.shade600,
//                       fontWeight:
//                           FontWeight.w500,
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   if (resources.isEmpty)
//                     _emptyState()
//                   else
//                     ...resources.map(
//                       _resourceCard,
//                     ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GraduateResourcesPage extends StatefulWidget {
  const GraduateResourcesPage({super.key});

  @override
  State<GraduateResourcesPage> createState() =>
      _GraduateResourcesPageState();
}

class _GraduateResourcesPageState
    extends State<GraduateResourcesPage> {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final TextEditingController _searchController =
      TextEditingController();

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _searchQuery =
            _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // =====================================================
  // FETCH GRADUATE RESOURCES
  // =====================================================

  Stream<QuerySnapshot<Map<String, dynamic>>>
      _resourcesStream() {
    return _firestore
        .collection('resources')
        .where(
          'role',
          isEqualTo: 'Graduate',
        )
        .snapshots();
  }

  // =====================================================
  // OPEN RESOURCE
  // =====================================================

  Future<void> _openResource(String url) async {
    final uri = Uri.tryParse(url.trim());

    if (uri == null || url.trim().isEmpty) {
      _showMessage(
        'Invalid resource link',
        Colors.red,
      );
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        _showMessage(
          'Could not open resource',
          Colors.red,
        );
      }
    } catch (e) {
      _showMessage(
        'Could not open resource',
        Colors.red,
      );
    }
  }

  // =====================================================
  // MESSAGE
  // =====================================================

  void _showMessage(
    String message,
    Color color,
  ) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  // =====================================================
  // FILTER
  // =====================================================

  List<QueryDocumentSnapshot<Map<String, dynamic>>>
      _filterResources(
    List<QueryDocumentSnapshot<Map<String, dynamic>>>
        resources,
  ) {
    if (_searchQuery.isEmpty) {
      return resources;
    }

    return resources.where((doc) {
      final data = doc.data();

      final title =
          (data['title'] ?? '').toString().toLowerCase();

      final description =
          (data['description'] ?? '')
              .toString()
              .toLowerCase();

      return title.contains(_searchQuery) ||
          description.contains(_searchQuery);
    }).toList();
  }

  // =====================================================
  // RESOURCE CARD
  // =====================================================

  Widget _resourceCard(
    QueryDocumentSnapshot<Map<String, dynamic>>
        resource,
  ) {
    final data = resource.data();

    final title =
        (data['title'] ?? 'Untitled Resource')
            .toString();

    final description =
        (data['description'] ?? '').toString();

    final url =
        (data['resourceUrl'] ??
                data['url'] ??
                '')
            .toString();

    return Container(
      margin:
          const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset:
                const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.picture_as_pdf_outlined,
                  color: Colors.red,
                  size: 32,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFF172033),
                  ),
                ),
              ),
            ],
          ),

          if (description.isNotEmpty) ...[
            const SizedBox(height: 15),

            Text(
              description,
              style: TextStyle(
                color:
                    Colors.grey.shade600,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: url.trim().isEmpty
                  ? null
                  : () =>
                      _openResource(url),
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF2563EB),
                foregroundColor:
                    Colors.white,
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 13,
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(
                Icons.open_in_new,
              ),
              label: const Text(
                'Open Resource',
                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // SEARCH
  // =====================================================

  Widget _searchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText:
            'Search resources by title or description...',
        prefixIcon:
            const Icon(Icons.search),
        suffixIcon:
            _searchQuery.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _searchController
                          .clear();
                    },
                    icon: const Icon(
                      Icons.clear,
                    ),
                  )
                : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // EMPTY
  // =====================================================

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 70,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.menu_book_outlined,
            size: 65,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 16),

          const Text(
            'No Resources Found',
            style: TextStyle(
              fontSize: 19,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            _searchQuery.isEmpty
                ? 'No graduate learning resources are available yet.'
                : 'No resources match your search.',
            textAlign:
                TextAlign.center,
            style: TextStyle(
              color:
                  Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF6F8FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme:
            const IconThemeData(
          color:
              Color(0xFF172033),
        ),
        title: const Text(
          'Learning Resources',
          style: TextStyle(
            color:
                Color(0xFF172033),
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: StreamBuilder<
            QuerySnapshot<Map<String, dynamic>>>(
          stream: _resourcesStream(),

          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child:
                    CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding:
                      const EdgeInsets.all(24),
                  child: Text(
                    'Unable to load resources.\n\n${snapshot.error}',
                    textAlign:
                        TextAlign.center,
                  ),
                ),
              );
            }

            final allResources =
                snapshot.data?.docs ?? [];

            final resources =
                _filterResources(
              allResources,
            );

            return SingleChildScrollView(
              padding:
                  const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Career Resources',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Color(0xFF172033),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Explore PDFs, articles and learning material prepared for graduates.',
                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _searchBar(),

                  const SizedBox(height: 20),

                  Text(
                    '${resources.length} resource${resources.length == 1 ? '' : 's'} found',
                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (resources.isEmpty)
                    _emptyState()
                  else
                    ...resources
                        .map(_resourceCard),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}