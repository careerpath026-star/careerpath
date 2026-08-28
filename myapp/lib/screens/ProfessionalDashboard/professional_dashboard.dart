
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/screens/ProfessionalDashboard/bookmarks_notes_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/career_bank_screen.dart';
import 'package:myapp/screens/ProfessionalDashboard/document_library_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/interest_quiz.dart';
import 'package:myapp/screens/ProfessionalDashboard/multimedia_center_page.dart';
import 'package:myapp/screens/ProfessionalDashboard/success_stories_page.dart';

class PersonalizedDashboardPage extends StatefulWidget {
  final String userId;
  const PersonalizedDashboardPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<PersonalizedDashboardPage> createState() => _PersonalizedDashboardPageState();
}

class _PersonalizedDashboardPageState extends State<PersonalizedDashboardPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE0F2F1),
        cardTheme: CardThemeData(
          color: Colors.white, 
          elevation: 2, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Professional Dashboard', 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: const Color(0xFF00796B),
        ),

        // 1. Dynamic Navigation Drawer Connected to 'users' DB
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: db.collection('users').doc(widget.userId).snapshots(),
                builder: (context, snapshot) {
                  String name = 'Explorer';
                  String email = 'user@pathseeker.com';

                  if (snapshot.hasData && snapshot.data!.exists) {
                    var data = snapshot.data!.data() as Map<String, dynamic>?;
                    name = data?['name'] ?? data?['uname'] ?? 'Explorer';
                    email = data?['email'] ?? email;
                  }

                  return UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF00796B), Color(0xFF26A69A)],
                      ),
                    ),
                    accountName: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    accountEmail: Text(email),
                    currentAccountPicture: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Color(0xFF00796B), size: 40),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.dashboard_outlined, color: Color(0xFF00796B)),
                title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00796B))),
                selected: true,
                selectedTileColor: const Color(0xFFE0F2F1),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
                title: const Text('Career Bank'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CareerBankPage(userId: widget.userId),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.quiz_outlined, color: Color(0xFF00796B)),
                title: const Text('Bookmarked Careers & Saved Items'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookmarksNotesPage(userId: widget.userId),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback_outlined, color: Color(0xFF00796B)),
                title: const Text('Feedback & Suggestions'),
                onTap: () {
                  Navigator.pop(context);
                  _showSimplePage(context, 'Feedback & Suggestions');
                },
              ),
              ListTile(
                leading: const Icon(Icons.library_books_outlined, color: Color(0xFF00796B)),
                title: const Text('Document Library & Resources'),
                onTap: () {
                  Navigator.pop(context);
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DocumentLibraryPage(userId: widget.userId),
                    ),
                    );

                },
              ),
              ListTile(
                leading: const Icon(Icons.video_library_outlined, color: Color(0xFF00796B)),
                title: const Text('Multimedia & Explainers'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MultimediaCenterPage(userId: widget.userId),
                    ),
                    );
                },
              ),
              ListTile(
                leading: const Icon(Icons.star_outline, color: Color(0xFF00796B)),
                title: const Text('Success Stories & Testimonials'),
                onTap: () {
                  Navigator.pop(context);
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SuccessStoriesPage(userId: widget.userId),
                    ),
                    );
                },
              ),
              ListTile(
                leading: const Icon(Icons.star_outline, color: Color(0xFF00796B)),
                title: const Text('Interest Quiz & Career Assessment'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InterestQuizPage(userId: widget.userId),
                    ),
                    );
                },
              ),
            ],
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personalized Greeting Card (Fixed)
              StreamBuilder<DocumentSnapshot>(
                stream: db.collection('users').doc(widget.userId).snapshots(),
                builder: (context, snapshot) {
                  String name = 'Explorer';

                  if (snapshot.hasData && snapshot.data!.exists) {
                    var data = snapshot.data!.data() as Map<String, dynamic>?;
                    name = data?['name'] ?? data?['uname'] ?? 'Explorer';
                  }

                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00796B), Color(0xFF26A69A)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, $name!', 
                          style: const TextStyle(
                            color: Colors.white, 
                            fontSize: 22, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Here is your career progression overview.', 
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Dynamic Activity Stats
              const Text(
                'Activity & Results Summary', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
              ),
              const SizedBox(height: 10),
              StreamBuilder<DocumentSnapshot>(
                stream: db.collection('user_stats').doc(widget.userId).snapshots(),
                builder: (context, snapshot) {
                  int quizzes = 0;
                  int saved = 0;

                  if (snapshot.hasData && snapshot.data!.exists) {
                    var data = snapshot.data!.data() as Map<String, dynamic>?;
                    if (data != null) {
                      quizzes = data['quiz_questions'] ?? data['quizzes_taken'] ?? 0;
                      saved = data['saved_careers_count'] ?? 0;
                    }
                  }

                  return Row(
                    children: [
                      Expanded(child: _buildStatTile('Quizzes Taken', '$quizzes', Icons.quiz_outlined)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildStatTile('Saved Items', '$saved', Icons.bookmark_added_outlined)),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // Trending Careers Widget
              const Text(
                'Trending Careers For You', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
              ),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: db.collection('careers').limit(3).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  return Column(
                    children: snapshot.data!.docs.map((doc) {
                      var data = doc.data() as Map<String, dynamic>;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xFFB2DFDB),
                            child: Icon(Icons.work_outline, color: Color(0xFF00796B)),
                          ),
                          title: Text(
                            data['title'] ?? 'Career Role', 
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${data['domain'] ?? 'N/A'} | Salary: ${data['expected_salary'] ?? 'N/A'}'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF00796B)),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSimplePage(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: const Color(0xFFE0F2F1),
          appBar: AppBar(
            title: Text(title, style: const TextStyle(color: Colors.white)),
            backgroundColor: const Color(0xFF00796B),
          ),
          body: Center(
            child: Text(
              '$title Page',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatTile(String title, String count, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF00796B), size: 30),
            const SizedBox(height: 8),
            Text(
              count, 
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
            ),
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// 2. Dynamic Career Quiz Page with Real-time DB Fetch & Save
class DynamicQuizPage extends StatefulWidget {
  final String userId;
  const DynamicQuizPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<DynamicQuizPage> createState() => _DynamicQuizPageState();
}

class _DynamicQuizPageState extends State<DynamicQuizPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  int currentQuestionIndex = 0;
  int totalScore = 0;

  void saveQuizResult(int finalScore) async {
    await db.collection('quiz_results').add({
      'user_id': widget.userId,
      'score': finalScore,
      'recommended_domain': finalScore > 10 ? 'Technology' : 'Business',
      'taken_at': FieldValue.serverTimestamp(),
    });

    await db.collection('user_stats').doc(widget.userId).set({
      'quizzes_taken': FieldValue.increment(1),
    }, SetOptions(merge: true));

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text('Your Score: $finalScore\nResult saved to Database successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1),
      appBar: AppBar(
        title: const Text('Career Assessment Quiz', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF00796B),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('quizzes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No quiz questions found in Database.\nAdd documents in "quizzes" collection.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                ),
              ),
            );
          }

          var questions = snapshot.data!.docs;
          if (currentQuestionIndex >= questions.length) {
            return const Center(child: CircularProgressIndicator());
          }

          var currentQuestion = questions[currentQuestionIndex].data() as Map<String, dynamic>;
          List options = currentQuestion['options'] ?? [];

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Question ${currentQuestionIndex + 1} of ${questions.length}',
                  style: const TextStyle(color: Color(0xFF00796B), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  currentQuestion['question'] ?? 'Sample Question',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF004D40)),
                ),
                const SizedBox(height: 20),
                ...options.map((opt) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF00796B),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        int score = opt['score'] ?? 5;
                        totalScore += score;

                        if (currentQuestionIndex + 1 < questions.length) {
                          setState(() {
                            currentQuestionIndex++;
                          });
                        } else {
                          saveQuizResult(totalScore);
                        }
                      },
                      child: Text(opt['text'] ?? 'Option', style: const TextStyle(fontSize: 16)),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
