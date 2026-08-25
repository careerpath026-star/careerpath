import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/firebase_options.dart';

Future<void> main() async {
  // ============================================================
  // INITIALIZE FIREBASE
  // ============================================================

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("======================================");
  print("   CAREER PATH - GRADUATE CAREERS");
  print("======================================");
  print("");

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  // ============================================================
  // GRADUATE CAREERS
  // ============================================================

  final List<Map<String, dynamic>> careers = [

    // ==========================================================
    // COMPUTER SCIENCE - 15
    // ==========================================================

    {
      "careerName": "Software Engineer",
      "category": "computer",
      "role": "graduate",
      "description":
          "Designs, develops, tests and maintains software applications and systems.",
      "education":
          "Bachelor's degree in Computer Science, Software Engineering or related field.",
      "skills": [
        "Programming",
        "Problem Solving",
        "Data Structures",
        "Algorithms",
        "Git"
      ],
      "scope":
          "Software engineers can work in software houses, technology companies, startups, banks and remote organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Full Stack Developer",
      "category": "computer",
      "role": "graduate",
      "description":
          "Develops both frontend and backend parts of modern web applications.",
      "education":
          "Bachelor's degree in Computer Science, Software Engineering or related field.",
      "skills": [
        "HTML",
        "CSS",
        "JavaScript",
        "React",
        "Node.js",
        "Databases"
      ],
      "scope":
          "Works in software companies, web development agencies, startups and freelance environments.",
      "salaryRange": "Depends on experience and technology stack.",
    },

    {
      "careerName": "Mobile App Developer",
      "category": "computer",
      "role": "graduate",
      "description":
          "Creates applications for Android, iOS and cross-platform mobile devices.",
      "education":
          "Bachelor's degree in Computer Science, Software Engineering or related field.",
      "skills": [
        "Flutter",
        "Dart",
        "Android",
        "iOS",
        "API Integration"
      ],
      "scope":
          "Mobile developers work with technology companies, startups, software houses and freelance clients.",
      "salaryRange": "Depends on experience and specialization.",
    },

    {
      "careerName": "Web Developer",
      "category": "computer",
      "role": "graduate",
      "description":
          "Builds and maintains websites and web-based applications.",
      "education":
          "Bachelor's degree in Computer Science, Software Engineering or related field.",
      "skills": [
        "HTML",
        "CSS",
        "JavaScript",
        "Responsive Design",
        "Web APIs"
      ],
      "scope":
          "Can work in software houses, agencies, startups and freelance development.",
      "salaryRange": "Depends on experience and skills.",
    },

    {
      "careerName": "Data Scientist",
      "category": "computer",
      "role": "graduate",
      "description":
          "Uses data, statistics and programming to discover insights and support decision making.",
      "education":
          "Bachelor's degree in Computer Science, Data Science, Mathematics or related field.",
      "skills": [
        "Python",
        "Statistics",
        "Machine Learning",
        "SQL",
        "Data Visualization"
      ],
      "scope":
          "Data scientists work in technology, finance, healthcare, research and business organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Machine Learning Engineer",
      "category": "computer",
      "role": "graduate",
      "description":
          "Builds and deploys machine learning systems and intelligent applications.",
      "education":
          "Bachelor's degree in Computer Science, AI, Data Science or related field.",
      "skills": [
        "Python",
        "Machine Learning",
        "Statistics",
        "Algorithms",
        "Model Deployment"
      ],
      "scope":
          "Works in AI companies, software houses, research organizations and technology startups.",
      "salaryRange": "Depends on experience and specialization.",
    },

    {
      "careerName": "AI Engineer",
      "category": "computer",
      "role": "graduate",
      "description":
          "Develops artificial intelligence solutions using machine learning and modern AI technologies.",
      "education":
          "Bachelor's degree in Computer Science, Artificial Intelligence or related field.",
      "skills": [
        "Python",
        "Machine Learning",
        "Deep Learning",
        "AI APIs",
        "Problem Solving"
      ],
      "scope":
          "AI engineers can work in technology companies, research organizations and AI startups.",
      "salaryRange": "Depends on experience and specialization.",
    },

    {
      "careerName": "Cybersecurity Engineer",
      "category": "computer",
      "role": "graduate",
      "description":
          "Protects applications, networks and systems against security threats.",
      "education":
          "Bachelor's degree in Cybersecurity, Computer Science or related field.",
      "skills": [
        "Network Security",
        "Linux",
        "Cryptography",
        "Security Testing",
        "Risk Analysis"
      ],
      "scope":
          "Cybersecurity professionals are needed by banks, technology companies, government organizations and enterprises.",
      "salaryRange": "Depends on experience and certifications.",
    },

    {
      "careerName": "Cloud Engineer",
      "category": "computer",
      "role": "graduate",
      "description":
          "Designs, deploys and manages cloud-based infrastructure and services.",
      "education":
          "Bachelor's degree in Computer Science, IT or related field.",
      "skills": [
        "Cloud Computing",
        "Linux",
        "Networking",
        "AWS",
        "Azure"
      ],
      "scope":
          "Cloud engineers work in software companies, enterprises and cloud service organizations.",
      "salaryRange": "Depends on cloud platform and experience.",
    },

    {
      "careerName": "DevOps Engineer",
      "category": "computer",
      "role": "graduate",
      "description":
          "Automates software development, testing and deployment processes.",
      "education":
          "Bachelor's degree in Computer Science, Software Engineering or IT.",
      "skills": [
        "Linux",
        "Docker",
        "CI/CD",
        "Git",
        "Cloud Computing"
      ],
      "scope":
          "DevOps engineers are used by software companies and organizations running large-scale applications.",
      "salaryRange": "Depends on experience and tools.",
    },

    {
      "careerName": "Database Administrator",
      "category": "computer",
      "role": "graduate",
      "description":
          "Manages databases, performance, security, backups and data availability.",
      "education":
          "Bachelor's degree in Computer Science, IT or related field.",
      "skills": [
        "SQL",
        "Database Management",
        "Backup",
        "Security",
        "Performance Optimization"
      ],
      "scope":
          "Works in banks, enterprises, software companies and organizations that depend on databases.",
      "salaryRange": "Depends on database technologies and experience.",
    },

    {
      "careerName": "Systems Analyst",
      "category": "computer",
      "role": "graduate",
      "description":
          "Analyzes business requirements and helps design effective information systems.",
      "education":
          "Bachelor's degree in Computer Science, IT or related field.",
      "skills": [
        "Requirements Analysis",
        "Problem Solving",
        "System Design",
        "Communication",
        "Documentation"
      ],
      "scope":
          "Systems analysts work in IT departments, software companies and business organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Network Engineer",
      "category": "computer",
      "role": "graduate",
      "description":
          "Designs, manages and maintains computer networks and communication infrastructure.",
      "education":
          "Bachelor's degree in Computer Science, IT or Networking.",
      "skills": [
        "Networking",
        "TCP/IP",
        "Routing",
        "Switching",
        "Network Security"
      ],
      "scope":
          "Network engineers work in telecom companies, enterprises, banks and technology organizations.",
      "salaryRange": "Depends on experience and certifications.",
    },

    {
      "careerName": "UI/UX Designer",
      "category": "computer",
      "role": "graduate",
      "description":
          "Designs user interfaces and experiences for websites, applications and digital products.",
      "education":
          "Bachelor's degree in Computer Science, Design, IT or related field.",
      "skills": [
        "UI Design",
        "UX Research",
        "Figma",
        "Prototyping",
        "User Research"
      ],
      "scope":
          "UI/UX designers work in software houses, startups, agencies and product companies.",
      "salaryRange": "Depends on experience and portfolio.",
    },

    {
      "careerName": "QA Automation Engineer",
      "category": "computer",
      "role": "graduate",
      "description":
          "Tests software applications and creates automated testing systems.",
      "education":
          "Bachelor's degree in Computer Science, Software Engineering or related field.",
      "skills": [
        "Software Testing",
        "Automation",
        "Selenium",
        "Programming",
        "Bug Tracking"
      ],
      "scope":
          "QA engineers work in software houses, technology companies and product organizations.",
      "salaryRange": "Depends on experience and testing technologies.",
    },

    // ==========================================================
    // MEDICAL - 12
    // ==========================================================

    {
      "careerName": "Medical Doctor",
      "category": "medical",
      "role": "graduate",
      "description":
          "Diagnoses and treats patients and provides medical care.",
      "education":
          "Medical degree followed by required professional training.",
      "skills": [
        "Clinical Knowledge",
        "Diagnosis",
        "Communication",
        "Patient Care"
      ],
      "scope":
          "Doctors can work in hospitals, clinics, healthcare organizations and medical institutions.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Dentist",
      "category": "medical",
      "role": "graduate",
      "description":
          "Provides diagnosis, prevention and treatment of oral and dental conditions.",
      "education":
          "Dental degree followed by required professional training.",
      "skills": [
        "Dental Care",
        "Diagnosis",
        "Patient Communication",
        "Clinical Skills"
      ],
      "scope":
          "Dentists can work in hospitals, dental clinics or establish private practices.",
      "salaryRange": "Depends on experience and practice.",
    },

    {
      "careerName": "Pharmacist",
      "category": "medical",
      "role": "graduate",
      "description":
          "Works with medicines, medication safety and pharmaceutical services.",
      "education":
          "Pharmacy degree and required professional registration.",
      "skills": [
        "Pharmacology",
        "Medicine Knowledge",
        "Patient Counseling",
        "Drug Safety"
      ],
      "scope":
          "Pharmacists work in hospitals, pharmacies, pharmaceutical companies and healthcare organizations.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Physiotherapist",
      "category": "medical",
      "role": "graduate",
      "description":
          "Helps patients improve movement, physical function and recovery.",
      "education":
          "Degree in Physiotherapy or related field.",
      "skills": [
        "Patient Assessment",
        "Rehabilitation",
        "Exercise Therapy",
        "Communication"
      ],
      "scope":
          "Physiotherapists work in hospitals, rehabilitation centers, clinics and sports organizations.",
      "salaryRange": "Depends on experience and workplace.",
    },

    {
      "careerName": "Medical Laboratory Scientist",
      "category": "medical",
      "role": "graduate",
      "description":
          "Performs laboratory tests that help healthcare professionals diagnose and monitor diseases.",
      "education":
          "Bachelor's degree in Medical Laboratory Science or related field.",
      "skills": [
        "Laboratory Testing",
        "Biology",
        "Chemistry",
        "Data Analysis",
        "Accuracy"
      ],
      "scope":
          "Works in hospitals, diagnostic laboratories and research organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Radiology Technologist",
      "category": "medical",
      "role": "graduate",
      "description":
          "Operates medical imaging equipment and supports diagnostic imaging procedures.",
      "education":
          "Degree or professional qualification in Radiologic Technology.",
      "skills": [
        "Medical Imaging",
        "Patient Care",
        "Equipment Operation",
        "Safety"
      ],
      "scope":
          "Works in hospitals, diagnostic centers and imaging clinics.",
      "salaryRange": "Depends on experience and institution.",
    },

    {
      "careerName": "Nutritionist",
      "category": "medical",
      "role": "graduate",
      "description":
          "Provides nutrition guidance and develops dietary plans based on individual needs.",
      "education":
          "Degree in Nutrition, Dietetics or related field.",
      "skills": [
        "Nutrition",
        "Diet Planning",
        "Communication",
        "Health Assessment"
      ],
      "scope":
          "Nutritionists can work in hospitals, wellness centers, clinics and community health programs.",
      "salaryRange": "Depends on experience and workplace.",
    },

    {
      "careerName": "Public Health Specialist",
      "category": "medical",
      "role": "graduate",
      "description":
          "Works on programs and strategies that improve health at community and population levels.",
      "education":
          "Degree in Public Health or related healthcare field.",
      "skills": [
        "Public Health",
        "Research",
        "Statistics",
        "Communication",
        "Health Planning"
      ],
      "scope":
          "Works with healthcare organizations, government programs, NGOs and research institutions.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Medical Researcher",
      "category": "medical",
      "role": "graduate",
      "description":
          "Conducts research to improve understanding of diseases, treatments and healthcare.",
      "education":
          "Relevant healthcare, biological science or medical degree.",
      "skills": [
        "Research",
        "Biology",
        "Data Analysis",
        "Scientific Writing"
      ],
      "scope":
          "Medical researchers work in universities, laboratories, hospitals and research organizations.",
      "salaryRange": "Depends on research organization and experience.",
    },

    {
      "careerName": "Clinical Psychologist",
      "category": "medical",
      "role": "graduate",
      "description":
          "Assesses and provides psychological support and interventions for mental and behavioral conditions.",
      "education":
          "Relevant psychology degree and required professional training.",
      "skills": [
        "Psychology",
        "Assessment",
        "Communication",
        "Counseling"
      ],
      "scope":
          "Clinical psychologists can work in hospitals, clinics, educational institutions and private practice.",
      "salaryRange": "Depends on qualifications and experience.",
    },

    {
      "careerName": "Healthcare Administrator",
      "category": "medical",
      "role": "graduate",
      "description":
          "Manages administrative and operational activities within healthcare organizations.",
      "education":
          "Degree in Healthcare Administration, Management or related field.",
      "skills": [
        "Management",
        "Healthcare Systems",
        "Communication",
        "Planning"
      ],
      "scope":
          "Works in hospitals, clinics, healthcare companies and health organizations.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Biomedical Scientist",
      "category": "medical",
      "role": "graduate",
      "description":
          "Studies biological processes and supports medical research and laboratory science.",
      "education":
          "Degree in Biomedical Science or related biological field.",
      "skills": [
        "Biology",
        "Laboratory Research",
        "Data Analysis",
        "Scientific Research"
      ],
      "scope":
          "Works in laboratories, research institutes, hospitals and biotechnology organizations.",
      "salaryRange": "Depends on research area and experience.",
    },

    // ==========================================================
    // ENGINEERING - 13
    // ==========================================================

    {
      "careerName": "Civil Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Designs and manages construction and infrastructure projects.",
      "education":
          "Bachelor's degree in Civil Engineering.",
      "skills": [
        "Structural Analysis",
        "AutoCAD",
        "Project Management",
        "Construction"
      ],
      "scope":
          "Civil engineers work in construction companies, consulting firms and infrastructure organizations.",
      "salaryRange": "Depends on experience and project type.",
    },

    {
      "careerName": "Electrical Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Designs and works with electrical systems, equipment and power technologies.",
      "education":
          "Bachelor's degree in Electrical Engineering.",
      "skills": [
        "Circuit Analysis",
        "Power Systems",
        "Electronics",
        "Control Systems"
      ],
      "scope":
          "Works in power companies, manufacturing, telecom and engineering organizations.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Mechanical Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Designs, develops and maintains mechanical systems and machines.",
      "education":
          "Bachelor's degree in Mechanical Engineering.",
      "skills": [
        "Thermodynamics",
        "CAD",
        "Machine Design",
        "Manufacturing"
      ],
      "scope":
          "Mechanical engineers work in manufacturing, automotive, energy and industrial organizations.",
      "salaryRange": "Depends on industry and experience.",
    },

    {
      "careerName": "Electronics Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Designs and develops electronic circuits, devices and systems.",
      "education":
          "Bachelor's degree in Electronics Engineering or related field.",
      "skills": [
        "Circuit Design",
        "Embedded Systems",
        "Microcontrollers",
        "Electronics"
      ],
      "scope":
          "Works in electronics, manufacturing, telecommunications and technology organizations.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Computer Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Combines computer science and engineering to design computer hardware and software systems.",
      "education":
          "Bachelor's degree in Computer Engineering.",
      "skills": [
        "Programming",
        "Digital Logic",
        "Computer Architecture",
        "Embedded Systems"
      ],
      "scope":
          "Computer engineers work in hardware companies, technology companies and embedded systems organizations.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Chemical Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Designs and manages industrial processes involving chemicals and materials.",
      "education":
          "Bachelor's degree in Chemical Engineering.",
      "skills": [
        "Chemical Processes",
        "Thermodynamics",
        "Process Design",
        "Safety"
      ],
      "scope":
          "Works in chemical, pharmaceutical, energy, manufacturing and industrial organizations.",
      "salaryRange": "Depends on industry and experience.",
    },

    {
      "careerName": "Mechatronics Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Combines mechanical, electrical and computer engineering for intelligent automated systems.",
      "education":
          "Bachelor's degree in Mechatronics Engineering.",
      "skills": [
        "Robotics",
        "Automation",
        "Electronics",
        "Programming",
        "Control Systems"
      ],
      "scope":
          "Works in robotics, manufacturing, automation and industrial technology.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Environmental Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Develops engineering solutions for environmental protection and sustainability.",
      "education":
          "Bachelor's degree in Environmental Engineering or related field.",
      "skills": [
        "Environmental Science",
        "Waste Management",
        "Water Treatment",
        "Sustainability"
      ],
      "scope":
          "Works in environmental organizations, industries, government departments and consulting firms.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Industrial Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Improves productivity, efficiency and quality of industrial processes.",
      "education":
          "Bachelor's degree in Industrial Engineering.",
      "skills": [
        "Process Optimization",
        "Quality Control",
        "Operations",
        "Data Analysis"
      ],
      "scope":
          "Works in manufacturing, logistics, production and operations organizations.",
      "salaryRange": "Depends on industry and experience.",
    },

    {
      "careerName": "Telecommunications Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Designs and maintains communication and telecommunications systems.",
      "education":
          "Bachelor's degree in Telecommunications, Electrical Engineering or related field.",
      "skills": [
        "Networking",
        "Communication Systems",
        "Wireless Technology",
        "Signal Processing"
      ],
      "scope":
          "Works in telecom companies, networking organizations and communication industries.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Petroleum Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Works on the exploration, extraction and production of oil and gas resources.",
      "education":
          "Bachelor's degree in Petroleum Engineering.",
      "skills": [
        "Reservoir Engineering",
        "Drilling",
        "Production",
        "Geology"
      ],
      "scope":
          "Works in oil and gas companies, energy organizations and engineering firms.",
      "salaryRange": "Depends on industry, location and experience.",
    },

    {
      "careerName": "Biomedical Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Applies engineering principles to medical equipment, healthcare technology and biomedical systems.",
      "education":
          "Bachelor's degree in Biomedical Engineering.",
      "skills": [
        "Engineering",
        "Medical Technology",
        "Electronics",
        "Biology",
        "Design"
      ],
      "scope":
          "Works in medical technology companies, hospitals, research organizations and biomedical industries.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Structural Engineer",
      "category": "engineering",
      "role": "graduate",
      "description":
          "Designs and analyzes structures such as buildings, bridges and other infrastructure.",
      "education":
          "Bachelor's degree in Civil Engineering with structural engineering specialization.",
      "skills": [
        "Structural Analysis",
        "Engineering Design",
        "AutoCAD",
        "Construction",
        "Mathematics"
      ],
      "scope":
          "Works in construction companies, engineering consultancies and infrastructure projects.",
      "salaryRange": "Depends on experience and project complexity.",
    },
  ];

  // ============================================================
  // INSERT CAREERS
  // ============================================================

  int added = 0;

  for (final career in careers) {
    try {
      await firestore
          .collection("careerBank")
          .add({
        ...career,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });

      added++;

      print(
        "✅ Added: ${career["careerName"]} "
        "(${career["category"]})",
      );
    } catch (e) {
      print(
        "❌ Failed: ${career["careerName"]} -> $e",
      );
    }
  }

  // ============================================================
  // SUMMARY
  // ============================================================

  print("");
  print("======================================");
  print("       CAREER BANK COMPLETE");
  print("======================================");
  print("Total careers added: $added");
  print("");
  print("Computer    : 15");
  print("Medical     : 12");
  print("Engineering : 13");
  print("Total       : 40");
  print("");
  print("Role: graduate");
  print("Collection: careerBank");
  print("======================================");
}