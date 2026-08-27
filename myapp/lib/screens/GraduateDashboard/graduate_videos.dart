// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class GraduateVideosPage extends StatefulWidget {
//   const GraduateVideosPage({super.key});

//   @override
//   State<GraduateVideosPage> createState() => _GraduateVideosPageState();
// }

// class _GraduateVideosPageState extends State<GraduateVideosPage> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   final TextEditingController _searchController = TextEditingController();

//   String _searchQuery = '';
//   String _selectedCategory = 'All';

//   @override
//   void initState() {
//     super.initState();

//     _searchController.addListener(() {
//       setState(() {
//         _searchQuery = _searchController.text.trim().toLowerCase();
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   // =====================================================
//   // VIDEOS
//   // =====================================================

//   Stream<QuerySnapshot<Map<String, dynamic>>> _videosStream() {
//     return _firestore
//         .collection('videos')
//         .where('role', isEqualTo: 'Graduate')
//         .snapshots();
//   }

//   // =====================================================
//   // URL LAUNCHER
//   // =====================================================

//   Future<void> _openVideo(String url) async {
//     final uri = Uri.tryParse(url.trim());

//     if (uri == null) {
//       _showMessage('Invalid video link', Colors.red);
//       return;
//     }

//     try {
//       final launched = await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication,
//       );

//       if (!launched) {
//         _showMessage('Could not open video', Colors.red);
//       }
//     } catch (e) {
//       _showMessage('Could not open video', Colors.red);
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
//   // FILTER
//   // =====================================================

//   List<QueryDocumentSnapshot<Map<String, dynamic>>> _filterVideos(
//     List<QueryDocumentSnapshot<Map<String, dynamic>>> videos,
//   ) {
//     return videos.where((doc) {
//       final data = doc.data();

//       final title = (data['title'] ?? '').toString().toLowerCase();
//       final description =
//           (data['description'] ?? '').toString().toLowerCase();
//       final category =
//           (data['category'] ?? '').toString().toLowerCase();
//       final career =
//           (data['career'] ?? '').toString().toLowerCase();

//       final matchesSearch =
//           _searchQuery.isEmpty ||
//           title.contains(_searchQuery) ||
//           description.contains(_searchQuery) ||
//           category.contains(_searchQuery) ||
//           career.contains(_searchQuery);

//       final matchesCategory =
//           _selectedCategory == 'All' ||
//           category == _selectedCategory.toLowerCase();

//       return matchesSearch && matchesCategory;
//     }).toList();
//   }

//   // =====================================================
//   // CATEGORIES
//   // =====================================================

//   List<String> _getCategories(
//     List<QueryDocumentSnapshot<Map<String, dynamic>>> videos,
//   ) {
//     final categories = <String>{};

//     for (final video in videos) {
//       final category = (video.data()['category'] ?? '')
//           .toString()
//           .trim();

//       if (category.isNotEmpty) {
//         categories.add(category);
//       }
//     }

//     final result = categories.toList();
//     result.sort();

//     return ['All', ...result];
//   }

//   // =====================================================
//   // VIDEO CARD
//   // =====================================================

//   Widget _videoCard(
//     QueryDocumentSnapshot<Map<String, dynamic>> video,
//   ) {
//     final data = video.data();

//     final title = (data['title'] ?? 'Untitled Video').toString();
//     final description =
//         (data['description'] ?? '').toString();
//     final category =
//         (data['category'] ?? 'Career Guidance').toString();
//     final career =
//         (data['career'] ?? '').toString();
//     final url =
//         (data['videoUrl'] ?? data['url'] ?? '').toString();

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
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 55,
//                 height: 55,
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade50,
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: const Icon(
//                   Icons.play_circle_outline,
//                   color: Colors.blue,
//                   size: 32,
//                 ),
//               ),

//               const SizedBox(width: 14),

//               Expanded(
//                 child: Column(
//                   crossAxisAlignment:
//                       CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF172033),
//                       ),
//                     ),

//                     const SizedBox(height: 7),

//                     Row(
//                       children: [
//                         _chip(
//                           category,
//                           Colors.blue,
//                         ),

//                         if (career.isNotEmpty) ...[
//                           const SizedBox(width: 7),
//                           Flexible(
//                             child: _chip(
//                               career,
//                               Colors.green,
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           if (description.isNotEmpty) ...[
//             const SizedBox(height: 15),

//             Text(
//               description,
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 13,
//                 height: 1.5,
//               ),
//             ),
//           ],

//           const SizedBox(height: 16),

//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               onPressed: url.trim().isEmpty
//                   ? null
//                   : () => _openVideo(url),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF2563EB),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 13,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               icon: const Icon(
//                 Icons.play_arrow,
//                 size: 21,
//               ),
//               label: const Text(
//                 'Watch Video',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // CHIP
//   // =====================================================

//   Widget _chip(String text, Color color) {
//     return Container(
//       constraints: const BoxConstraints(
//         maxWidth: 170,
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
//   // SEARCH + FILTER
//   // =====================================================

//   Widget _filterBar(List<String> categories) {
//     return Column(
//       children: [
//         TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText:
//                 'Search videos, careers, categories...',
//             prefixIcon: const Icon(Icons.search),
//             suffixIcon: _searchQuery.isNotEmpty
//                 ? IconButton(
//                     onPressed: () {
//                       _searchController.clear();
//                     },
//                     icon: const Icon(Icons.clear),
//                   )
//                 : null,
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(14),
//               borderSide: BorderSide(
//                 color: Colors.grey.shade200,
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(14),
//               borderSide: BorderSide(
//                 color: Colors.grey.shade200,
//               ),
//             ),
//           ),
//         ),

//         const SizedBox(height: 12),

//         SizedBox(
//           width: double.infinity,
//           child: DropdownButtonFormField<String>(
//             value: categories.contains(_selectedCategory)
//                 ? _selectedCategory
//                 : 'All',
//             decoration: InputDecoration(
//               labelText: 'Category',
//               prefixIcon:
//                   const Icon(Icons.filter_list_outlined),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: BorderSide(
//                   color: Colors.grey.shade200,
//                 ),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(14),
//                 borderSide: BorderSide(
//                   color: Colors.grey.shade200,
//                 ),
//               ),
//             ),
//             items: categories.map((category) {
//               return DropdownMenuItem(
//                 value: category,
//                 child: Text(
//                   category,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               );
//             }).toList(),
//             onChanged: (value) {
//               if (value == null) return;

//               setState(() {
//                 _selectedCategory = value;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   // =====================================================
//   // EMPTY STATE
//   // =====================================================

//   Widget _emptyState() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 70,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(
//           color: Colors.grey.shade200,
//         ),
//       ),
//       child: Column(
//         children: [
//           Icon(
//             Icons.video_library_outlined,
//             size: 65,
//             color: Colors.grey.shade400,
//           ),

//           const SizedBox(height: 16),

//           const Text(
//             'No Videos Found',
//             style: TextStyle(
//               fontSize: 19,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 7),

//           Text(
//             'No graduate career videos are available yet.',
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
//       backgroundColor: const Color(0xFFF6F8FC),

//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(
//           color: Color(0xFF172033),
//         ),
//         title: const Text(
//           'Career Videos',
//           style: TextStyle(
//             color: Color(0xFF172033),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),

//       body: SafeArea(
//         child: StreamBuilder<
//             QuerySnapshot<Map<String, dynamic>>>(
//           stream: _videosStream(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState ==
//                 ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             if (snapshot.hasError) {
//               return Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(24),
//                   child: Text(
//                     'Unable to load videos.\n\n${snapshot.error}',
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               );
//             }

//             final allVideos = snapshot.data?.docs ?? [];

//             final categories =
//                 _getCategories(allVideos);

//             final videos =
//                 _filterVideos(allVideos);

//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(18),
//               child: Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Career Guidance Videos',
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF172033),
//                     ),
//                   ),

//                   const SizedBox(height: 6),

//                   Text(
//                     'Explore expert videos and career guidance prepared for graduates.',
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: 13,
//                       height: 1.5,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   _filterBar(categories),

//                   const SizedBox(height: 20),

//                   Text(
//                     '${videos.length} video${videos.length == 1 ? '' : 's'} found',
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   if (videos.isEmpty)
//                     _emptyState()
//                   else
//                     ...videos.map(_videoCard),
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

class GraduateVideosPage extends StatefulWidget {
  const GraduateVideosPage({super.key});

  @override
  State<GraduateVideosPage> createState() => _GraduateVideosPageState();
}

class _GraduateVideosPageState extends State<GraduateVideosPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _searchController = TextEditingController();

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
  // FETCH GRADUATE VIDEOS
  // =====================================================

  Stream<QuerySnapshot<Map<String, dynamic>>> _videosStream() {
    return _firestore
        .collection('videos')
        .where('role', isEqualTo: 'Graduate')
        .snapshots();
  }

  // =====================================================
  // OPEN VIDEO
  // =====================================================

  Future<void> _openVideo(String url) async {
    final uri = Uri.tryParse(url.trim());

    if (uri == null || url.trim().isEmpty) {
      _showMessage(
        'Invalid video link',
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
          'Could not open video',
          Colors.red,
        );
      }
    } catch (e) {
      _showMessage(
        'Could not open video',
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
  // FILTER VIDEOS
  // =====================================================

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _filterVideos(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> videos,
  ) {
    if (_searchQuery.isEmpty) {
      return videos;
    }

    return videos.where((doc) {
      final data = doc.data();

      final title =
          (data['title'] ?? '').toString().toLowerCase();

      final description =
          (data['description'] ?? '').toString().toLowerCase();

      return title.contains(_searchQuery) ||
          description.contains(_searchQuery);
    }).toList();
  }

  // =====================================================
  // VIDEO CARD
  // =====================================================

  Widget _videoCard(
    QueryDocumentSnapshot<Map<String, dynamic>> video,
  ) {
    final data = video.data();

    final title =
        (data['title'] ?? 'Untitled Video').toString();

    final description =
        (data['description'] ?? '').toString();

    final url =
        (data['videoUrl'] ?? '').toString();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
                  color: Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.play_circle_outline,
                  color: Colors.blue,
                  size: 34,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
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
                color: Colors.grey.shade600,
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
                  : () => _openVideo(url),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF2563EB),
                foregroundColor: Colors.white,
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
                Icons.play_arrow,
              ),
              label: const Text(
                'Watch Video',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // SEARCH BAR
  // =====================================================

  Widget _searchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText:
            'Search videos by title or description...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon:
            _searchQuery.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _searchController.clear();
                    },
                    icon: const Icon(Icons.clear),
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
        enabledBorder: OutlineInputBorder(
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
  // EMPTY STATE
  // =====================================================

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
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
            Icons.video_library_outlined,
            size: 65,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 16),

          const Text(
            'No Videos Found',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            _searchQuery.isEmpty
                ? 'No graduate career videos are available yet.'
                : 'No videos match your search.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
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
        iconTheme: const IconThemeData(
          color: Color(0xFF172033),
        ),
        title: const Text(
          'Career Videos',
          style: TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: StreamBuilder<
            QuerySnapshot<Map<String, dynamic>>>(
          stream: _videosStream(),

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
                    'Unable to load videos.\n\n${snapshot.error}',
                    textAlign:
                        TextAlign.center,
                  ),
                ),
              );
            }

            final allVideos =
                snapshot.data?.docs ?? [];

            final videos =
                _filterVideos(allVideos);

            return SingleChildScrollView(
              padding:
                  const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Career Guidance Videos',
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
                    'Explore career guidance videos prepared for graduates.',
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
                    '${videos.length} video${videos.length == 1 ? '' : 's'} found',
                    style: TextStyle(
                      color:
                          Colors.grey.shade600,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (videos.isEmpty)
                    _emptyState()
                  else
                    ...videos.map(_videoCard),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}