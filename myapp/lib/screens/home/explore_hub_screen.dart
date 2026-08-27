
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ExploreHubScreen extends StatefulWidget {
  const ExploreHubScreen({super.key});

  @override
  State<ExploreHubScreen> createState() => _ExploreHubScreenState();
}

class _ExploreHubScreenState extends State<ExploreHubScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        title: const Text(
          "Explore Career Hub",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF00C2FF),
          labelColor: const Color(0xFF00C2FF),
          unselectedLabelColor: Colors.white60,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: const [
            Tab(text: "Career Bank"),
            Tab(text: "Learning Center"),
            Tab(text: "Resources"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CareerBankTab(),
          LearningCenterTab(),
          ResourceLibraryTab(),
        ],
      ),
    );
  }
}

// ==========================================
// HELPER FUNCTION FOR URL LAUNCHING
// ==========================================
Future<void> _launchURL(BuildContext context, String urlString) async {
  final Uri uri = Uri.parse(urlString);
  try {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not open link: $urlString")),
        );
      }
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error launching URL: $e")),
      );
    }
  }
}

// ==========================================
// 1. CAREER BANK TAB
// ==========================================
class CareerBankTab extends StatefulWidget {
  const CareerBankTab({super.key});

  @override
  State<CareerBankTab> createState() => _CareerBankTabState();
}

class _CareerBankTabState extends State<CareerBankTab> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String searchQuery = "";
  String selectedCategory = "All";

  final List<String> categories = ["All", "engineering", "computer", "medical"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  child: Text("No careers found in database.", style: TextStyle(color: Colors.white54)),
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
    );
  }
}

class CareerCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const CareerCard({super.key, required this.data});

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

// ==========================================
// 2. LEARNING CENTER TAB (Open Videos / Podcasts)
// ==========================================
class LearningCenterTab extends StatelessWidget {
  const LearningCenterTab({super.key});

  final List<Map<String, String>> learningItems = const [
    {
      "title": "Flutter Full Course for Beginners",
      "type": "Video Course",
      "duration": "45 mins",
      "url": "https://www.youtube.com/watch?v=VPvVD8t02U8",
    },
    {
      "title": "Software Engineering Career Roadmap",
      "type": "Podcast / Guide",
      "duration": "28 mins",
      "url": "https://www.youtube.com/watch?v=z0n1aQ3IxWI",
    },
    {
      "title": "AI & Future Tech Trends Masterclass",
      "type": "Masterclass",
      "duration": "1 hour",
      "url": "https://www.youtube.com/watch?v=2ePf9rue1Ao",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: learningItems.length,
      itemBuilder: (context, index) {
        final item = learningItems[index];
        return InkWell(
          onTap: () => _launchURL(context, item["url"]!),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF151F32),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C2FF).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.play_circle_fill, color: Color(0xFF00C2FF), size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            item["type"]!,
                            style: const TextStyle(color: Color(0xFF00C2FF), fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                          const Text(" • ", style: TextStyle(color: Colors.white54)),
                          Text(
                            item["duration"]!,
                            style: const TextStyle(color: Colors.white60, fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.open_in_new, color: Colors.white54, size: 18),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ==========================================
// 3. RESOURCE LIBRARY TAB (Web & Mobile Downloader)
// ==========================================
class ResourceLibraryTab extends StatefulWidget {
  const ResourceLibraryTab({super.key});

  @override
  State<ResourceLibraryTab> createState() => _ResourceLibraryTabState();
}

class _ResourceLibraryTabState extends State<ResourceLibraryTab> {
  final List<Map<String, String>> resourceItems = const [
    {
      "title": "Flutter Developer Resume Sample PDF",
      "format": "PDF Document",
      "size": "0.5 MB",
      "url": "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
    },
    {
      "title": "Computer Science Career Roadmap Guide",
      "format": "Checklist PDF",
      "size": "1.2 MB",
      "url": "https://www.orimi.com/pdf-test.pdf",
    },
  ];

  final Map<String, double> _downloadProgress = {};

  Future<void> _downloadPDF(String title, String url) async {
    // WEB PLATFORM HANDLING (Bypass path_provider on Web)
    if (kIsWeb) {
      await _launchURL(context, url);
      return;
    }

    // MOBILE PLATFORM HANDLING (Android / iOS Local File Save)
    try {
      final dir = await getApplicationDocumentsDirectory();
      final savePath = "${dir.path}/${title.replaceAll(' ', '_')}.pdf";

      Dio dio = Dio();
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress[title] = received / total;
            });
          }
        },
      );

      setState(() {
        _downloadProgress.remove(title);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Downloaded to: $savePath"),
            action: SnackBarAction(
              label: "Open",
              textColor: Colors.white,
              onPressed: () => _launchURL(context, url),
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _downloadProgress.remove(title);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Download Failed: $e"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: resourceItems.length,
      itemBuilder: (context, index) {
        final res = resourceItems[index];
        final title = res["title"]!;
        final isDownloading = _downloadProgress.containsKey(title);
        final progress = _downloadProgress[title] ?? 0.0;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF151F32),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.picture_as_pdf, color: Colors.purpleAccent, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          res["format"]!,
                          style: const TextStyle(color: Colors.purpleAccent, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        const Text(" • ", style: TextStyle(color: Colors.white54)),
                        Text(
                          res["size"]!,
                          style: const TextStyle(color: Colors.white60, fontSize: 11),
                        ),
                      ],
                    ),
                    if (isDownloading) ...[
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white12,
                        color: Colors.purpleAccent,
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: isDownloading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.purpleAccent),
                      )
                    : const Icon(Icons.download_rounded, color: Colors.white70),
                onPressed: isDownloading ? null : () => _downloadPDF(title, res["url"]!),
              ),
            ],
          ),
        );
      },
    );
  }
}
