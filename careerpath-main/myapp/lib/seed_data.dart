// seed_data.dart
// One-time script to auto-create Firestore collections with dummy data.
// HOW TO USE:
// 1. Add this file to your lib/ folder.
// 2. Import it in main.dart: import 'seed_data.dart';
// 3. Call `await seedData();` ONCE after Firebase.initializeApp() in main().
// 4. Run the app once (flutter run), let it finish, then REMOVE/COMMENT
//    the seedData() call so it doesn't run again and duplicate data.

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> seedData() async {
  final db = FirebaseFirestore.instance;

  // ---------- 1. CAREERS ----------
  final careers = [
    {
      "title": "Software Engineer",
      "description": "Designs, builds and maintains software applications.",
      "domain": "Tech",
      "required_skills": ["Programming", "Problem Solving", "DSA"],
      "education_path": "BS Computer Science / Software Engineering",
      "expected_salary": "PKR 80,000 - 250,000/month"
    },
    {
      "title": "Data Analyst",
      "description": "Analyzes data to help businesses make decisions.",
      "domain": "Tech",
      "required_skills": ["Excel", "SQL", "Statistics"],
      "education_path": "BS Statistics / Data Science",
      "expected_salary": "PKR 60,000 - 180,000/month"
    },
    {
      "title": "Registered Nurse",
      "description": "Provides patient care and supports doctors in hospitals.",
      "domain": "Healthcare",
      "required_skills": ["Patient Care", "Communication", "First Aid"],
      "education_path": "BSN (Bachelor of Science in Nursing)",
      "expected_salary": "PKR 40,000 - 100,000/month"
    },
    {
      "title": "Marketing Manager",
      "description": "Plans and executes marketing campaigns for a brand.",
      "domain": "Business",
      "required_skills": ["Communication", "Creativity", "Analytics"],
      "education_path": "BBA / MBA Marketing",
      "expected_salary": "PKR 70,000 - 200,000/month"
    },
    {
      "title": "Graphic Designer",
      "description": "Creates visual concepts for digital and print media.",
      "domain": "Creative",
      "required_skills": ["Adobe Photoshop", "Illustrator", "Creativity"],
      "education_path": "BS Visual Arts / Design",
      "expected_salary": "PKR 40,000 - 120,000/month"
    },
    {
      "title": "Financial Analyst",
      "description": "Evaluates financial data to guide investment decisions.",
      "domain": "Business",
      "required_skills": ["Excel", "Finance", "Analytical Thinking"],
      "education_path": "BBA Finance / ACCA",
      "expected_salary": "PKR 60,000 - 190,000/month"
    },
    {
      "title": "UI/UX Designer",
      "description": "Designs user-friendly interfaces for apps and websites.",
      "domain": "Tech",
      "required_skills": ["Figma", "User Research", "Prototyping"],
      "education_path": "BS Design / Self-taught + Portfolio",
      "expected_salary": "PKR 60,000 - 180,000/month"
    },
    {
      "title": "Civil Engineer",
      "description": "Designs and oversees construction of infrastructure projects.",
      "domain": "Engineering",
      "required_skills": ["AutoCAD", "Structural Analysis", "Project Management"],
      "education_path": "BS Civil Engineering",
      "expected_salary": "PKR 60,000 - 200,000/month"
    },
  ];

  await Future.wait(
    careers.map((career) => db.collection("careers").add(career)),
  );
  print("✅ Careers added (${careers.length})");

  // ---------- 2. QUIZ QUESTIONS ----------
  final quizQuestions = [
    {
      "question_text": "Do you enjoy solving logical puzzles?",
      "options": ["Yes, love it", "Sometimes", "Not really"],
      "correct_answer": "Yes, love it",
      "domain_tag": "Tech"
    },
    {
      "question_text": "Do you prefer working with numbers and data?",
      "options": ["Yes", "A little", "No"],
      "correct_answer": "Yes",
      "domain_tag": "Business"
    },
    {
      "question_text": "Do you like helping and caring for people?",
      "options": ["Yes, always", "Sometimes", "Not my thing"],
      "correct_answer": "Yes, always",
      "domain_tag": "Healthcare"
    },
    {
      "question_text": "Are you interested in visual design and creativity?",
      "options": ["Yes", "Somewhat", "No"],
      "correct_answer": "Yes",
      "domain_tag": "Creative"
    },
    {
      "question_text": "Do you enjoy planning and managing projects?",
      "options": ["Yes", "Maybe", "No"],
      "correct_answer": "Yes",
      "domain_tag": "Business"
    },
    {
      "question_text": "Are you comfortable working with computers/code?",
      "options": ["Very comfortable", "Learning", "Not comfortable"],
      "correct_answer": "Very comfortable",
      "domain_tag": "Tech"
    },
    {
      "question_text": "Do you like building or fixing physical structures/machines?",
      "options": ["Yes", "Sometimes", "No"],
      "correct_answer": "Yes",
      "domain_tag": "Engineering"
    },
    {
      "question_text": "Do you enjoy public speaking or presenting ideas?",
      "options": ["Yes", "A bit nervous but yes", "No"],
      "correct_answer": "Yes",
      "domain_tag": "Business"
    },
    {
      "question_text": "Would you enjoy working night shifts in a hospital?",
      "options": ["Yes", "Occasionally", "No"],
      "correct_answer": "Yes",
      "domain_tag": "Healthcare"
    },
    {
      "question_text": "Do you like sketching, drawing or editing images/videos?",
      "options": ["Yes", "Sometimes", "No"],
      "correct_answer": "Yes",
      "domain_tag": "Creative"
    },
  ];

  await Future.wait(
    quizQuestions.map((q) => db.collection("quizQuestions").add(q)),
  );
  print("✅ Quiz questions added (${quizQuestions.length})");

  // ---------- 3. RESOURCES ----------
  final resources = [
    {
      "title": "Resume Writing Checklist",
      "category": "Beginner",
      "file_url": "https://example.com/resume-checklist.pdf",
      "tag": "Career Prep"
    },
    {
      "title": "Interview Preparation Guide",
      "category": "Beginner",
      "file_url": "https://example.com/interview-guide.pdf",
      "tag": "Career Prep"
    },
    {
      "title": "Scholarship Opportunities 2026",
      "category": "Scholarship",
      "file_url": "https://example.com/scholarships.pdf",
      "tag": "Student"
    },
    {
      "title": "Skill-Building Roadmap for Tech Careers",
      "category": "Skill-Building",
      "file_url": "https://example.com/tech-roadmap.pdf",
      "tag": "Tech"
    },
    {
      "title": "LinkedIn Profile Optimization Tips",
      "category": "Intermediate",
      "file_url": "https://example.com/linkedin-tips.pdf",
      "tag": "Career Prep"
    },
    {
      "title": "Career Switch Guide for Professionals",
      "category": "Advanced",
      "file_url": "https://example.com/career-switch.pdf",
      "tag": "Professional"
    },
  ];

  await Future.wait(
    resources.map((r) => db.collection("resources").add(r)),
  );
  print("✅ Resources added (${resources.length})");

  // ---------- 4. SUCCESS STORIES ----------
  final stories = [
    {
      "rname": "Ayesha Khan",
      "domain": "Tech",
      "story_text":
          "Started as a self-taught coder, now working as a Software Engineer at a top firm.",
      "image_url": "",
      "approved": true
    },
    {
      "rname": "Bilal Ahmed",
      "domain": "Business",
      "story_text":
          "Switched from engineering to marketing and now leads a brand team.",
      "image_url": "",
      "approved": true
    },
    {
      "rname": "Sana Malik",
      "domain": "Healthcare",
      "story_text":
          "Completed her BSN and now works as a Registered Nurse in a leading city hospital.",
      "image_url": "",
      "approved": true
    },
    {
      "rname": "Hassan Raza",
      "domain": "Creative",
      "story_text":
          "Built a portfolio through freelancing and is now a full-time Graphic Designer for a media agency.",
      "image_url": "",
      "approved": true
    },
    {
      "rname": "Fatima Sheikh",
      "domain": "Engineering",
      "story_text":
          "Graduated in Civil Engineering and now leads infrastructure projects at a construction firm.",
      "image_url": "",
      "approved": true
    },
  ];

  await Future.wait(
    stories.map((s) => db.collection("successStories").add(s)),
  );
  print("✅ Success stories added (${stories.length})");

  // ---------- 5. FEEDBACK (leave empty, users will fill this via app) ----------
  // No seeding needed - collection auto-creates on first real submission.

  print("✅ Seeding complete! Check Firebase console for new collections.");
}