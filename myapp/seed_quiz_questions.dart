import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/firebase_options.dart';

// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await seedStudentQuiz();

  runApp(const SeedCompleteApp());
}

class SeedCompleteApp extends StatelessWidget {
  const SeedCompleteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('quiz_questions')
                .where('role', isEqualTo: 'student')
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              return Text(
                'Student quiz seeded successfully!\n'
                '${snapshot.data!.docs.length} questions found.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ============================================================
// QUESTION HELPER
// ============================================================

Map<String, dynamic> q({
  required String subject,
  required List<String> fields,
  required String question,
  required List<String> options,
  required String correctAnswer,
  String difficulty = "easy",
}) {
  return {
    "role": "student",
    "category": "career",
    "subject": subject,
    "fields": fields,
    "question": question,
    "options": options,
    "correctAnswer": correctAnswer,
    "difficulty": difficulty,
    "marks": 1,
    "createdAt": FieldValue.serverTimestamp(),
  };
}

// ============================================================
// STUDENT QUESTIONS - 70 TOTAL
// ============================================================

final List<Map<String, dynamic>> studentQuestions = [

  // ==========================================================
  // PHYSICS - 10
  // ALL THREE FIELDS
  // ==========================================================

  q(
    subject: "Physics",
    fields: ["computer", "medical", "engineering"],
    question: "What is the SI unit of force?",
    options: [
      "Joule",
      "Newton",
      "Watt",
      "Pascal",
    ],
    correctAnswer: "Newton",
  ),

  q(
    subject: "Physics",
    fields: ["computer", "medical", "engineering"],
    question: "What is the approximate speed of light in vacuum?",
    options: [
      "3 × 10^8 m/s",
      "3 × 10^6 m/s",
      "3 × 10^4 m/s",
      "3 × 10^2 m/s",
    ],
    correctAnswer: "3 × 10^8 m/s",
  ),

  q(
    subject: "Physics",
    fields: ["computer", "medical", "engineering"],
    question: "What is the SI unit of electric current?",
    options: [
      "Volt",
      "Ampere",
      "Ohm",
      "Watt",
    ],
    correctAnswer: "Ampere",
  ),

  q(
    subject: "Physics",
    fields: ["computer", "medical", "engineering"],
    question: "Which force pulls objects toward Earth?",
    options: [
      "Friction",
      "Magnetic force",
      "Gravity",
      "Tension",
    ],
    correctAnswer: "Gravity",
  ),

  q(
    subject: "Physics",
    fields: ["computer", "medical", "engineering"],
    question: "What is the formula for speed?",
    options: [
      "Distance × Time",
      "Distance / Time",
      "Time / Distance",
      "Mass / Time",
    ],
    correctAnswer: "Distance / Time",
  ),

  q(
    subject: "Physics",
    fields: ["computer", "medical", "engineering"],
    question: "Which quantity has both magnitude and direction?",
    options: [
      "Scalar",
      "Vector",
      "Mass",
      "Temperature",
    ],
    correctAnswer: "Vector",
  ),

  q(
    subject: "Physics",
    fields: ["computer", "medical", "engineering"],
    question: "What is the SI unit of power?",
    options: [
      "Joule",
      "Newton",
      "Watt",
      "Coulomb",
    ],
    correctAnswer: "Watt",
  ),

  q(
    subject: "Physics",
    fields: ["computer", "medical", "engineering"],
    question: "Which form of energy is associated with motion?",
    options: [
      "Potential energy",
      "Kinetic energy",
      "Chemical energy",
      "Nuclear energy",
    ],
    correctAnswer: "Kinetic energy",
  ),

  q(
    subject: "Physics",
    fields: ["computer", "medical", "engineering"],
    question: "What is acceleration?",
    options: [
      "Rate of change of velocity",
      "Distance divided by mass",
      "Force divided by time",
      "Energy divided by distance",
    ],
    correctAnswer: "Rate of change of velocity",
  ),

  q(
    subject: "Physics",
    fields: ["computer", "medical", "engineering"],
    question: "Which device converts electrical energy into light?",
    options: [
      "Motor",
      "Generator",
      "Electric bulb",
      "Transformer",
    ],
    correctAnswer: "Electric bulb",
  ),

  // ==========================================================
  // CHEMISTRY - 10
  // MEDICAL + ENGINEERING
  // ==========================================================

  q(
    subject: "Chemistry",
    fields: ["medical", "engineering"],
    question: "What is the chemical symbol for oxygen?",
    options: [
      "O",
      "Ox",
      "C",
      "H",
    ],
    correctAnswer: "O",
  ),

  q(
    subject: "Chemistry",
    fields: ["medical", "engineering"],
    question: "What is the pH of pure water at room temperature?",
    options: [
      "5",
      "6",
      "7",
      "9",
    ],
    correctAnswer: "7",
  ),

  q(
    subject: "Chemistry",
    fields: ["medical", "engineering"],
    question: "Which gas is essential for human respiration?",
    options: [
      "Nitrogen",
      "Oxygen",
      "Carbon dioxide",
      "Hydrogen",
    ],
    correctAnswer: "Oxygen",
  ),

  q(
    subject: "Chemistry",
    fields: ["medical", "engineering"],
    question: "What is H2O commonly known as?",
    options: [
      "Hydrogen peroxide",
      "Water",
      "Oxygen",
      "Hydrogen",
    ],
    correctAnswer: "Water",
  ),

  q(
    subject: "Chemistry",
    fields: ["medical", "engineering"],
    question: "Which particle has a negative charge?",
    options: [
      "Proton",
      "Neutron",
      "Electron",
      "Nucleus",
    ],
    correctAnswer: "Electron",
  ),

  q(
    subject: "Chemistry",
    fields: ["medical", "engineering"],
    question: "What is the atomic number of hydrogen?",
    options: [
      "1",
      "2",
      "8",
      "10",
    ],
    correctAnswer: "1",
  ),

  q(
    subject: "Chemistry",
    fields: ["medical", "engineering"],
    question: "Which element is represented by Na?",
    options: [
      "Nitrogen",
      "Sodium",
      "Neon",
      "Nickel",
    ],
    correctAnswer: "Sodium",
  ),

  q(
    subject: "Chemistry",
    fields: ["medical", "engineering"],
    question: "Which type of bond involves sharing electrons?",
    options: [
      "Ionic bond",
      "Covalent bond",
      "Metallic bond",
      "Hydrogen bond",
    ],
    correctAnswer: "Covalent bond",
  ),

  q(
    subject: "Chemistry",
    fields: ["medical", "engineering"],
    question: "Which gas is most abundant in Earth's atmosphere?",
    options: [
      "Oxygen",
      "Carbon dioxide",
      "Nitrogen",
      "Hydrogen",
    ],
    correctAnswer: "Nitrogen",
  ),

  q(
    subject: "Chemistry",
    fields: ["medical", "engineering"],
    question: "What is the process of changing a liquid into a gas called?",
    options: [
      "Condensation",
      "Freezing",
      "Evaporation",
      "Melting",
    ],
    correctAnswer: "Evaporation",
  ),

  // ==========================================================
  // MATHEMATICS - 10
  // COMPUTER + ENGINEERING
  // ==========================================================

  q(
    subject: "Mathematics",
    fields: ["computer", "engineering"],
    question: "What is 12 × 5?",
    options: [
      "50",
      "60",
      "70",
      "80",
    ],
    correctAnswer: "60",
  ),

  q(
    subject: "Mathematics",
    fields: ["computer", "engineering"],
    question: "What is the square of 9?",
    options: [
      "18",
      "72",
      "81",
      "90",
    ],
    correctAnswer: "81",
  ),

  q(
    subject: "Mathematics",
    fields: ["computer", "engineering"],
    question: "What is 25% of 200?",
    options: [
      "25",
      "40",
      "50",
      "75",
    ],
    correctAnswer: "50",
  ),

  q(
    subject: "Mathematics",
    fields: ["computer", "engineering"],
    question: "If x + 7 = 15, what is x?",
    options: [
      "6",
      "7",
      "8",
      "9",
    ],
    correctAnswer: "8",
  ),

  q(
    subject: "Mathematics",
    fields: ["computer", "engineering"],
    question: "What is 2³?",
    options: [
      "6",
      "8",
      "9",
      "12",
    ],
    correctAnswer: "8",
  ),

  q(
    subject: "Mathematics",
    fields: ["computer", "engineering"],
    question: "Which number is prime?",
    options: [
      "9",
      "15",
      "17",
      "21",
    ],
    correctAnswer: "17",
  ),

  q(
    subject: "Mathematics",
    fields: ["computer", "engineering"],
    question: "What is the average of 10 and 20?",
    options: [
      "10",
      "15",
      "20",
      "30",
    ],
    correctAnswer: "15",
  ),

  q(
    subject: "Mathematics",
    fields: ["computer", "engineering"],
    question: "What is the perimeter of a square with side 5 cm?",
    options: [
      "10 cm",
      "15 cm",
      "20 cm",
      "25 cm",
    ],
    correctAnswer: "20 cm",
  ),

  q(
    subject: "Mathematics",
    fields: ["computer", "engineering"],
    question: "What is 3/4 as a percentage?",
    options: [
      "25%",
      "50%",
      "75%",
      "80%",
    ],
    correctAnswer: "75%",
  ),

  q(
    subject: "Mathematics",
    fields: ["computer", "engineering"],
    question: "What is the next number: 2, 4, 8, 16, ?",
    options: [
      "18",
      "24",
      "32",
      "36",
    ],
    correctAnswer: "32",
  ),

  // ==========================================================
  // ENGLISH - 10
  // ALL FIELDS
  // ==========================================================

  q(
    subject: "English",
    fields: ["computer", "medical", "engineering"],
    question: "Choose the correct sentence.",
    options: [
      "He go to school.",
      "He goes to school.",
      "He going school.",
      "He gone school.",
    ],
    correctAnswer: "He goes to school.",
  ),

  q(
    subject: "English",
    fields: ["computer", "medical", "engineering"],
    question: "What is the synonym of 'happy'?",
    options: [
      "Sad",
      "Angry",
      "Joyful",
      "Weak",
    ],
    correctAnswer: "Joyful",
  ),

  q(
    subject: "English",
    fields: ["computer", "medical", "engineering"],
    question: "What is the opposite of 'ancient'?",
    options: [
      "Old",
      "Modern",
      "Historic",
      "Past",
    ],
    correctAnswer: "Modern",
  ),

  q(
    subject: "English",
    fields: ["computer", "medical", "engineering"],
    question: "Which word is a noun?",
    options: [
      "Run",
      "Beautiful",
      "Teacher",
      "Quickly",
    ],
    correctAnswer: "Teacher",
  ),

  q(
    subject: "English",
    fields: ["computer", "medical", "engineering"],
    question: "Choose the correct plural of 'child'.",
    options: [
      "Childs",
      "Childes",
      "Children",
      "Childrens",
    ],
    correctAnswer: "Children",
  ),

  q(
    subject: "English",
    fields: ["computer", "medical", "engineering"],
    question: "Which word is an adjective?",
    options: [
      "Quickly",
      "Beautiful",
      "Run",
      "Teacher",
    ],
    correctAnswer: "Beautiful",
  ),

  q(
    subject: "English",
    fields: ["computer", "medical", "engineering"],
    question: "Choose the correct article: 'He is ___ honest man.'",
    options: [
      "A",
      "An",
      "The",
      "No article",
    ],
    correctAnswer: "An",
  ),

  q(
    subject: "English",
    fields: ["computer", "medical", "engineering"],
    question: "What is the past tense of 'go'?",
    options: [
      "Goed",
      "Gone",
      "Went",
      "Going",
    ],
    correctAnswer: "Went",
  ),

  q(
    subject: "English",
    fields: ["computer", "medical", "engineering"],
    question: "What is the synonym of 'rapid'?",
    options: [
      "Slow",
      "Fast",
      "Weak",
      "Late",
    ],
    correctAnswer: "Fast",
  ),

  q(
    subject: "English",
    fields: ["computer", "medical", "engineering"],
    question: "Which sentence is in the future tense?",
    options: [
      "I eat food.",
      "I ate food.",
      "I am eating food.",
      "I will eat food.",
    ],
    correctAnswer: "I will eat food.",
  ),

  // ==========================================================
  // COMPUTER - 10
  // COMPUTER ONLY
  // ==========================================================

  q(
    subject: "Computer",
    fields: ["computer"],
    question: "What does CPU stand for?",
    options: [
      "Central Processing Unit",
      "Computer Personal Unit",
      "Central Program Utility",
      "Control Processing User",
    ],
    correctAnswer: "Central Processing Unit",
  ),

  q(
    subject: "Computer",
    fields: ["computer"],
    question: "Which device is mainly used to enter text?",
    options: [
      "Monitor",
      "Keyboard",
      "Speaker",
      "Printer",
    ],
    correctAnswer: "Keyboard",
  ),

  q(
    subject: "Computer",
    fields: ["computer"],
    question: "Which one is an operating system?",
    options: [
      "Windows",
      "Google",
      "HTML",
      "Python",
    ],
    correctAnswer: "Windows",
  ),

  q(
    subject: "Computer",
    fields: ["computer"],
    question: "Which component provides temporary memory?",
    options: [
      "SSD",
      "RAM",
      "Monitor",
      "Keyboard",
    ],
    correctAnswer: "RAM",
  ),

  q(
    subject: "Computer",
    fields: ["computer"],
    question: "Which of these is a programming language?",
    options: [
      "Python",
      "Chrome",
      "Windows",
      "Google",
    ],
    correctAnswer: "Python",
  ),

  q(
    subject: "Computer",
    fields: ["computer"],
    question: "What is the binary number system based on?",
    options: [
      "2",
      "8",
      "10",
      "16",
    ],
    correctAnswer: "2",
  ),

  q(
    subject: "Computer",
    fields: ["computer"],
    question: "Which device displays visual output?",
    options: [
      "Keyboard",
      "Monitor",
      "Mouse",
      "Microphone",
    ],
    correctAnswer: "Monitor",
  ),

  q(
    subject: "Computer",
    fields: ["computer"],
    question: "What does URL stand for?",
    options: [
      "Uniform Resource Locator",
      "Universal Routing Link",
      "User Resource Line",
      "Unified Reference Location",
    ],
    correctAnswer: "Uniform Resource Locator",
  ),

  q(
    subject: "Computer",
    fields: ["computer"],
    question: "Which application is used to browse websites?",
    options: [
      "Web browser",
      "Compiler",
      "Calculator",
      "File manager",
    ],
    correctAnswer: "Web browser",
  ),

  q(
    subject: "Computer",
    fields: ["computer"],
    question: "Which device is commonly used for permanent data storage?",
    options: [
      "RAM",
      "CPU",
      "SSD",
      "Cache",
    ],
    correctAnswer: "SSD",
  ),

  // ==========================================================
  // BIOLOGY - 10
  // MEDICAL ONLY
  // ==========================================================

  q(
    subject: "Biology",
    fields: ["medical"],
    question: "What is the basic unit of life?",
    options: [
      "Tissue",
      "Organ",
      "Cell",
      "Atom",
    ],
    correctAnswer: "Cell",
  ),

  q(
    subject: "Biology",
    fields: ["medical"],
    question: "Which organ pumps blood throughout the body?",
    options: [
      "Lungs",
      "Heart",
      "Kidney",
      "Liver",
    ],
    correctAnswer: "Heart",
  ),

  q(
    subject: "Biology",
    fields: ["medical"],
    question: "Which organ is mainly responsible for breathing?",
    options: [
      "Heart",
      "Liver",
      "Lungs",
      "Stomach",
    ],
    correctAnswer: "Lungs",
  ),

  q(
    subject: "Biology",
    fields: ["medical"],
    question: "Which blood cells help fight infections?",
    options: [
      "Red blood cells",
      "White blood cells",
      "Platelets",
      "Plasma",
    ],
    correctAnswer: "White blood cells",
  ),

  q(
    subject: "Biology",
    fields: ["medical"],
    question: "What molecule carries genetic information?",
    options: [
      "DNA",
      "Glucose",
      "Water",
      "Oxygen",
    ],
    correctAnswer: "DNA",
  ),

  q(
    subject: "Biology",
    fields: ["medical"],
    question: "Which organ filters waste from the blood?",
    options: [
      "Heart",
      "Kidney",
      "Lung",
      "Brain",
    ],
    correctAnswer: "Kidney",
  ),

  q(
    subject: "Biology",
    fields: ["medical"],
    question: "Which part of the cell contains genetic material?",
    options: [
      "Cell wall",
      "Nucleus",
      "Cytoplasm",
      "Membrane",
    ],
    correctAnswer: "Nucleus",
  ),

  q(
    subject: "Biology",
    fields: ["medical"],
    question: "Which system controls and coordinates body activities?",
    options: [
      "Digestive system",
      "Nervous system",
      "Respiratory system",
      "Skeletal system",
    ],
    correctAnswer: "Nervous system",
  ),

  q(
    subject: "Biology",
    fields: ["medical"],
    question: "Which vitamin is mainly produced in the skin through sunlight?",
    options: [
      "Vitamin A",
      "Vitamin B",
      "Vitamin C",
      "Vitamin D",
    ],
    correctAnswer: "Vitamin D",
  ),

  q(
    subject: "Biology",
    fields: ["medical"],
    question: "Which organ is primarily responsible for digestion of food?",
    options: [
      "Stomach",
      "Heart",
      "Brain",
      "Kidney",
    ],
    correctAnswer: "Stomach",
  ),

  // ==========================================================
  // PAKISTAN STUDIES - 10
  // ALL FIELDS
  // ==========================================================

  q(
    subject: "Pakistan Studies",
    fields: ["computer", "medical", "engineering"],
    question: "When did Pakistan become independent?",
    options: [
      "14 August 1947",
      "23 March 1940",
      "14 August 1945",
      "6 September 1947",
    ],
    correctAnswer: "14 August 1947",
  ),

  q(
    subject: "Pakistan Studies",
    fields: ["computer", "medical", "engineering"],
    question: "Who is known as the founder of Pakistan?",
    options: [
      "Allama Iqbal",
      "Quaid-e-Azam Muhammad Ali Jinnah",
      "Liaquat Ali Khan",
      "Sir Syed Ahmad Khan",
    ],
    correctAnswer: "Quaid-e-Azam Muhammad Ali Jinnah",
  ),

  q(
    subject: "Pakistan Studies",
    fields: ["computer", "medical", "engineering"],
    question: "What is the national language of Pakistan?",
    options: [
      "Punjabi",
      "Sindhi",
      "Urdu",
      "English",
    ],
    correctAnswer: "Urdu",
  ),

  q(
    subject: "Pakistan Studies",
    fields: ["computer", "medical", "engineering"],
    question: "What is the capital of Pakistan?",
    options: [
      "Karachi",
      "Lahore",
      "Islamabad",
      "Peshawar",
    ],
    correctAnswer: "Islamabad",
  ),

  q(
    subject: "Pakistan Studies",
    fields: ["computer", "medical", "engineering"],
    question: "Who presented the Allahabad Address in 1930?",
    options: [
      "Quaid-e-Azam",
      "Allama Muhammad Iqbal",
      "Sir Syed Ahmad Khan",
      "Liaquat Ali Khan",
    ],
    correctAnswer: "Allama Muhammad Iqbal",
  ),

  q(
    subject: "Pakistan Studies",
    fields: ["computer", "medical", "engineering"],
    question: "The Lahore Resolution was passed in which year?",
    options: [
      "1930",
      "1935",
      "1940",
      "1947",
    ],
    correctAnswer: "1940",
  ),

  q(
    subject: "Pakistan Studies",
    fields: ["computer", "medical", "engineering"],
    question: "What is the national flower of Pakistan?",
    options: [
      "Rose",
      "Jasmine",
      "Sunflower",
      "Tulip",
    ],
    correctAnswer: "Jasmine",
  ),

  q(
    subject: "Pakistan Studies",
    fields: ["computer", "medical", "engineering"],
    question: "What is the national animal of Pakistan?",
    options: [
      "Lion",
      "Markhor",
      "Tiger",
      "Deer",
    ],
    correctAnswer: "Markhor",
  ),

  q(
    subject: "Pakistan Studies",
    fields: ["computer", "medical", "engineering"],
    question: "Which is the largest province of Pakistan by area?",
    options: [
      "Punjab",
      "Sindh",
      "Balochistan",
      "Khyber Pakhtunkhwa",
    ],
    correctAnswer: "Balochistan",
  ),

  q(
    subject: "Pakistan Studies",
    fields: ["computer", "medical", "engineering"],
    question: "What is the highest mountain in Pakistan?",
    options: [
      "Nanga Parbat",
      "K2",
      "Rakaposhi",
      "Tirich Mir",
    ],
    correctAnswer: "K2",
  ),
];


// ============================================================
// SEED FUNCTION
// ============================================================

Future<void> seedStudentQuiz() async {
  final firestore = FirebaseFirestore.instance;

  print("========================================");
  print("STUDENT QUIZ SEED STARTED");
  print("========================================");

  print("Total questions: ${studentQuestions.length}");

  // ----------------------------------------------------------
  // DELETE OLD STUDENT QUESTIONS
  // ----------------------------------------------------------

  final oldQuestions = await firestore
      .collection("quiz_questions")
      .where("role", isEqualTo: "student")
      .get();

  print("Old student questions: ${oldQuestions.docs.length}");

  // Delete old documents in batches
  WriteBatch deleteBatch = firestore.batch();

  int deleteCounter = 0;

  for (final doc in oldQuestions.docs) {
    deleteBatch.delete(doc.reference);
    deleteCounter++;

    if (deleteCounter == 400) {
      await deleteBatch.commit();
      deleteBatch = firestore.batch();
      deleteCounter = 0;
    }
  }

  if (deleteCounter > 0) {
    await deleteBatch.commit();
  }

  print("Old student questions deleted.");

  // ----------------------------------------------------------
  // ADD NEW QUESTIONS
  // ----------------------------------------------------------

  WriteBatch batch = firestore.batch();

  int counter = 0;

  for (final quizQuestion in studentQuestions) {
    final docRef = firestore.collection("quiz_questions").doc();

    batch.set(docRef, quizQuestion);

    counter++;

    if (counter == 400) {
      await batch.commit();

      batch = firestore.batch();
      counter = 0;
    }
  }

  if (counter > 0) {
    await batch.commit();
  }

  // ----------------------------------------------------------
  // VERIFY
  // ----------------------------------------------------------

  final result = await firestore
      .collection("quiz_questions")
      .where("role", isEqualTo: "student")
      .get();

  print("");
  print("========================================");
  print("STUDENT QUIZ SEED COMPLETE");
  print("========================================");
  print("Student questions: ${result.docs.length}");
  print("");
  print("Physics          : 10");
  print("Chemistry        : 10");
  print("Mathematics      : 10");
  print("English          : 10");
  print("Computer         : 10");
  print("Biology          : 10");
  print("Pakistan Studies : 10");
  print("----------------------------------------");
  print("TOTAL            : 70");
  print("========================================");
}