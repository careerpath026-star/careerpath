import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await seedGraduateQuiz();

  runApp(const GraduateSeedCompleteApp());
}

class GraduateSeedCompleteApp extends StatelessWidget {
  const GraduateSeedCompleteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('quiz_questions')
                .where('role', isEqualTo: 'graduate')
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              return Text(
                'Graduate quiz seeded successfully!\n'
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

Map<String, dynamic> g({
  required String category,
  required String subject,
  required String question,
  required List<String> options,
  required String correctAnswer,
  String difficulty = "advanced",
}) {
  return {
    "role": "graduate",
    "category": category,
    "subject": subject,
    "question": question,
    "options": options,
    "correctAnswer": correctAnswer,
    "difficulty": difficulty,
    "marks": 1,
    "createdAt": FieldValue.serverTimestamp(),
  };
}

// ============================================================
// GRADUATE QUESTIONS
// TOTAL = 210
// 7 CATEGORIES × 30 QUESTIONS
// ============================================================

final List<Map<String, dynamic>> graduateQuestions = [

  // ==========================================================
  // CATEGORY 1
  // SOFTWARE DEVELOPMENT - 30
  // ==========================================================

  // ---------- Programming - 10 ----------

  g(
    category: "Software Development",
    subject: "Programming",
    question: "Which principle recommends that a class should have only one reason to change?",
    options: [
      "Open/Closed Principle",
      "Single Responsibility Principle",
      "Dependency Inversion Principle",
      "Interface Segregation Principle",
    ],
    correctAnswer: "Single Responsibility Principle",
  ),

  g(
    category: "Software Development",
    subject: "Programming",
    question: "What is the average time complexity of hash table lookup when collisions are handled efficiently?",
    options: [
      "O(1)",
      "O(log n)",
      "O(n)",
      "O(n log n)",
    ],
    correctAnswer: "O(1)",
  ),

  g(
    category: "Software Development",
    subject: "Programming",
    question: "Which data structure follows the LIFO principle?",
    options: [
      "Queue",
      "Stack",
      "Linked List",
      "Heap",
    ],
    correctAnswer: "Stack",
  ),

  g(
    category: "Software Development",
    subject: "Programming",
    question: "What is recursion primarily based on?",
    options: [
      "A function calling itself",
      "Multiple inheritance",
      "Database indexing",
      "Parallel execution",
    ],
    correctAnswer: "A function calling itself",
  ),

  g(
    category: "Software Development",
    subject: "Programming",
    question: "Which algorithm is commonly used to find the shortest path in a weighted graph with non-negative edge weights?",
    options: [
      "Dijkstra's algorithm",
      "Binary Search",
      "Merge Sort",
      "Kruskal's algorithm",
    ],
    correctAnswer: "Dijkstra's algorithm",
  ),

  g(
    category: "Software Development",
    subject: "Programming",
    question: "Which sorting algorithm has an average time complexity of O(n log n)?",
    options: [
      "Bubble Sort",
      "Insertion Sort",
      "Merge Sort",
      "Linear Search",
    ],
    correctAnswer: "Merge Sort",
  ),

  g(
    category: "Software Development",
    subject: "Programming",
    question: "What does encapsulation primarily achieve in object-oriented programming?",
    options: [
      "Hiding implementation details",
      "Removing all inheritance",
      "Eliminating objects",
      "Increasing database size",
    ],
    correctAnswer: "Hiding implementation details",
  ),

  g(
    category: "Software Development",
    subject: "Programming",
    question: "Which concept allows different classes to respond differently to the same interface?",
    options: [
      "Polymorphism",
      "Compilation",
      "Serialization",
      "Indexing",
    ],
    correctAnswer: "Polymorphism",
  ),

  g(
    category: "Software Development",
    subject: "Programming",
    question: "Which traversal is commonly used to explore a graph level by level?",
    options: [
      "DFS",
      "BFS",
      "Binary Search",
      "Hashing",
    ],
    correctAnswer: "BFS",
  ),

  g(
    category: "Software Development",
    subject: "Programming",
    question: "What is the main advantage of a binary search algorithm?",
    options: [
      "It works on unsorted data",
      "It reduces search space by half",
      "It always uses constant memory",
      "It requires hashing",
    ],
    correctAnswer: "It reduces search space by half",
  ),

  // ---------- Software Architecture - 10 ----------

  g(
    category: "Software Development",
    subject: "Software Architecture",
    question: "Which architecture separates an application into presentation, business logic, and data layers?",
    options: [
      "Three-tier architecture",
      "Peer-to-peer architecture",
      "Bus architecture",
      "Ring architecture",
    ],
    correctAnswer: "Three-tier architecture",
  ),

  g(
    category: "Software Development",
    subject: "Software Architecture",
    question: "What is a major characteristic of microservices architecture?",
    options: [
      "All functionality exists in one module",
      "Services are independently deployable",
      "Database is always shared",
      "Only one programming language is allowed",
    ],
    correctAnswer: "Services are independently deployable",
  ),

  g(
    category: "Software Development",
    subject: "Software Architecture",
    question: "What is the primary purpose of an API gateway?",
    options: [
      "Compile source code",
      "Provide a single entry point for services",
      "Store passwords",
      "Replace databases",
    ],
    correctAnswer: "Provide a single entry point for services",
  ),

  g(
    category: "Software Development",
    subject: "Software Architecture",
    question: "Which design pattern creates objects without exposing the exact instantiation logic?",
    options: [
      "Factory Pattern",
      "Observer Pattern",
      "Adapter Pattern",
      "Iterator Pattern",
    ],
    correctAnswer: "Factory Pattern",
  ),

  g(
    category: "Software Development",
    subject: "Software Architecture",
    question: "What does loose coupling between modules generally improve?",
    options: [
      "Maintainability",
      "Code duplication",
      "Memory consumption only",
      "Hardware speed",
    ],
    correctAnswer: "Maintainability",
  ),

  g(
    category: "Software Development",
    subject: "Software Architecture",
    question: "Which pattern is useful when multiple objects need to be notified about state changes?",
    options: [
      "Observer",
      "Factory",
      "Singleton",
      "Builder",
    ],
    correctAnswer: "Observer",
  ),

  g(
    category: "Software Development",
    subject: "Software Architecture",
    question: "What is the main purpose of dependency injection?",
    options: [
      "Reduce dependency coupling",
      "Increase global variables",
      "Remove testing",
      "Encrypt source code",
    ],
    correctAnswer: "Reduce dependency coupling",
  ),

  g(
    category: "Software Development",
    subject: "Software Architecture",
    question: "Which architectural style commonly exposes resources through HTTP methods such as GET and POST?",
    options: [
      "REST",
      "BIOS",
      "SMTP",
      "FTP only",
    ],
    correctAnswer: "REST",
  ),

  g(
    category: "Software Development",
    subject: "Software Architecture",
    question: "What is horizontal scaling?",
    options: [
      "Adding more instances",
      "Increasing CPU of one machine",
      "Reducing memory",
      "Removing servers",
    ],
    correctAnswer: "Adding more instances",
  ),

  g(
    category: "Software Development",
    subject: "Software Architecture",
    question: "What is caching primarily used for?",
    options: [
      "Reducing repeated expensive operations",
      "Deleting source code",
      "Increasing database normalization",
      "Replacing authentication",
    ],
    correctAnswer: "Reducing repeated expensive operations",
  ),

  // ---------- Software Engineering - 10 ----------

  g(
    category: "Software Development",
    subject: "Software Engineering",
    question: "What is the main purpose of unit testing?",
    options: [
      "Test individual components",
      "Test the entire production network",
      "Replace documentation",
      "Deploy applications",
    ],
    correctAnswer: "Test individual components",
  ),

  g(
    category: "Software Development",
    subject: "Software Engineering",
    question: "Which development practice integrates code changes frequently into a shared repository?",
    options: [
      "Continuous Integration",
      "Waterfall",
      "Big Bang Development",
      "Manual Deployment",
    ],
    correctAnswer: "Continuous Integration",
  ),

  g(
    category: "Software Development",
    subject: "Software Engineering",
    question: "What is regression testing intended to detect?",
    options: [
      "New defects introduced by changes",
      "Internet speed",
      "Database size",
      "User passwords",
    ],
    correctAnswer: "New defects introduced by changes",
  ),

  g(
    category: "Software Development",
    subject: "Software Engineering",
    question: "What does CI/CD primarily automate?",
    options: [
      "Building, testing, and deployment",
      "Hardware manufacturing",
      "User registration only",
      "Database design only",
    ],
    correctAnswer: "Building, testing, and deployment",
  ),

  g(
    category: "Software Development",
    subject: "Software Engineering",
    question: "Which methodology emphasizes iterative development and frequent customer feedback?",
    options: [
      "Agile",
      "Waterfall",
      "Big Bang",
      "Spiral only",
    ],
    correctAnswer: "Agile",
  ),

  g(
    category: "Software Development",
    subject: "Software Engineering",
    question: "What is technical debt?",
    options: [
      "Future cost caused by quick or poor technical decisions",
      "Database storage cost",
      "Cloud subscription fee",
      "Developer salary",
    ],
    correctAnswer: "Future cost caused by quick or poor technical decisions",
  ),

  g(
    category: "Software Development",
    subject: "Software Engineering",
    question: "What is code refactoring?",
    options: [
      "Improving internal code structure without changing behavior",
      "Adding random features",
      "Deleting tests",
      "Changing hardware",
    ],
    correctAnswer: "Improving internal code structure without changing behavior",
  ),

  g(
    category: "Software Development",
    subject: "Software Engineering",
    question: "Which testing technique checks how multiple modules work together?",
    options: [
      "Integration testing",
      "Unit testing",
      "Syntax testing",
      "Static typing",
    ],
    correctAnswer: "Integration testing",
  ),

  g(
    category: "Software Development",
    subject: "Software Engineering",
    question: "What is version control primarily used for?",
    options: [
      "Tracking changes to source code",
      "Increasing CPU speed",
      "Encrypting databases automatically",
      "Hosting websites only",
    ],
    correctAnswer: "Tracking changes to source code",
  ),

  g(
    category: "Software Development",
    subject: "Software Engineering",
    question: "Which metric is commonly associated with software complexity?",
    options: [
      "Cyclomatic complexity",
      "Bandwidth",
      "CPU temperature",
      "Pixel density",
    ],
    correctAnswer: "Cyclomatic complexity",
  ),

  // ==========================================================
  // CATEGORY 2
  // DATA SCIENCE & ARTIFICIAL INTELLIGENCE - 30
  // ==========================================================

  // ---------- Data Science - 10 ----------

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Data Science",
    question: "What is the primary purpose of feature scaling?",
    options: [
      "Put numerical features on comparable scales",
      "Delete categorical data",
      "Increase dataset size",
      "Remove all outliers",
    ],
    correctAnswer: "Put numerical features on comparable scales",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Data Science",
    question: "Which measure is less sensitive to extreme outliers?",
    options: [
      "Mean",
      "Median",
      "Variance",
      "Standard deviation",
    ],
    correctAnswer: "Median",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Data Science",
    question: "What does a confusion matrix evaluate?",
    options: [
      "Classification performance",
      "Database normalization",
      "Network bandwidth",
      "Source code complexity",
    ],
    correctAnswer: "Classification performance",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Data Science",
    question: "What is the purpose of a validation dataset?",
    options: [
      "Tune model parameters and compare models",
      "Replace the training dataset",
      "Store passwords",
      "Increase CPU speed",
    ],
    correctAnswer: "Tune model parameters and compare models",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Data Science",
    question: "What does correlation measure?",
    options: [
      "Association between variables",
      "Causation in every case",
      "Database size",
      "Model memory usage",
    ],
    correctAnswer: "Association between variables",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Data Science",
    question: "Which technique is commonly used to reduce dimensionality?",
    options: [
      "PCA",
      "HTTP",
      "DNS",
      "CRUD",
    ],
    correctAnswer: "PCA",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Data Science",
    question: "What is data leakage?",
    options: [
      "Using information during training that should be unavailable",
      "Deleting training data",
      "Encrypting data",
      "Compressing data",
    ],
    correctAnswer: "Using information during training that should be unavailable",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Data Science",
    question: "What is an outlier?",
    options: [
      "An unusually distant observation",
      "The average observation",
      "A missing column",
      "A duplicated table",
    ],
    correctAnswer: "An unusually distant observation",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Data Science",
    question: "Which metric is commonly used for regression error?",
    options: [
      "Mean Squared Error",
      "Accuracy",
      "Precision",
      "Recall",
    ],
    correctAnswer: "Mean Squared Error",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Data Science",
    question: "What does normalization commonly do to numerical data?",
    options: [
      "Transforms values to a specified range",
      "Deletes categorical variables",
      "Creates neural networks",
      "Removes labels",
    ],
    correctAnswer: "Transforms values to a specified range",
  ),

  // ---------- Machine Learning - 10 ----------

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Machine Learning",
    question: "What is overfitting?",
    options: [
      "A model performs well on training data but poorly on unseen data",
      "A model cannot learn training data",
      "A dataset contains no labels",
      "A model has no parameters",
    ],
    correctAnswer: "A model performs well on training data but poorly on unseen data",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Machine Learning",
    question: "Which learning type uses labeled training examples?",
    options: [
      "Supervised learning",
      "Unsupervised learning",
      "Reinforcement learning",
      "Random learning",
    ],
    correctAnswer: "Supervised learning",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Machine Learning",
    question: "Which algorithm is commonly used for binary classification?",
    options: [
      "Logistic Regression",
      "K-Means only",
      "PCA",
      "Apriori only",
    ],
    correctAnswer: "Logistic Regression",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Machine Learning",
    question: "What is regularization used for?",
    options: [
      "Reducing overfitting",
      "Increasing label leakage",
      "Removing validation data",
      "Increasing model complexity without control",
    ],
    correctAnswer: "Reducing overfitting",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Machine Learning",
    question: "Which algorithm groups data into clusters without predefined labels?",
    options: [
      "K-Means",
      "Linear Regression",
      "Logistic Regression",
      "Naive Bayes",
    ],
    correctAnswer: "K-Means",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Machine Learning",
    question: "What is a hyperparameter?",
    options: [
      "A configuration value set outside the learned model parameters",
      "A prediction",
      "A training label",
      "A database key",
    ],
    correctAnswer: "A configuration value set outside the learned model parameters",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Machine Learning",
    question: "What does cross-validation help estimate?",
    options: [
      "Model performance on unseen data",
      "Hard disk capacity",
      "Network latency",
      "CPU temperature",
    ],
    correctAnswer: "Model performance on unseen data",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Machine Learning",
    question: "What is precision in classification?",
    options: [
      "Correct positive predictions divided by all positive predictions",
      "Correct predictions divided by all samples",
      "True negatives divided by all samples",
      "False positives divided by true positives",
    ],
    correctAnswer: "Correct positive predictions divided by all positive predictions",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Machine Learning",
    question: "What is recall?",
    options: [
      "True positives divided by actual positives",
      "True positives divided by predicted positives",
      "True negatives divided by actual negatives",
      "False positives divided by all predictions",
    ],
    correctAnswer: "True positives divided by actual positives",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "Machine Learning",
    question: "Which method combines multiple weak learners to form a stronger model?",
    options: [
      "Ensemble learning",
      "Normalization",
      "Tokenization",
      "Indexing",
    ],
    correctAnswer: "Ensemble learning",
  ),

  // ---------- AI & Deep Learning - 10 ----------

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "AI & Deep Learning",
    question: "What is the basic computational unit of a neural network?",
    options: [
      "Neuron",
      "Router",
      "Compiler",
      "Index",
    ],
    correctAnswer: "Neuron",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "AI & Deep Learning",
    question: "What is an activation function used for?",
    options: [
      "Introducing non-linearity",
      "Storing databases",
      "Encrypting passwords",
      "Connecting networks",
    ],
    correctAnswer: "Introducing non-linearity",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "AI & Deep Learning",
    question: "Which architecture is particularly effective for image recognition?",
    options: [
      "CNN",
      "FTP",
      "DNS",
      "SQL",
    ],
    correctAnswer: "CNN",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "AI & Deep Learning",
    question: "Which architecture is commonly associated with sequence processing?",
    options: [
      "RNN",
      "CNN only",
      "Hash table",
      "Binary tree",
    ],
    correctAnswer: "RNN",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "AI & Deep Learning",
    question: "What is backpropagation used for?",
    options: [
      "Computing gradients for updating neural network weights",
      "Creating database indexes",
      "Routing network packets",
      "Compressing images",
    ],
    correctAnswer: "Computing gradients for updating neural network weights",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "AI & Deep Learning",
    question: "What does a learning rate control?",
    options: [
      "The step size of parameter updates",
      "The number of database tables",
      "The network bandwidth",
      "The image resolution",
    ],
    correctAnswer: "The step size of parameter updates",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "AI & Deep Learning",
    question: "Which technology is strongly associated with modern large language models?",
    options: [
      "Transformer architecture",
      "Bubble Sort",
      "FTP",
      "Relational indexing",
    ],
    correctAnswer: "Transformer architecture",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "AI & Deep Learning",
    question: "What is an embedding generally used to represent?",
    options: [
      "Data as numerical vectors",
      "Passwords as plain text",
      "IP addresses only",
      "Database tables physically",
    ],
    correctAnswer: "Data as numerical vectors",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "AI & Deep Learning",
    question: "What is reinforcement learning based on?",
    options: [
      "Learning through rewards and penalties",
      "Only labeled datasets",
      "Only clustering",
      "Database transactions",
    ],
    correctAnswer: "Learning through rewards and penalties",
  ),

  g(
    category: "Data Science & Artificial Intelligence",
    subject: "AI & Deep Learning",
    question: "What problem can dropout help reduce in neural networks?",
    options: [
      "Overfitting",
      "Network latency",
      "Database duplication",
      "Disk fragmentation",
    ],
    correctAnswer: "Overfitting",
  ),

  // ==========================================================
  // CATEGORY 3
  // CYBERSECURITY - 30
  // ==========================================================

  // ---------- Network Security - 10 ----------

  g(
    category: "Cybersecurity",
    subject: "Network Security",
    question: "Which security principle ensures that information is accessible when required?",
    options: [
      "Availability",
      "Confidentiality",
      "Integrity",
      "Non-repudiation",
    ],
    correctAnswer: "Availability",
  ),

  g(
    category: "Cybersecurity",
    subject: "Network Security",
    question: "What is the primary purpose of a firewall?",
    options: [
      "Control network traffic according to security rules",
      "Increase CPU speed",
      "Store passwords",
      "Compile programs",
    ],
    correctAnswer: "Control network traffic according to security rules",
  ),

  g(
    category: "Cybersecurity",
    subject: "Network Security",
    question: "Which protocol provides encrypted web communication?",
    options: [
      "HTTPS",
      "HTTP",
      "FTP",
      "Telnet",
    ],
    correctAnswer: "HTTPS",
  ),

  g(
    category: "Cybersecurity",
    subject: "Network Security",
    question: "What does VPN primarily provide?",
    options: [
      "An encrypted connection over a network",
      "A replacement for an operating system",
      "A database engine",
      "A programming language",
    ],
    correctAnswer: "An encrypted connection over a network",
  ),

  g(
    category: "Cybersecurity",
    subject: "Network Security",
    question: "Which attack overwhelms a service with excessive traffic?",
    options: [
      "DDoS",
      "Phishing",
      "SQL Injection",
      "Privilege Escalation",
    ],
    correctAnswer: "DDoS",
  ),

  g(
    category: "Cybersecurity",
    subject: "Network Security",
    question: "What does IDS stand for?",
    options: [
      "Intrusion Detection System",
      "Internet Data Service",
      "Internal Database Security",
      "Integrated Domain Server",
    ],
    correctAnswer: "Intrusion Detection System",
  ),

  g(
    category: "Cybersecurity",
    subject: "Network Security",
    question: "Which protocol is generally preferred over Telnet for secure remote administration?",
    options: [
      "SSH",
      "HTTP",
      "SMTP",
      "DNS",
    ],
    correctAnswer: "SSH",
  ),

  g(
    category: "Cybersecurity",
    subject: "Network Security",
    question: "What does network segmentation help achieve?",
    options: [
      "Limit the spread of attacks",
      "Increase password length automatically",
      "Remove encryption",
      "Disable authentication",
    ],
    correctAnswer: "Limit the spread of attacks",
  ),

  g(
    category: "Cybersecurity",
    subject: "Network Security",
    question: "What is a zero-day vulnerability?",
    options: [
      "A vulnerability unknown or without an available patch at discovery",
      "A vulnerability that has existed for exactly zero days",
      "A deleted vulnerability",
      "A physical network failure",
    ],
    correctAnswer: "A vulnerability unknown or without an available patch at discovery",
  ),

  g(
    category: "Cybersecurity",
    subject: "Network Security",
    question: "What does TLS primarily protect?",
    options: [
      "Data in transit",
      "CPU instructions",
      "Hard disk mechanics",
      "Source code formatting",
    ],
    correctAnswer: "Data in transit",
  ),

  // ---------- Application Security - 10 ----------

  g(
    category: "Cybersecurity",
    subject: "Application Security",
    question: "What type of attack injects malicious SQL statements into application queries?",
    options: [
      "SQL Injection",
      "DDoS",
      "Brute Force",
      "ARP Spoofing",
    ],
    correctAnswer: "SQL Injection",
  ),

  g(
    category: "Cybersecurity",
    subject: "Application Security",
    question: "Which technique helps prevent SQL injection?",
    options: [
      "Parameterized queries",
      "Plain text passwords",
      "Disabling validation",
      "Using longer URLs",
    ],
    correctAnswer: "Parameterized queries",
  ),

  g(
    category: "Cybersecurity",
    subject: "Application Security",
    question: "What is XSS?",
    options: [
      "Cross-Site Scripting",
      "Extended Security System",
      "Cross Server Storage",
      "External Session Service",
    ],
    correctAnswer: "Cross-Site Scripting",
  ),

  g(
    category: "Cybersecurity",
    subject: "Application Security",
    question: "Which attack targets a user's authenticated session?",
    options: [
      "Session hijacking",
      "Data normalization",
      "Load balancing",
      "Code compilation",
    ],
    correctAnswer: "Session hijacking",
  ),

  g(
    category: "Cybersecurity",
    subject: "Application Security",
    question: "Why should passwords be hashed instead of stored as plain text?",
    options: [
      "To avoid storing the original password directly",
      "To increase screen resolution",
      "To reduce database tables",
      "To disable authentication",
    ],
    correctAnswer: "To avoid storing the original password directly",
  ),

  g(
    category: "Cybersecurity",
    subject: "Application Security",
    question: "What is authentication?",
    options: [
      "Verifying identity",
      "Assigning permissions",
      "Encrypting every file",
      "Backing up data",
    ],
    correctAnswer: "Verifying identity",
  ),

  g(
    category: "Cybersecurity",
    subject: "Application Security",
    question: "What is authorization?",
    options: [
      "Determining what an authenticated user is allowed to access",
      "Verifying identity",
      "Encrypting passwords",
      "Creating backups",
    ],
    correctAnswer: "Determining what an authenticated user is allowed to access",
  ),

  g(
    category: "Cybersecurity",
    subject: "Application Security",
    question: "What does input validation help prevent?",
    options: [
      "Unexpected or malicious input",
      "CPU overheating",
      "Low battery",
      "Network cable damage",
    ],
    correctAnswer: "Unexpected or malicious input",
  ),

  g(
    category: "Cybersecurity",
    subject: "Application Security",
    question: "What is rate limiting useful for?",
    options: [
      "Reducing abuse from excessive requests",
      "Increasing database size",
      "Removing authentication",
      "Changing programming languages",
    ],
    correctAnswer: "Reducing abuse from excessive requests",
  ),

  g(
    category: "Cybersecurity",
    subject: "Application Security",
    question: "What is the principle of least privilege?",
    options: [
      "Give users only the permissions they need",
      "Give everyone administrator access",
      "Disable authorization",
      "Use one password for all users",
    ],
    correctAnswer: "Give users only the permissions they need",
  ),

  // ---------- Cryptography - 10 ----------

  g(
    category: "Cybersecurity",
    subject: "Cryptography",
    question: "What is symmetric encryption?",
    options: [
      "The same secret key is used for encryption and decryption",
      "Different public and private keys are always used",
      "No key is required",
      "Only hashing is performed",
    ],
    correctAnswer: "The same secret key is used for encryption and decryption",
  ),

  g(
    category: "Cybersecurity",
    subject: "Cryptography",
    question: "Which is an asymmetric cryptographic algorithm?",
    options: [
      "RSA",
      "AES",
      "SHA-256",
      "MD5",
    ],
    correctAnswer: "RSA",
  ),

  g(
    category: "Cybersecurity",
    subject: "Cryptography",
    question: "What is hashing primarily used for?",
    options: [
      "Creating a fixed-size representation of data",
      "Reversible encryption",
      "Increasing bandwidth",
      "Routing packets",
    ],
    correctAnswer: "Creating a fixed-size representation of data",
  ),

  g(
    category: "Cybersecurity",
    subject: "Cryptography",
    question: "Which property means data has not been altered?",
    options: [
      "Integrity",
      "Availability",
      "Confidentiality",
      "Scalability",
    ],
    correctAnswer: "Integrity",
  ),

  g(
    category: "Cybersecurity",
    subject: "Cryptography",
    question: "What is a digital signature primarily used for?",
    options: [
      "Authenticity and integrity verification",
      "Compressing files",
      "Increasing CPU performance",
      "Replacing databases",
    ],
    correctAnswer: "Authenticity and integrity verification",
  ),

  g(
    category: "Cybersecurity",
    subject: "Cryptography",
    question: "Which algorithm is commonly used for modern symmetric encryption?",
    options: [
      "AES",
      "RSA",
      "ECC",
      "Diffie-Hellman",
    ],
    correctAnswer: "AES",
  ),

  g(
    category: "Cybersecurity",
    subject: "Cryptography",
    question: "What is salting used for in password storage?",
    options: [
      "Adding unique random data before hashing",
      "Encrypting network packets",
      "Increasing password visibility",
      "Removing passwords",
    ],
    correctAnswer: "Adding unique random data before hashing",
  ),

  g(
    category: "Cybersecurity",
    subject: "Cryptography",
    question: "What is public-key cryptography based on?",
    options: [
      "A public key and a private key",
      "One shared password only",
      "No mathematical operations",
      "Database indexes",
    ],
    correctAnswer: "A public key and a private key",
  ),

  g(
    category: "Cybersecurity",
    subject: "Cryptography",
    question: "Which attack attempts many possible passwords automatically?",
    options: [
      "Brute-force attack",
      "Man-in-the-middle",
      "DDoS",
      "SQL injection",
    ],
    correctAnswer: "Brute-force attack",
  ),

  g(
    category: "Cybersecurity",
    subject: "Cryptography",
    question: "What security property does encryption primarily provide?",
    options: [
      "Confidentiality",
      "Availability",
      "Scalability",
      "Compression",
    ],
    correctAnswer: "Confidentiality",
  ),

  // ==========================================================
  // CATEGORY 4
  // NETWORKING & CLOUD COMPUTING - 30
  // ==========================================================

  // ---------- Networking - 10 ----------

  g(
    category: "Networking & Cloud Computing",
    subject: "Networking",
    question: "Which OSI layer is responsible for routing packets?",
    options: [
      "Network",
      "Transport",
      "Session",
      "Presentation",
    ],
    correctAnswer: "Network",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Networking",
    question: "Which protocol translates domain names into IP addresses?",
    options: [
      "DNS",
      "DHCP",
      "FTP",
      "SMTP",
    ],
    correctAnswer: "DNS",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Networking",
    question: "What is the primary function of DHCP?",
    options: [
      "Automatically assign network configuration",
      "Encrypt HTTP traffic",
      "Transfer email",
      "Resolve domain names",
    ],
    correctAnswer: "Automatically assign network configuration",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Networking",
    question: "Which protocol provides reliable connection-oriented transport?",
    options: [
      "TCP",
      "UDP",
      "IP",
      "ARP",
    ],
    correctAnswer: "TCP",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Networking",
    question: "Which protocol is connectionless and generally has lower overhead?",
    options: [
      "UDP",
      "TCP",
      "HTTPS",
      "SSH",
    ],
    correctAnswer: "UDP",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Networking",
    question: "What is subnetting used for?",
    options: [
      "Dividing a network into smaller logical networks",
      "Encrypting passwords",
      "Increasing CPU speed",
      "Compiling applications",
    ],
    correctAnswer: "Dividing a network into smaller logical networks",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Networking",
    question: "What does NAT primarily do?",
    options: [
      "Translates private and public IP addresses",
      "Encrypts passwords",
      "Stores DNS records",
      "Compiles code",
    ],
    correctAnswer: "Translates private and public IP addresses",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Networking",
    question: "Which device primarily forwards packets between networks?",
    options: [
      "Router",
      "Keyboard",
      "Printer",
      "Monitor",
    ],
    correctAnswer: "Router",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Networking",
    question: "Which IP version uses 128-bit addresses?",
    options: [
      "IPv6",
      "IPv4",
      "IPv5",
      "IPv2",
    ],
    correctAnswer: "IPv6",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Networking",
    question: "What is latency?",
    options: [
      "Time taken for data to travel between endpoints",
      "Total storage capacity",
      "CPU clock speed",
      "Number of users",
    ],
    correctAnswer: "Time taken for data to travel between endpoints",
  ),

  // ---------- Cloud Computing - 10 ----------

  g(
    category: "Networking & Cloud Computing",
    subject: "Cloud Computing",
    question: "Which cloud model provides virtualized infrastructure such as virtual machines?",
    options: [
      "IaaS",
      "SaaS",
      "PaaS",
      "DBaaS only",
    ],
    correctAnswer: "IaaS",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Cloud Computing",
    question: "Which model provides a platform for deploying applications without managing the underlying infrastructure?",
    options: [
      "PaaS",
      "IaaS",
      "SaaS",
      "LAN",
    ],
    correctAnswer: "PaaS",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Cloud Computing",
    question: "Which model delivers complete software applications over the internet?",
    options: [
      "SaaS",
      "IaaS",
      "PaaS",
      "Bare Metal",
    ],
    correctAnswer: "SaaS",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Cloud Computing",
    question: "What does cloud elasticity mean?",
    options: [
      "Resources can scale according to demand",
      "Resources can never change",
      "Data is always stored locally",
      "Servers cannot be replicated",
    ],
    correctAnswer: "Resources can scale according to demand",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Cloud Computing",
    question: "What is a container primarily used for?",
    options: [
      "Packaging an application with its dependencies",
      "Replacing a network router",
      "Encrypting every database",
      "Increasing monitor resolution",
    ],
    correctAnswer: "Packaging an application with its dependencies",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Cloud Computing",
    question: "Which technology is commonly used to orchestrate containers?",
    options: [
      "Kubernetes",
      "DNS",
      "SMTP",
      "FTP",
    ],
    correctAnswer: "Kubernetes",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Cloud Computing",
    question: "What is serverless computing?",
    options: [
      "Running code without managing servers directly",
      "Using no computers",
      "Disabling backend systems",
      "Using only physical servers",
    ],
    correctAnswer: "Running code without managing servers directly",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Cloud Computing",
    question: "What is auto-scaling used for?",
    options: [
      "Automatically adjusting resources based on demand",
      "Encrypting source code",
      "Creating passwords",
      "Replacing databases",
    ],
    correctAnswer: "Automatically adjusting resources based on demand",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Cloud Computing",
    question: "What is high availability designed to minimize?",
    options: [
      "Service downtime",
      "Database records",
      "CPU instructions",
      "User accounts",
    ],
    correctAnswer: "Service downtime",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Cloud Computing",
    question: "What is load balancing used for?",
    options: [
      "Distributing traffic across multiple servers",
      "Encrypting files",
      "Creating source code",
      "Assigning passwords",
    ],
    correctAnswer: "Distributing traffic across multiple servers",
  ),

  // ---------- Distributed Systems - 10 ----------

  g(
    category: "Networking & Cloud Computing",
    subject: "Distributed Systems",
    question: "What is replication?",
    options: [
      "Maintaining copies of data or services",
      "Deleting duplicate data",
      "Compressing code",
      "Encrypting passwords",
    ],
    correctAnswer: "Maintaining copies of data or services",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Distributed Systems",
    question: "What is fault tolerance?",
    options: [
      "Ability to continue operating despite component failures",
      "Ability to avoid all bugs",
      "Increasing CPU frequency",
      "Deleting failed servers",
    ],
    correctAnswer: "Ability to continue operating despite component failures",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Distributed Systems",
    question: "What does eventual consistency mean?",
    options: [
      "Replicas become consistent after some time",
      "All replicas are always immediately identical",
      "No data is replicated",
      "Transactions never complete",
    ],
    correctAnswer: "Replicas become consistent after some time",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Distributed Systems",
    question: "What is horizontal scaling in distributed systems?",
    options: [
      "Adding more machines or service instances",
      "Increasing RAM on one machine",
      "Reducing network traffic",
      "Deleting nodes",
    ],
    correctAnswer: "Adding more machines or service instances",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Distributed Systems",
    question: "What is a message queue used for?",
    options: [
      "Asynchronous communication between components",
      "Rendering UI elements",
      "Encrypting passwords",
      "Replacing operating systems",
    ],
    correctAnswer: "Asynchronous communication between components",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Distributed Systems",
    question: "What is a distributed cache used for?",
    options: [
      "Sharing frequently accessed data across service instances",
      "Replacing all databases",
      "Compiling applications",
      "Managing keyboards",
    ],
    correctAnswer: "Sharing frequently accessed data across service instances",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Distributed Systems",
    question: "What does CAP theorem discuss?",
    options: [
      "Consistency, Availability, and Partition tolerance",
      "CPU, API, and Processing",
      "Cloud, Application, and Programming",
      "Caching, Authentication, and Passwords",
    ],
    correctAnswer: "Consistency, Availability, and Partition tolerance",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Distributed Systems",
    question: "What is a service registry commonly used for?",
    options: [
      "Service discovery",
      "Password hashing",
      "Image compression",
      "Source code formatting",
    ],
    correctAnswer: "Service discovery",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Distributed Systems",
    question: "What is idempotency important for in distributed APIs?",
    options: [
      "Repeated requests can produce the same intended result",
      "Every request creates unlimited records",
      "Requests cannot be retried",
      "Authentication is removed",
    ],
    correctAnswer: "Repeated requests can produce the same intended result",
  ),

  g(
    category: "Networking & Cloud Computing",
    subject: "Distributed Systems",
    question: "What is observability primarily concerned with?",
    options: [
      "Understanding system behavior through logs, metrics, and traces",
      "Designing UI colors",
      "Writing passwords",
      "Increasing screen size",
    ],
    correctAnswer: "Understanding system behavior through logs, metrics, and traces",
  ),

  // ==========================================================
  // CATEGORY 5
  // ENGINEERING & TECHNOLOGY - 30
  // ==========================================================

  // ---------- Electrical Engineering - 10 ----------

  g(
    category: "Engineering & Technology",
    subject: "Electrical Engineering",
    question: "Ohm's law relates voltage, current, and what quantity?",
    options: [
      "Resistance",
      "Power factor only",
      "Frequency only",
      "Capacitance only",
    ],
    correctAnswer: "Resistance",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Electrical Engineering",
    question: "Which component stores energy in an electric field?",
    options: [
      "Capacitor",
      "Inductor",
      "Resistor",
      "Transformer",
    ],
    correctAnswer: "Capacitor",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Electrical Engineering",
    question: "Which component stores energy in a magnetic field?",
    options: [
      "Inductor",
      "Capacitor",
      "Resistor",
      "Diode",
    ],
    correctAnswer: "Inductor",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Electrical Engineering",
    question: "What is electrical power measured in?",
    options: [
      "Watt",
      "Ohm",
      "Volt",
      "Ampere-hour",
    ],
    correctAnswer: "Watt",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Electrical Engineering",
    question: "What does a transformer primarily change?",
    options: [
      "AC voltage level",
      "DC frequency",
      "Resistance of every circuit",
      "Battery chemistry",
    ],
    correctAnswer: "AC voltage level",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Electrical Engineering",
    question: "Which semiconductor device allows current to primarily flow in one direction?",
    options: [
      "Diode",
      "Capacitor",
      "Transformer",
      "Resistor",
    ],
    correctAnswer: "Diode",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Electrical Engineering",
    question: "What is the unit of electrical resistance?",
    options: [
      "Ohm",
      "Watt",
      "Volt",
      "Tesla",
    ],
    correctAnswer: "Ohm",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Electrical Engineering",
    question: "What does an inverter generally convert?",
    options: [
      "DC to AC",
      "AC to DC only",
      "Mechanical to thermal",
      "Heat to light",
    ],
    correctAnswer: "DC to AC",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Electrical Engineering",
    question: "Which instrument measures electrical current?",
    options: [
      "Ammeter",
      "Voltmeter",
      "Ohmmeter only",
      "Thermometer",
    ],
    correctAnswer: "Ammeter",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Electrical Engineering",
    question: "What does frequency represent in an AC waveform?",
    options: [
      "Number of cycles per second",
      "Maximum voltage only",
      "Resistance",
      "Power consumption only",
    ],
    correctAnswer: "Number of cycles per second",
  ),

  // ---------- Mechanical Engineering - 10 ----------

  g(
    category: "Engineering & Technology",
    subject: "Mechanical Engineering",
    question: "What is Newton's second law commonly expressed as?",
    options: [
      "F = ma",
      "E = mc²",
      "V = IR",
      "P = VI",
    ],
    correctAnswer: "F = ma",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Mechanical Engineering",
    question: "What is torque?",
    options: [
      "Rotational effect of a force",
      "Linear temperature",
      "Electrical resistance",
      "Fluid density",
    ],
    correctAnswer: "Rotational effect of a force",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Mechanical Engineering",
    question: "Which quantity represents resistance to change in rotational motion?",
    options: [
      "Moment of inertia",
      "Voltage",
      "Pressure",
      "Conductance",
    ],
    correctAnswer: "Moment of inertia",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Mechanical Engineering",
    question: "What is the SI unit of pressure?",
    options: [
      "Pascal",
      "Newton",
      "Joule",
      "Watt",
    ],
    correctAnswer: "Pascal",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Mechanical Engineering",
    question: "What is the purpose of lubrication in mechanical systems?",
    options: [
      "Reduce friction and wear",
      "Increase corrosion",
      "Increase surface roughness",
      "Remove all heat generation",
    ],
    correctAnswer: "Reduce friction and wear",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Mechanical Engineering",
    question: "Which process removes material using a rotating cutting tool?",
    options: [
      "Milling",
      "Casting",
      "Forging",
      "Welding",
    ],
    correctAnswer: "Milling",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Mechanical Engineering",
    question: "What is tensile stress related to?",
    options: [
      "Pulling force per unit area",
      "Twisting only",
      "Temperature change only",
      "Fluid flow",
    ],
    correctAnswer: "Pulling force per unit area",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Mechanical Engineering",
    question: "Which mechanism converts rotary motion into reciprocating motion?",
    options: [
      "Crank-slider mechanism",
      "Transformer",
      "Diode",
      "Heat exchanger",
    ],
    correctAnswer: "Crank-slider mechanism",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Mechanical Engineering",
    question: "What does CAD stand for?",
    options: [
      "Computer-Aided Design",
      "Computer Automatic Drive",
      "Central Application Database",
      "Controlled Assembly Device",
    ],
    correctAnswer: "Computer-Aided Design",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Mechanical Engineering",
    question: "What is fatigue failure generally caused by?",
    options: [
      "Repeated cyclic loading",
      "One-time temperature measurement",
      "Database errors",
      "Network congestion",
    ],
    correctAnswer: "Repeated cyclic loading",
  ),

  // ---------- Civil & Emerging Technology - 10 ----------

  g(
    category: "Engineering & Technology",
    subject: "Civil & Emerging Technology",
    question: "What property describes a material's ability to withstand deformation under load?",
    options: [
      "Strength",
      "Color",
      "Density only",
      "Conductivity only",
    ],
    correctAnswer: "Strength",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Civil & Emerging Technology",
    question: "What is reinforced concrete?",
    options: [
      "Concrete strengthened using reinforcement such as steel",
      "Pure steel",
      "Pure plastic",
      "Unmixed cement only",
    ],
    correctAnswer: "Concrete strengthened using reinforcement such as steel",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Civil & Emerging Technology",
    question: "What is BIM commonly used for?",
    options: [
      "Building information modeling",
      "Battery information management",
      "Binary instruction mapping",
      "Business internet monitoring",
    ],
    correctAnswer: "Building information modeling",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Civil & Emerging Technology",
    question: "What does IoT refer to?",
    options: [
      "Internet of Things",
      "Input Operating Technology",
      "Internal Online Transfer",
      "Internet Output Terminal",
    ],
    correctAnswer: "Internet of Things",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Civil & Emerging Technology",
    question: "What is additive manufacturing commonly known as?",
    options: [
      "3D printing",
      "CNC milling",
      "Forging",
      "Casting only",
    ],
    correctAnswer: "3D printing",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Civil & Emerging Technology",
    question: "Which technology enables machines to exchange data through connected sensors?",
    options: [
      "IoT",
      "CRT",
      "BIOS",
      "FTP",
    ],
    correctAnswer: "IoT",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Civil & Emerging Technology",
    question: "What is a digital twin?",
    options: [
      "A digital representation of a physical system",
      "A duplicate password",
      "A second operating system",
      "A network cable",
    ],
    correctAnswer: "A digital representation of a physical system",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Civil & Emerging Technology",
    question: "Which technology is commonly used for autonomous vehicle perception?",
    options: [
      "Computer vision",
      "SMTP",
      "SQL",
      "DNS",
    ],
    correctAnswer: "Computer vision",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Civil & Emerging Technology",
    question: "What does robotics combine?",
    options: [
      "Mechanical, electrical, and computational systems",
      "Only civil engineering",
      "Only databases",
      "Only chemistry",
    ],
    correctAnswer: "Mechanical, electrical, and computational systems",
  ),

  g(
    category: "Engineering & Technology",
    subject: "Civil & Emerging Technology",
    question: "What is predictive maintenance designed to do?",
    options: [
      "Predict equipment failures before they occur",
      "Increase equipment failures",
      "Remove sensors",
      "Disable monitoring",
    ],
    correctAnswer: "Predict equipment failures before they occur",
  ),

  // ==========================================================
  // CATEGORY 6
  // HEALTHCARE & LIFE SCIENCES - 30
  // ==========================================================

  // ---------- Biology & Genetics - 10 ----------

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biology & Genetics",
    question: "What is the basic functional unit of the human kidney?",
    options: [
      "Nephron",
      "Neuron",
      "Alveolus",
      "Osteon",
    ],
    correctAnswer: "Nephron",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biology & Genetics",
    question: "Which molecule carries genetic information in most organisms?",
    options: [
      "DNA",
      "ATP",
      "Glucose",
      "Lipid",
    ],
    correctAnswer: "DNA",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biology & Genetics",
    question: "What is transcription?",
    options: [
      "DNA information being copied into RNA",
      "Protein being converted into DNA",
      "RNA being converted directly into glucose",
      "Cell division only",
    ],
    correctAnswer: "DNA information being copied into RNA",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biology & Genetics",
    question: "What is translation in molecular biology?",
    options: [
      "RNA information being used to synthesize protein",
      "DNA replication",
      "Cell membrane formation",
      "Glucose breakdown only",
    ],
    correctAnswer: "RNA information being used to synthesize protein",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biology & Genetics",
    question: "Which organelle is primarily responsible for ATP production?",
    options: [
      "Mitochondrion",
      "Ribosome",
      "Nucleus",
      "Golgi apparatus",
    ],
    correctAnswer: "Mitochondrion",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biology & Genetics",
    question: "What is a mutation?",
    options: [
      "A change in genetic material",
      "Normal blood circulation",
      "A type of protein",
      "A digestive enzyme",
    ],
    correctAnswer: "A change in genetic material",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biology & Genetics",
    question: "Which cells are primarily responsible for producing antibodies?",
    options: [
      "B cells",
      "Red blood cells",
      "Platelets",
      "Neurons",
    ],
    correctAnswer: "B cells",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biology & Genetics",
    question: "What is homeostasis?",
    options: [
      "Maintenance of stable internal conditions",
      "Rapid cell division",
      "Genetic mutation",
      "Protein destruction",
    ],
    correctAnswer: "Maintenance of stable internal conditions",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biology & Genetics",
    question: "What is apoptosis?",
    options: [
      "Programmed cell death",
      "Uncontrolled bacterial growth",
      "Protein synthesis",
      "DNA replication",
    ],
    correctAnswer: "Programmed cell death",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biology & Genetics",
    question: "Which molecule is the main energy currency of cells?",
    options: [
      "ATP",
      "DNA",
      "RNA",
      "Collagen",
    ],
    correctAnswer: "ATP",
  ),

  // ---------- Medicine - 10 ----------

  g(
    category: "Healthcare & Life Sciences",
    subject: "Medicine",
    question: "Which blood vessels carry blood away from the heart?",
    options: [
      "Arteries",
      "Veins",
      "Capillaries",
      "Venules only",
    ],
    correctAnswer: "Arteries",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Medicine",
    question: "Which part of the brain is primarily associated with balance and coordination?",
    options: [
      "Cerebellum",
      "Medulla",
      "Hypothalamus",
      "Spinal cord",
    ],
    correctAnswer: "Cerebellum",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Medicine",
    question: "What is the main function of hemoglobin?",
    options: [
      "Transport oxygen",
      "Digest proteins",
      "Produce hormones",
      "Filter urine",
    ],
    correctAnswer: "Transport oxygen",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Medicine",
    question: "Which organ primarily filters blood to form urine?",
    options: [
      "Kidneys",
      "Liver",
      "Heart",
      "Pancreas",
    ],
    correctAnswer: "Kidneys",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Medicine",
    question: "Which hormone primarily lowers blood glucose?",
    options: [
      "Insulin",
      "Adrenaline",
      "Thyroxine",
      "Cortisol",
    ],
    correctAnswer: "Insulin",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Medicine",
    question: "What is hypertension?",
    options: [
      "Persistently elevated blood pressure",
      "Low blood sugar",
      "Low body temperature",
      "Reduced heart rate only",
    ],
    correctAnswer: "Persistently elevated blood pressure",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Medicine",
    question: "Which system is primarily responsible for transporting hormones and nutrients through blood?",
    options: [
      "Circulatory system",
      "Skeletal system",
      "Respiratory system",
      "Nervous system",
    ],
    correctAnswer: "Circulatory system",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Medicine",
    question: "What is the main function of the alveoli?",
    options: [
      "Gas exchange",
      "Blood filtration",
      "Hormone production",
      "Food digestion",
    ],
    correctAnswer: "Gas exchange",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Medicine",
    question: "Which blood component is primarily involved in clotting?",
    options: [
      "Platelets",
      "Red blood cells",
      "Plasma glucose",
      "Neurons",
    ],
    correctAnswer: "Platelets",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Medicine",
    question: "What is an ECG primarily used to record?",
    options: [
      "Electrical activity of the heart",
      "Lung volume only",
      "Blood glucose",
      "Kidney filtration",
    ],
    correctAnswer: "Electrical activity of the heart",
  ),

  // ---------- Biotechnology - 10 ----------

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biotechnology",
    question: "What is PCR primarily used for?",
    options: [
      "Amplifying DNA",
      "Measuring blood pressure",
      "Separating proteins only",
      "Producing ATP",
    ],
    correctAnswer: "Amplifying DNA",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biotechnology",
    question: "What is CRISPR commonly associated with?",
    options: [
      "Gene editing",
      "Blood pressure measurement",
      "X-ray imaging",
      "Protein digestion",
    ],
    correctAnswer: "Gene editing",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biotechnology",
    question: "What is a plasmid?",
    options: [
      "A small circular DNA molecule commonly found in bacteria",
      "A type of protein",
      "A blood cell",
      "A tissue",
    ],
    correctAnswer: "A small circular DNA molecule commonly found in bacteria",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biotechnology",
    question: "What is recombinant DNA?",
    options: [
      "DNA formed by combining genetic material from different sources",
      "Damaged RNA",
      "Protein without amino acids",
      "Synthetic glucose",
    ],
    correctAnswer: "DNA formed by combining genetic material from different sources",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biotechnology",
    question: "What is gel electrophoresis commonly used for?",
    options: [
      "Separating DNA fragments by size",
      "Measuring heart rate",
      "Growing bones",
      "Producing hormones",
    ],
    correctAnswer: "Separating DNA fragments by size",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biotechnology",
    question: "What is bioinformatics?",
    options: [
      "Application of computing to biological data",
      "Study of mechanical systems",
      "Network routing",
      "Financial accounting",
    ],
    correctAnswer: "Application of computing to biological data",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biotechnology",
    question: "What is a genome?",
    options: [
      "The complete genetic material of an organism",
      "A single protein",
      "A single chromosome only",
      "A type of tissue",
    ],
    correctAnswer: "The complete genetic material of an organism",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biotechnology",
    question: "What is a vaccine designed to do?",
    options: [
      "Stimulate an immune response",
      "Replace all antibiotics",
      "Increase blood pressure",
      "Destroy every cell",
    ],
    correctAnswer: "Stimulate an immune response",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biotechnology",
    question: "What is cell culture?",
    options: [
      "Growing cells under controlled laboratory conditions",
      "Counting network packets",
      "Building databases",
      "Measuring electrical current",
    ],
    correctAnswer: "Growing cells under controlled laboratory conditions",
  ),

  g(
    category: "Healthcare & Life Sciences",
    subject: "Biotechnology",
    question: "What is gene expression?",
    options: [
      "The process by which genetic information is used to produce functional products",
      "Deletion of every gene",
      "Cell death only",
      "DNA storage only",
    ],
    correctAnswer: "The process by which genetic information is used to produce functional products",
  ),

  // ==========================================================
  // CATEGORY 7
  // BUSINESS & PROFESSIONAL SKILLS - 30
  // ==========================================================

  // ---------- Business Management - 10 ----------

  g(
    category: "Business & Professional Skills",
    subject: "Business Management",
    question: "What is SWOT analysis used for?",
    options: [
      "Analyzing strengths, weaknesses, opportunities, and threats",
      "Calculating employee salaries only",
      "Programming databases",
      "Designing network protocols",
    ],
    correctAnswer: "Analyzing strengths, weaknesses, opportunities, and threats",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Business Management",
    question: "What is a KPI?",
    options: [
      "Key Performance Indicator",
      "Known Process Interface",
      "Key Programming Instruction",
      "Knowledge Performance Index",
    ],
    correctAnswer: "Key Performance Indicator",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Business Management",
    question: "What is stakeholder management?",
    options: [
      "Managing relationships with people affected by a project or organization",
      "Managing computer memory",
      "Managing source code",
      "Managing network packets",
    ],
    correctAnswer: "Managing relationships with people affected by a project or organization",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Business Management",
    question: "What is project scope?",
    options: [
      "The boundaries and work included in a project",
      "The project budget only",
      "The employee list only",
      "The server capacity",
    ],
    correctAnswer: "The boundaries and work included in a project",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Business Management",
    question: "What is risk management?",
    options: [
      "Identifying, assessing, and responding to risks",
      "Eliminating all uncertainty",
      "Increasing project costs",
      "Removing project objectives",
    ],
    correctAnswer: "Identifying, assessing, and responding to risks",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Business Management",
    question: "What does ROI measure?",
    options: [
      "Return relative to investment",
      "Number of employees",
      "Network bandwidth",
      "Database size",
    ],
    correctAnswer: "Return relative to investment",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Business Management",
    question: "What is delegation?",
    options: [
      "Assigning responsibility or tasks to others",
      "Avoiding all responsibility",
      "Removing employees",
      "Increasing project scope",
    ],
    correctAnswer: "Assigning responsibility or tasks to others",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Business Management",
    question: "What is a business process?",
    options: [
      "A structured sequence of activities producing a business outcome",
      "A programming language",
      "A network protocol",
      "A database index",
    ],
    correctAnswer: "A structured sequence of activities producing a business outcome",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Business Management",
    question: "What is strategic planning concerned with?",
    options: [
      "Long-term goals and direction",
      "Only daily attendance",
      "Only software bugs",
      "Only network configuration",
    ],
    correctAnswer: "Long-term goals and direction",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Business Management",
    question: "What is a competitive advantage?",
    options: [
      "A factor that allows an organization to outperform competitors",
      "A database feature",
      "A network protocol",
      "A programming syntax",
    ],
    correctAnswer: "A factor that allows an organization to outperform competitors",
  ),

  // ---------- Finance & Economics - 10 ----------

  g(
    category: "Business & Professional Skills",
    subject: "Finance & Economics",
    question: "What is revenue?",
    options: [
      "Income generated from business activities",
      "Total debt only",
      "Employee count",
      "Operating temperature",
    ],
    correctAnswer: "Income generated from business activities",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Finance & Economics",
    question: "What is profit?",
    options: [
      "Revenue minus expenses",
      "Revenue plus debt",
      "Expenses minus revenue",
      "Assets divided by employees",
    ],
    correctAnswer: "Revenue minus expenses",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Finance & Economics",
    question: "What is an asset?",
    options: [
      "A resource with economic value controlled by an entity",
      "Only a business expense",
      "Only employee salary",
      "A tax penalty",
    ],
    correctAnswer: "A resource with economic value controlled by an entity",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Finance & Economics",
    question: "What is a liability?",
    options: [
      "An obligation owed by an entity",
      "Business revenue",
      "Customer satisfaction",
      "Market share",
    ],
    correctAnswer: "An obligation owed by an entity",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Finance & Economics",
    question: "What is inflation?",
    options: [
      "A general increase in price levels",
      "A decrease in all prices",
      "Increase in production only",
      "Decrease in money supply only",
    ],
    correctAnswer: "A general increase in price levels",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Finance & Economics",
    question: "What is cash flow?",
    options: [
      "Movement of cash into and out of a business",
      "Profit only",
      "Total assets only",
      "Number of customers",
    ],
    correctAnswer: "Movement of cash into and out of a business",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Finance & Economics",
    question: "What is break-even point?",
    options: [
      "Point where total revenue equals total costs",
      "Point of maximum profit",
      "Point where revenue is zero",
      "Point where all assets are sold",
    ],
    correctAnswer: "Point where total revenue equals total costs",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Finance & Economics",
    question: "What is opportunity cost?",
    options: [
      "Value of the next best alternative forgone",
      "Total business revenue",
      "Employee salary",
      "Tax rate",
    ],
    correctAnswer: "Value of the next best alternative forgone",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Finance & Economics",
    question: "What does GDP measure?",
    options: [
      "Value of final goods and services produced within an economy",
      "Only government revenue",
      "Only exports",
      "Only household savings",
    ],
    correctAnswer: "Value of final goods and services produced within an economy",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Finance & Economics",
    question: "What is diversification in investment?",
    options: [
      "Spreading investments across different assets",
      "Investing everything in one asset",
      "Avoiding all investments",
      "Increasing debt only",
    ],
    correctAnswer: "Spreading investments across different assets",
  ),

  // ---------- Communication & Professional Skills - 10 ----------

  g(
    category: "Business & Professional Skills",
    subject: "Communication & Professional Skills",
    question: "What is active listening?",
    options: [
      "Consciously understanding and responding to the speaker",
      "Waiting silently without understanding",
      "Interrupting frequently",
      "Ignoring non-verbal signals",
    ],
    correctAnswer: "Consciously understanding and responding to the speaker",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Communication & Professional Skills",
    question: "What is emotional intelligence?",
    options: [
      "Ability to understand and manage emotions",
      "Ability to memorize code",
      "Ability to calculate taxes",
      "Ability to type quickly",
    ],
    correctAnswer: "Ability to understand and manage emotions",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Communication & Professional Skills",
    question: "What is constructive feedback?",
    options: [
      "Specific feedback intended to improve performance",
      "Personal criticism without guidance",
      "Ignoring mistakes",
      "Only giving praise",
    ],
    correctAnswer: "Specific feedback intended to improve performance",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Communication & Professional Skills",
    question: "What is negotiation?",
    options: [
      "Process of reaching an agreement between parties",
      "Avoiding communication",
      "Making decisions without discussion",
      "Rejecting every proposal",
    ],
    correctAnswer: "Process of reaching an agreement between parties",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Communication & Professional Skills",
    question: "What is a professional elevator pitch?",
    options: [
      "A concise explanation of your value or idea",
      "A technical report",
      "A financial statement",
      "A programming algorithm",
    ],
    correctAnswer: "A concise explanation of your value or idea",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Communication & Professional Skills",
    question: "What is time management primarily concerned with?",
    options: [
      "Prioritizing and organizing tasks effectively",
      "Working without breaks",
      "Avoiding deadlines",
      "Doing every task simultaneously",
    ],
    correctAnswer: "Prioritizing and organizing tasks effectively",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Communication & Professional Skills",
    question: "What is critical thinking?",
    options: [
      "Evaluating information logically before reaching conclusions",
      "Accepting every claim immediately",
      "Avoiding evidence",
      "Following opinions without analysis",
    ],
    correctAnswer: "Evaluating information logically before reaching conclusions",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Communication & Professional Skills",
    question: "What is teamwork?",
    options: [
      "Collaborating toward a shared objective",
      "Working without communication",
      "Avoiding responsibility",
      "Competing with every teammate",
    ],
    correctAnswer: "Collaborating toward a shared objective",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Communication & Professional Skills",
    question: "What is professional networking?",
    options: [
      "Building mutually useful professional relationships",
      "Collecting random phone numbers",
      "Avoiding industry contacts",
      "Only applying for jobs",
    ],
    correctAnswer: "Building mutually useful professional relationships",
  ),

  g(
    category: "Business & Professional Skills",
    subject: "Communication & Professional Skills",
    question: "What is problem-solving?",
    options: [
      "Identifying a problem and developing an effective solution",
      "Ignoring the problem",
      "Assigning blame only",
      "Avoiding decisions",
    ],
    correctAnswer: "Identifying a problem and developing an effective solution",
  ),
];

// ============================================================
// SEED FUNCTION
// ============================================================

Future<void> seedGraduateQuiz() async {
  final firestore = FirebaseFirestore.instance;

  print("========================================");
  print("GRADUATE QUIZ SEED STARTED");
  print("========================================");

  print("Total questions: ${graduateQuestions.length}");

  // ----------------------------------------------------------
  // DELETE OLD GRADUATE QUESTIONS
  // ----------------------------------------------------------

  final oldQuestions = await firestore
      .collection("quiz_questions")
      .where("role", isEqualTo: "graduate")
      .get();

  print(
    "Old graduate questions: ${oldQuestions.docs.length}",
  );

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

  print("Old graduate questions deleted.");

  // ----------------------------------------------------------
  // ADD NEW GRADUATE QUESTIONS
  // ----------------------------------------------------------

  WriteBatch batch = firestore.batch();

  int counter = 0;

  for (final quizQuestion in graduateQuestions) {
    final docRef =
        firestore.collection("quiz_questions").doc();

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
      .where("role", isEqualTo: "graduate")
      .get();

  print("");
  print("========================================");
  print("GRADUATE QUIZ SEED COMPLETE");
  print("========================================");

  print("Graduate questions: ${result.docs.length}");

  print("");
  print("Software Development              : 30");
  print("Data Science & Artificial Intelligence : 30");
  print("Cybersecurity                      : 30");
  print("Networking & Cloud Computing      : 30");
  print("Engineering & Technology           : 30");
  print("Healthcare & Life Sciences        : 30");
  print("Business & Professional Skills    : 30");

  print("----------------------------------------");
  print("TOTAL                              : 210");
  print("========================================");
}