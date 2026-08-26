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
  // DELETE ONLY OLD GRADUATE CAREERS
  // IMPORTANT:
  // Student and Professional careers will NOT be deleted.
  // ============================================================

  print("Deleting old graduate careers...");

  final QuerySnapshot oldGraduateCareers = await firestore
      .collection("careerBank")
      .where("role", isEqualTo: "graduate")
      .get();

  for (final doc in oldGraduateCareers.docs) {
    await doc.reference.delete();
  }

  print(
    "Deleted ${oldGraduateCareers.docs.length} old graduate careers.",
  );
  print("");

  // ============================================================
  // GRADUATE CAREERS
  // 12 CATEGORIES × 10 CAREERS = 120 CAREERS
  // ============================================================

  final List<Map<String, dynamic>> careers = [

    // ==========================================================
    // 1. COMPUTER SCIENCE & IT - 10
    // ==========================================================

    {
      "careerName": "Software Engineer",
      "category": "computer",
      "categoryName": "Computer Science & IT",
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
      "careerName": "Data Scientist",
      "category": "computer",
      "categoryName": "Computer Science & IT",
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
      "careerName": "AI Engineer",
      "category": "computer",
      "categoryName": "Computer Science & IT",
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
      "careerName": "Cybersecurity Analyst",
      "category": "computer",
      "categoryName": "Computer Science & IT",
      "role": "graduate",
      "description":
          "Monitors systems and networks to identify and respond to cybersecurity threats.",
      "education":
          "Bachelor's degree in Cybersecurity, Computer Science or Information Technology.",
      "skills": [
        "Network Security",
        "Linux",
        "Security Monitoring",
        "Risk Analysis",
        "Threat Detection"
      ],
      "scope":
          "Cybersecurity analysts work in banks, technology companies, government organizations and enterprises.",
      "salaryRange": "Depends on experience and certifications.",
    },

    {
      "careerName": "Cloud Engineer",
      "category": "computer",
      "categoryName": "Computer Science & IT",
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
      "categoryName": "Computer Science & IT",
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
          "DevOps engineers work in software companies and organizations running large-scale applications.",
      "salaryRange": "Depends on experience and tools.",
    },

    {
      "careerName": "Mobile App Developer",
      "category": "computer",
      "categoryName": "Computer Science & IT",
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
      "categoryName": "Computer Science & IT",
      "role": "graduate",
      "description":
          "Builds and maintains websites and web-based applications.",
      "education":
          "Bachelor's degree in Computer Science, Software Engineering or related field.",
      "skills": [
        "HTML",
        "CSS",
        "JavaScript",
        "React",
        "Web APIs"
      ],
      "scope":
          "Can work in software houses, agencies, startups and freelance development.",
      "salaryRange": "Depends on experience and skills.",
    },

    {
      "careerName": "Database Administrator",
      "category": "computer",
      "categoryName": "Computer Science & IT",
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
      "careerName": "Machine Learning Engineer",
      "category": "computer",
      "categoryName": "Computer Science & IT",
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

    // ==========================================================
    // 2. MEDICAL & HEALTHCARE - 10
    // ==========================================================

    {
      "careerName": "Medical Doctor",
      "category": "medical",
      "categoryName": "Medical & Healthcare",
      "role": "graduate",
      "description":
          "Diagnoses and treats patients and provides medical care.",
      "education":
          "Medical degree followed by required professional training.",
      "skills": [
        "Clinical Knowledge",
        "Diagnosis",
        "Patient Care",
        "Communication"
      ],
      "scope":
          "Doctors can work in hospitals, clinics and healthcare organizations.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Pharmacist",
      "category": "medical",
      "categoryName": "Medical & Healthcare",
      "role": "graduate",
      "description":
          "Works with medicines, medication safety and pharmaceutical services.",
      "education":
          "Pharmacy degree and required professional registration.",
      "skills": [
        "Pharmacology",
        "Medicine Knowledge",
        "Drug Safety",
        "Patient Counseling"
      ],
      "scope":
          "Pharmacists work in hospitals, pharmacies and pharmaceutical companies.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Physiotherapist",
      "category": "medical",
      "categoryName": "Medical & Healthcare",
      "role": "graduate",
      "description":
          "Helps patients improve movement, physical function and recovery.",
      "education":
          "Degree in Physiotherapy or related field.",
      "skills": [
        "Rehabilitation",
        "Exercise Therapy",
        "Patient Assessment",
        "Communication"
      ],
      "scope":
          "Works in hospitals, rehabilitation centers, clinics and sports organizations.",
      "salaryRange": "Depends on experience and workplace.",
    },

    {
      "careerName": "Dentist",
      "category": "medical",
      "categoryName": "Medical & Healthcare",
      "role": "graduate",
      "description":
          "Provides diagnosis, prevention and treatment of oral and dental conditions.",
      "education":
          "Dental degree followed by required professional training.",
      "skills": [
        "Dental Care",
        "Diagnosis",
        "Clinical Skills",
        "Patient Communication"
      ],
      "scope":
          "Dentists can work in hospitals, dental clinics or private practices.",
      "salaryRange": "Depends on experience and practice.",
    },

    {
      "careerName": "Medical Laboratory Scientist",
      "category": "medical",
      "categoryName": "Medical & Healthcare",
      "role": "graduate",
      "description":
          "Performs laboratory tests that support diagnosis and healthcare decisions.",
      "education":
          "Bachelor's degree in Medical Laboratory Science or related field.",
      "skills": [
        "Laboratory Testing",
        "Biology",
        "Chemistry",
        "Data Analysis"
      ],
      "scope":
          "Works in hospitals, diagnostic laboratories and research organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Radiology Technologist",
      "category": "medical",
      "categoryName": "Medical & Healthcare",
      "role": "graduate",
      "description":
          "Operates medical imaging equipment and supports diagnostic imaging procedures.",
      "education":
          "Degree or professional qualification in Radiologic Technology.",
      "skills": [
        "Medical Imaging",
        "Equipment Operation",
        "Patient Care",
        "Safety"
      ],
      "scope":
          "Works in hospitals, diagnostic centers and imaging clinics.",
      "salaryRange": "Depends on experience and institution.",
    },

    {
      "careerName": "Nutritionist",
      "category": "medical",
      "categoryName": "Medical & Healthcare",
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
          "Works in hospitals, wellness centers, clinics and community health programs.",
      "salaryRange": "Depends on experience and workplace.",
    },

    {
      "careerName": "Public Health Specialist",
      "category": "medical",
      "categoryName": "Medical & Healthcare",
      "role": "graduate",
      "description":
          "Works on programs and strategies that improve community and population health.",
      "education":
          "Degree in Public Health or related healthcare field.",
      "skills": [
        "Public Health",
        "Research",
        "Statistics",
        "Health Planning"
      ],
      "scope":
          "Works with healthcare organizations, government programs and NGOs.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Medical Researcher",
      "category": "medical",
      "categoryName": "Medical & Healthcare",
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
          "Works in universities, laboratories, hospitals and research organizations.",
      "salaryRange": "Depends on research organization and experience.",
    },

    {
      "careerName": "Healthcare Administrator",
      "category": "medical",
      "categoryName": "Medical & Healthcare",
      "role": "graduate",
      "description":
          "Manages administrative and operational activities within healthcare organizations.",
      "education":
          "Degree in Healthcare Administration, Management or related field.",
      "skills": [
        "Management",
        "Planning",
        "Healthcare Systems",
        "Communication"
      ],
      "scope":
          "Works in hospitals, clinics, healthcare companies and health organizations.",
      "salaryRange": "Depends on organization and experience.",
    },

    // ==========================================================
    // 3. ENGINEERING - 10
    // ==========================================================

    {
      "careerName": "Civil Engineer",
      "category": "engineering",
      "categoryName": "Engineering",
      "role": "graduate",
      "description":
          "Designs and manages construction and infrastructure projects.",
      "education":
          "Bachelor's degree in Civil Engineering.",
      "skills": [
        "Structural Analysis",
        "AutoCAD",
        "Construction",
        "Project Management"
      ],
      "scope":
          "Works in construction companies, consulting firms and infrastructure organizations.",
      "salaryRange": "Depends on experience and project type.",
    },

    {
      "careerName": "Mechanical Engineer",
      "category": "engineering",
      "categoryName": "Engineering",
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
          "Works in manufacturing, automotive, energy and industrial organizations.",
      "salaryRange": "Depends on industry and experience.",
    },

    {
      "careerName": "Electrical Engineer",
      "category": "engineering",
      "categoryName": "Engineering",
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
      "careerName": "Electronics Engineer",
      "category": "engineering",
      "categoryName": "Engineering",
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
      "careerName": "Chemical Engineer",
      "category": "engineering",
      "categoryName": "Engineering",
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
          "Works in chemical, pharmaceutical, energy and manufacturing organizations.",
      "salaryRange": "Depends on industry and experience.",
    },

    {
      "careerName": "Computer Engineer",
      "category": "engineering",
      "categoryName": "Engineering",
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
          "Works in hardware companies, technology companies and embedded systems organizations.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Mechatronics Engineer",
      "category": "engineering",
      "categoryName": "Engineering",
      "role": "graduate",
      "description":
          "Combines mechanical, electrical and computer engineering for automated systems.",
      "education":
          "Bachelor's degree in Mechatronics Engineering.",
      "skills": [
        "Robotics",
        "Automation",
        "Electronics",
        "Programming"
      ],
      "scope":
          "Works in robotics, manufacturing, automation and industrial technology.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Environmental Engineer",
      "category": "engineering",
      "categoryName": "Engineering",
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
      "categoryName": "Engineering",
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
      "careerName": "Petroleum Engineer",
      "category": "engineering",
      "categoryName": "Engineering",
      "role": "graduate",
      "description":
          "Works on exploration, extraction and production of oil and gas resources.",
      "education":
          "Bachelor's degree in Petroleum Engineering.",
      "skills": [
        "Drilling",
        "Production",
        "Reservoir Engineering",
        "Geology"
      ],
      "scope":
          "Works in oil and gas companies, energy organizations and engineering firms.",
      "salaryRange": "Depends on industry and experience.",
    },

    // ==========================================================
    // 4. BUSINESS & MANAGEMENT - 10
    // ==========================================================

    {
      "careerName": "Business Analyst",
      "category": "business",
      "categoryName": "Business & Management",
      "role": "graduate",
      "description":
          "Analyzes business processes and requirements to improve organizational performance.",
      "education":
          "Bachelor's degree in Business Administration, Management or related field.",
      "skills": [
        "Business Analysis",
        "Excel",
        "Problem Solving",
        "Communication"
      ],
      "scope":
          "Works in companies, banks, technology organizations and consulting firms.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "HR Manager",
      "category": "business",
      "categoryName": "Business & Management",
      "role": "graduate",
      "description":
          "Manages recruitment, employee relations, training and human resources operations.",
      "education":
          "Bachelor's or Master's degree in Human Resources or Business Administration.",
      "skills": [
        "Recruitment",
        "Communication",
        "Employee Management",
        "Leadership"
      ],
      "scope":
          "HR professionals are required in almost every medium and large organization.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Marketing Manager",
      "category": "business",
      "categoryName": "Business & Management",
      "role": "graduate",
      "description":
          "Plans and manages marketing strategies to promote products and services.",
      "education":
          "Bachelor's degree in Marketing, Business or Management.",
      "skills": [
        "Marketing",
        "Digital Marketing",
        "Communication",
        "Market Research"
      ],
      "scope":
          "Works in companies, agencies, startups and consumer brands.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Operations Manager",
      "category": "business",
      "categoryName": "Business & Management",
      "role": "graduate",
      "description":
          "Manages daily business operations and improves organizational efficiency.",
      "education":
          "Bachelor's degree in Business Administration or Management.",
      "skills": [
        "Operations",
        "Leadership",
        "Planning",
        "Problem Solving"
      ],
      "scope":
          "Works in manufacturing, retail, services, logistics and technology companies.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Project Manager",
      "category": "business",
      "categoryName": "Business & Management",
      "role": "graduate",
      "description":
          "Plans, manages and delivers projects within time, scope and budget.",
      "education":
          "Bachelor's degree in Management, Business or related field.",
      "skills": [
        "Project Management",
        "Leadership",
        "Planning",
        "Communication"
      ],
      "scope":
          "Project managers work across technology, construction, business and many other industries.",
      "salaryRange": "Depends on experience and project complexity.",
    },

    {
      "careerName": "Management Consultant",
      "category": "business",
      "categoryName": "Business & Management",
      "role": "graduate",
      "description":
          "Helps organizations solve business problems and improve performance.",
      "education":
          "Bachelor's degree in Business, Management, Economics or related field.",
      "skills": [
        "Business Strategy",
        "Research",
        "Problem Solving",
        "Communication"
      ],
      "scope":
          "Works in consulting firms and corporate strategy departments.",
      "salaryRange": "Depends on experience and consulting organization.",
    },

    {
      "careerName": "Business Development Executive",
      "category": "business",
      "categoryName": "Business & Management",
      "role": "graduate",
      "description":
          "Identifies new business opportunities and builds relationships with clients.",
      "education":
          "Bachelor's degree in Business, Marketing or Management.",
      "skills": [
        "Sales",
        "Communication",
        "Negotiation",
        "Business Development"
      ],
      "scope":
          "Works in startups, technology companies, agencies and corporate organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Supply Chain Manager",
      "category": "business",
      "categoryName": "Business & Management",
      "role": "graduate",
      "description":
          "Manages the movement of products, materials and resources across supply chains.",
      "education":
          "Bachelor's degree in Supply Chain, Business or Management.",
      "skills": [
        "Supply Chain",
        "Logistics",
        "Planning",
        "Inventory Management"
      ],
      "scope":
          "Works in manufacturing, retail, logistics and large business organizations.",
      "salaryRange": "Depends on experience and industry.",
    },

    {
      "careerName": "Entrepreneur",
      "category": "business",
      "categoryName": "Business & Management",
      "role": "graduate",
      "description":
          "Creates and manages a business by identifying opportunities and developing products or services.",
      "education":
          "Business, Management or relevant professional education can be helpful.",
      "skills": [
        "Leadership",
        "Business Planning",
        "Communication",
        "Decision Making"
      ],
      "scope":
          "Entrepreneurs can build businesses across technology, retail, services and many other industries.",
      "salaryRange": "Depends on business performance.",
    },

    {
      "careerName": "Sales Manager",
      "category": "business",
      "categoryName": "Business & Management",
      "role": "graduate",
      "description":
          "Leads sales teams and develops strategies to achieve business revenue goals.",
      "education":
          "Bachelor's degree in Business, Marketing or Management.",
      "skills": [
        "Sales",
        "Leadership",
        "Negotiation",
        "Customer Relationship"
      ],
      "scope":
          "Sales managers are needed in retail, technology, banking, manufacturing and services.",
      "salaryRange": "Depends on experience and organization.",
    },

    // ==========================================================
    // 5. FINANCE & ACCOUNTING - 10
    // ==========================================================

    {
      "careerName": "Accountant",
      "category": "finance",
      "categoryName": "Finance & Accounting",
      "role": "graduate",
      "description":
          "Maintains financial records and prepares financial reports for organizations.",
      "education":
          "Bachelor's degree in Accounting, Finance or related field.",
      "skills": [
        "Accounting",
        "Excel",
        "Financial Reporting",
        "Bookkeeping"
      ],
      "scope":
          "Accountants work in companies, banks, firms and government organizations.",
      "salaryRange": "Depends on experience and qualifications.",
    },

    {
      "careerName": "Financial Analyst",
      "category": "finance",
      "categoryName": "Finance & Accounting",
      "role": "graduate",
      "description":
          "Analyzes financial information to support investment and business decisions.",
      "education":
          "Bachelor's degree in Finance, Accounting, Economics or related field.",
      "skills": [
        "Financial Analysis",
        "Excel",
        "Data Analysis",
        "Financial Modeling"
      ],
      "scope":
          "Works in banks, investment firms, corporations and financial institutions.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Auditor",
      "category": "finance",
      "categoryName": "Finance & Accounting",
      "role": "graduate",
      "description":
          "Examines financial records and systems to ensure accuracy and compliance.",
      "education":
          "Bachelor's degree in Accounting, Finance or related field.",
      "skills": [
        "Auditing",
        "Accounting",
        "Analysis",
        "Attention to Detail"
      ],
      "scope":
          "Auditors work in accounting firms, companies, banks and government organizations.",
      "salaryRange": "Depends on experience and professional qualifications.",
    },

    {
      "careerName": "Banking Officer",
      "category": "finance",
      "categoryName": "Finance & Accounting",
      "role": "graduate",
      "description":
          "Provides banking services and handles financial transactions and customer requirements.",
      "education":
          "Bachelor's degree in Finance, Business, Accounting or related field.",
      "skills": [
        "Banking",
        "Customer Service",
        "Finance",
        "Communication"
      ],
      "scope":
          "Works in commercial banks, Islamic banks and financial institutions.",
      "salaryRange": "Depends on bank and experience.",
    },

    {
      "careerName": "Investment Analyst",
      "category": "finance",
      "categoryName": "Finance & Accounting",
      "role": "graduate",
      "description":
          "Researches investments and evaluates financial opportunities and risks.",
      "education":
          "Bachelor's degree in Finance, Economics, Accounting or related field.",
      "skills": [
        "Investment Analysis",
        "Financial Modeling",
        "Research",
        "Economics"
      ],
      "scope":
          "Works in investment firms, banks, asset management companies and financial institutions.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Tax Consultant",
      "category": "finance",
      "categoryName": "Finance & Accounting",
      "role": "graduate",
      "description":
          "Provides guidance to individuals and organizations on tax-related matters.",
      "education":
          "Bachelor's degree in Accounting, Finance, Law or related field.",
      "skills": [
        "Taxation",
        "Accounting",
        "Research",
        "Financial Analysis"
      ],
      "scope":
          "Works in accounting firms, consulting companies and corporate finance departments.",
      "salaryRange": "Depends on qualifications and experience.",
    },

    {
      "careerName": "Risk Analyst",
      "category": "finance",
      "categoryName": "Finance & Accounting",
      "role": "graduate",
      "description":
          "Identifies and analyzes financial and operational risks for organizations.",
      "education":
          "Bachelor's degree in Finance, Economics, Mathematics or related field.",
      "skills": [
        "Risk Analysis",
        "Statistics",
        "Finance",
        "Data Analysis"
      ],
      "scope":
          "Works in banks, insurance companies, investment firms and large organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Financial Planner",
      "category": "finance",
      "categoryName": "Finance & Accounting",
      "role": "graduate",
      "description":
          "Helps individuals or organizations plan financial goals and manage resources.",
      "education":
          "Bachelor's degree in Finance, Accounting, Economics or related field.",
      "skills": [
        "Financial Planning",
        "Investment",
        "Communication",
        "Analysis"
      ],
      "scope":
          "Works in banks, financial advisory firms and investment organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Credit Analyst",
      "category": "finance",
      "categoryName": "Finance & Accounting",
      "role": "graduate",
      "description":
          "Evaluates credit applications and assesses the ability of borrowers to repay loans.",
      "education":
          "Bachelor's degree in Finance, Accounting, Economics or Business.",
      "skills": [
        "Credit Analysis",
        "Financial Analysis",
        "Risk Assessment",
        "Excel"
      ],
      "scope":
          "Works in banks, lending institutions and financial companies.",
      "salaryRange": "Depends on experience and institution.",
    },

    {
      "careerName": "Treasury Analyst",
      "category": "finance",
      "categoryName": "Finance & Accounting",
      "role": "graduate",
      "description":
          "Helps organizations manage cash flow, liquidity and financial resources.",
      "education":
          "Bachelor's degree in Finance, Accounting or Economics.",
      "skills": [
        "Treasury",
        "Cash Management",
        "Financial Analysis",
        "Excel"
      ],
      "scope":
          "Works in banks, corporations and financial institutions.",
      "salaryRange": "Depends on experience and organization.",
    },

    // ==========================================================
    // 6. LAW - 10
    // ==========================================================

    {
      "careerName": "Lawyer",
      "category": "law",
      "categoryName": "Law",
      "role": "graduate",
      "description":
          "Provides legal advice and represents clients in legal matters.",
      "education":
          "Law degree followed by required professional licensing.",
      "skills": [
        "Legal Research",
        "Communication",
        "Argumentation",
        "Critical Thinking"
      ],
      "scope":
          "Lawyers can work in law firms, companies, government and private practice.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Legal Consultant",
      "category": "law",
      "categoryName": "Law",
      "role": "graduate",
      "description":
          "Provides legal guidance to organizations and individuals.",
      "education":
          "Law degree and relevant professional qualification.",
      "skills": [
        "Legal Research",
        "Advisory",
        "Communication",
        "Analysis"
      ],
      "scope":
          "Works with companies, law firms and organizations requiring legal advice.",
      "salaryRange": "Depends on experience and specialization.",
    },

    {
      "careerName": "Corporate Lawyer",
      "category": "law",
      "categoryName": "Law",
      "role": "graduate",
      "description":
          "Handles legal matters related to businesses, companies and commercial transactions.",
      "education":
          "Law degree and required professional qualification.",
      "skills": [
        "Corporate Law",
        "Contract Law",
        "Negotiation",
        "Legal Research"
      ],
      "scope":
          "Works in corporations, law firms and business organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Criminal Lawyer",
      "category": "law",
      "categoryName": "Law",
      "role": "graduate",
      "description":
          "Represents clients and handles legal matters involving criminal law.",
      "education":
          "Law degree and required professional licensing.",
      "skills": [
        "Criminal Law",
        "Legal Research",
        "Court Procedures",
        "Communication"
      ],
      "scope":
          "Works in law firms, courts and private legal practice.",
      "salaryRange": "Depends on experience and practice.",
    },

    {
      "careerName": "Civil Lawyer",
      "category": "law",
      "categoryName": "Law",
      "role": "graduate",
      "description":
          "Handles disputes and legal matters involving civil law.",
      "education":
          "Law degree and required professional qualification.",
      "skills": [
        "Civil Law",
        "Legal Research",
        "Case Analysis",
        "Communication"
      ],
      "scope":
          "Works in law firms, courts and private legal practice.",
      "salaryRange": "Depends on experience and specialization.",
    },

    {
      "careerName": "Tax Lawyer",
      "category": "law",
      "categoryName": "Law",
      "role": "graduate",
      "description":
          "Provides legal advice and representation related to taxation matters.",
      "education":
          "Law degree with relevant taxation knowledge.",
      "skills": [
        "Tax Law",
        "Legal Research",
        "Taxation",
        "Analysis"
      ],
      "scope":
          "Works in law firms, corporations and financial organizations.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Legal Researcher",
      "category": "law",
      "categoryName": "Law",
      "role": "graduate",
      "description":
          "Researches laws, legal cases and regulations to support legal work.",
      "education":
          "Law degree or related legal education.",
      "skills": [
        "Legal Research",
        "Writing",
        "Analysis",
        "Law"
      ],
      "scope":
          "Works in law firms, universities, courts and research organizations.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Compliance Officer",
      "category": "law",
      "categoryName": "Law",
      "role": "graduate",
      "description":
          "Ensures that organizations follow applicable laws, policies and regulations.",
      "education":
          "Law, Business, Finance or related degree.",
      "skills": [
        "Compliance",
        "Regulations",
        "Risk Management",
        "Analysis"
      ],
      "scope":
          "Works in banks, corporations, financial institutions and regulated industries.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Intellectual Property Lawyer",
      "category": "law",
      "categoryName": "Law",
      "role": "graduate",
      "description":
          "Handles legal matters involving patents, trademarks, copyrights and intellectual property.",
      "education":
          "Law degree with knowledge of intellectual property law.",
      "skills": [
        "IP Law",
        "Legal Research",
        "Contracts",
        "Analysis"
      ],
      "scope":
          "Works with technology companies, creative industries, corporations and law firms.",
      "salaryRange": "Depends on specialization and experience.",
    },

    {
      "careerName": "Human Rights Lawyer",
      "category": "law",
      "categoryName": "Law",
      "role": "graduate",
      "description":
          "Works on legal matters related to human rights and social justice.",
      "education":
          "Law degree and relevant professional qualification.",
      "skills": [
        "Human Rights Law",
        "Legal Research",
        "Advocacy",
        "Communication"
      ],
      "scope":
          "Works with legal organizations, NGOs, courts and public interest groups.",
      "salaryRange": "Depends on organization and experience.",
    },

    // ==========================================================
    // 7. ARTS & DESIGN - 10
    // ==========================================================

    {
      "careerName": "Graphic Designer",
      "category": "arts_design",
      "categoryName": "Arts & Design",
      "role": "graduate",
      "description":
          "Creates visual designs for brands, products, advertisements and digital media.",
      "education":
          "Degree or diploma in Graphic Design, Fine Arts or related field.",
      "skills": [
        "Graphic Design",
        "Photoshop",
        "Illustrator",
        "Typography"
      ],
      "scope":
          "Works in design agencies, companies, media organizations and freelance environments.",
      "salaryRange": "Depends on experience and portfolio.",
    },

    {
      "careerName": "UI/UX Designer",
      "category": "arts_design",
      "categoryName": "Arts & Design",
      "role": "graduate",
      "description":
          "Designs user interfaces and experiences for websites, applications and digital products.",
      "education":
          "Degree in Design, Computer Science, IT or related field.",
      "skills": [
        "UI Design",
        "UX Research",
        "Figma",
        "Prototyping"
      ],
      "scope":
          "Works in software houses, startups, agencies and product companies.",
      "salaryRange": "Depends on experience and portfolio.",
    },

    {
      "careerName": "Animator",
      "category": "arts_design",
      "categoryName": "Arts & Design",
      "role": "graduate",
      "description":
          "Creates animated visual content for films, advertisements, games and digital media.",
      "education":
          "Degree or diploma in Animation, Design or Fine Arts.",
      "skills": [
        "Animation",
        "Storyboarding",
        "3D Software",
        "Visual Design"
      ],
      "scope":
          "Works in animation studios, advertising agencies, media companies and game studios.",
      "salaryRange": "Depends on experience and portfolio.",
    },

    {
      "careerName": "Illustrator",
      "category": "arts_design",
      "categoryName": "Arts & Design",
      "role": "graduate",
      "description":
          "Creates illustrations for books, brands, publications and digital products.",
      "education":
          "Degree or diploma in Fine Arts, Illustration or Design.",
      "skills": [
        "Drawing",
        "Illustration",
        "Digital Art",
        "Creativity"
      ],
      "scope":
          "Works with publishers, agencies, brands and freelance clients.",
      "salaryRange": "Depends on experience and portfolio.",
    },

    {
      "careerName": "Art Director",
      "category": "arts_design",
      "categoryName": "Arts & Design",
      "role": "graduate",
      "description":
          "Leads the visual direction of creative projects and campaigns.",
      "education":
          "Degree in Fine Arts, Design or related field.",
      "skills": [
        "Creative Direction",
        "Design",
        "Leadership",
        "Branding"
      ],
      "scope":
          "Works in advertising agencies, media companies and creative organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Motion Graphics Designer",
      "category": "arts_design",
      "categoryName": "Arts & Design",
      "role": "graduate",
      "description":
          "Creates animated graphics and visual effects for digital media.",
      "education":
          "Degree or diploma in Design, Animation or Multimedia.",
      "skills": [
        "Motion Graphics",
        "After Effects",
        "Video Editing",
        "Animation"
      ],
      "scope":
          "Works in advertising, media, video production and digital marketing.",
      "salaryRange": "Depends on experience and portfolio.",
    },

    {
      "careerName": "Product Designer",
      "category": "arts_design",
      "categoryName": "Arts & Design",
      "role": "graduate",
      "description":
          "Designs products by combining user needs, visual design and functionality.",
      "education":
          "Degree in Product Design, Industrial Design or related field.",
      "skills": [
        "Product Design",
        "UX",
        "Prototyping",
        "Research"
      ],
      "scope":
          "Works in technology companies, product companies and design studios.",
      "salaryRange": "Depends on experience and specialization.",
    },

    {
      "careerName": "Interior Designer",
      "category": "arts_design",
      "categoryName": "Arts & Design",
      "role": "graduate",
      "description":
          "Plans and designs functional and visually appealing interior spaces.",
      "education":
          "Degree or diploma in Interior Design or related field.",
      "skills": [
        "Interior Design",
        "AutoCAD",
        "3D Modeling",
        "Space Planning"
      ],
      "scope":
          "Works with architecture firms, design studios, construction companies and private clients.",
      "salaryRange": "Depends on experience and projects.",
    },

    {
      "careerName": "Fashion Designer",
      "category": "arts_design",
      "categoryName": "Arts & Design",
      "role": "graduate",
      "description":
          "Creates clothing and fashion concepts based on design, materials and trends.",
      "education":
          "Degree or diploma in Fashion Design or related field.",
      "skills": [
        "Fashion Design",
        "Sketching",
        "Textiles",
        "Creativity"
      ],
      "scope":
          "Works with fashion brands, textile companies and independent businesses.",
      "salaryRange": "Depends on experience and brand.",
    },

    {
      "careerName": "Creative Director",
      "category": "arts_design",
      "categoryName": "Arts & Design",
      "role": "graduate",
      "description":
          "Leads creative teams and develops the overall creative direction of projects.",
      "education":
          "Degree in Design, Fine Arts, Media or related field.",
      "skills": [
        "Creative Direction",
        "Leadership",
        "Branding",
        "Communication"
      ],
      "scope":
          "Works in advertising agencies, media companies and creative businesses.",
      "salaryRange": "Depends on experience and organization.",
    },

    // ==========================================================
    // 8. MEDIA & COMMUNICATION - 10
    // ==========================================================

    {
      "careerName": "Journalist",
      "category": "media_communication",
      "categoryName": "Media & Communication",
      "role": "graduate",
      "description":
          "Researches and reports news and information for media organizations.",
      "education":
          "Degree in Journalism, Mass Communication or related field.",
      "skills": [
        "Writing",
        "Research",
        "Interviewing",
        "Communication"
      ],
      "scope":
          "Works in newspapers, television, online media and news organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Content Creator",
      "category": "media_communication",
      "categoryName": "Media & Communication",
      "role": "graduate",
      "description":
          "Creates digital content for social media, websites and online platforms.",
      "education":
          "Degree in Media, Communication, Marketing or related field can be helpful.",
      "skills": [
        "Content Creation",
        "Video Editing",
        "Writing",
        "Social Media"
      ],
      "scope":
          "Works with brands, agencies, media companies or independently.",
      "salaryRange": "Depends on experience, platform and audience.",
    },

    {
      "careerName": "Public Relations Specialist",
      "category": "media_communication",
      "categoryName": "Media & Communication",
      "role": "graduate",
      "description":
          "Manages communication between organizations and the public.",
      "education":
          "Degree in Public Relations, Communication, Marketing or related field.",
      "skills": [
        "Public Relations",
        "Communication",
        "Writing",
        "Media Relations"
      ],
      "scope":
          "Works in companies, PR agencies, government organizations and NGOs.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "News Reporter",
      "category": "media_communication",
      "categoryName": "Media & Communication",
      "role": "graduate",
      "description":
          "Collects information and reports current events for news audiences.",
      "education":
          "Degree in Journalism, Mass Communication or related field.",
      "skills": [
        "Reporting",
        "Research",
        "Interviewing",
        "Writing"
      ],
      "scope":
          "Works in television, newspapers, radio and digital news platforms.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Copywriter",
      "category": "media_communication",
      "categoryName": "Media & Communication",
      "role": "graduate",
      "description":
          "Writes persuasive and informative content for advertising and marketing.",
      "education":
          "Degree in Communication, English, Marketing or related field.",
      "skills": [
        "Copywriting",
        "Writing",
        "Marketing",
        "Creativity"
      ],
      "scope":
          "Works in advertising agencies, marketing teams and digital businesses.",
      "salaryRange": "Depends on experience and portfolio.",
    },

    {
      "careerName": "Social Media Manager",
      "category": "media_communication",
      "categoryName": "Media & Communication",
      "role": "graduate",
      "description":
          "Manages social media accounts, content strategies and online communities.",
      "education":
          "Degree in Marketing, Communication, Media or related field.",
      "skills": [
        "Social Media",
        "Content Strategy",
        "Analytics",
        "Communication"
      ],
      "scope":
          "Works in brands, agencies, startups and media organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Broadcast Producer",
      "category": "media_communication",
      "categoryName": "Media & Communication",
      "role": "graduate",
      "description":
          "Plans and coordinates television, radio or digital broadcast productions.",
      "education":
          "Degree in Media, Communication, Journalism or related field.",
      "skills": [
        "Production",
        "Planning",
        "Communication",
        "Media Management"
      ],
      "scope":
          "Works in television channels, radio stations and digital media companies.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Editor",
      "category": "media_communication",
      "categoryName": "Media & Communication",
      "role": "graduate",
      "description":
          "Reviews and improves written content for accuracy, clarity and quality.",
      "education":
          "Degree in English, Journalism, Communication or related field.",
      "skills": [
        "Editing",
        "Writing",
        "Grammar",
        "Attention to Detail"
      ],
      "scope":
          "Works in publishing, media companies, websites and content agencies.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Communications Specialist",
      "category": "media_communication",
      "categoryName": "Media & Communication",
      "role": "graduate",
      "description":
          "Develops communication materials and manages organizational messaging.",
      "education":
          "Degree in Communication, Media, Journalism or related field.",
      "skills": [
        "Communication",
        "Writing",
        "Public Relations",
        "Content Strategy"
      ],
      "scope":
          "Works in corporations, NGOs, government organizations and communication agencies.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Media Planner",
      "category": "media_communication",
      "categoryName": "Media & Communication",
      "role": "graduate",
      "description":
          "Plans advertising placements across different media channels to reach target audiences.",
      "education":
          "Degree in Media, Marketing, Communication or related field.",
      "skills": [
        "Media Planning",
        "Marketing",
        "Analytics",
        "Research"
      ],
      "scope":
          "Works in advertising agencies, media agencies and large marketing departments.",
      "salaryRange": "Depends on experience and organization.",
    },

    // ==========================================================
    // 9. SCIENCE & RESEARCH - 10
    // ==========================================================

    {
      "careerName": "Research Scientist",
      "category": "science_research",
      "categoryName": "Science & Research",
      "role": "graduate",
      "description":
          "Conducts scientific research to develop knowledge and solve scientific problems.",
      "education":
          "Bachelor's degree in a relevant science field; advanced research may require higher education.",
      "skills": [
        "Scientific Research",
        "Data Analysis",
        "Experimentation",
        "Scientific Writing"
      ],
      "scope":
          "Works in universities, laboratories, research institutes and scientific organizations.",
      "salaryRange": "Depends on field, qualification and organization.",
    },

    {
      "careerName": "Laboratory Researcher",
      "category": "science_research",
      "categoryName": "Science & Research",
      "role": "graduate",
      "description":
          "Conducts laboratory experiments and analyzes scientific samples and results.",
      "education":
          "Bachelor's degree in Biology, Chemistry, Physics or related field.",
      "skills": [
        "Laboratory Work",
        "Research",
        "Data Analysis",
        "Scientific Methods"
      ],
      "scope":
          "Works in laboratories, universities, research institutes and industries.",
      "salaryRange": "Depends on experience and specialization.",
    },

    {
      "careerName": "Biotechnologist",
      "category": "science_research",
      "categoryName": "Science & Research",
      "role": "graduate",
      "description":
          "Uses biological systems and technologies to develop useful products and processes.",
      "education":
          "Bachelor's degree in Biotechnology, Biology or related field.",
      "skills": [
        "Biotechnology",
        "Biology",
        "Laboratory Research",
        "Data Analysis"
      ],
      "scope":
          "Works in biotechnology, healthcare, agriculture, food and research organizations.",
      "salaryRange": "Depends on experience and industry.",
    },

    {
      "careerName": "Chemist",
      "category": "science_research",
      "categoryName": "Science & Research",
      "role": "graduate",
      "description":
          "Studies chemical substances, reactions and materials through scientific methods.",
      "education":
          "Bachelor's degree in Chemistry or related field.",
      "skills": [
        "Chemistry",
        "Laboratory Work",
        "Research",
        "Data Analysis"
      ],
      "scope":
          "Works in laboratories, pharmaceutical companies, manufacturing and research institutes.",
      "salaryRange": "Depends on experience and specialization.",
    },

    {
      "careerName": "Physicist",
      "category": "science_research",
      "categoryName": "Science & Research",
      "role": "graduate",
      "description":
          "Studies matter, energy, forces and natural physical phenomena.",
      "education":
          "Bachelor's degree in Physics; advanced research may require higher education.",
      "skills": [
        "Physics",
        "Mathematics",
        "Research",
        "Data Analysis"
      ],
      "scope":
          "Works in education, research institutions, laboratories and technology organizations.",
      "salaryRange": "Depends on specialization and qualification.",
    },

    {
      "careerName": "Biologist",
      "category": "science_research",
      "categoryName": "Science & Research",
      "role": "graduate",
      "description":
          "Studies living organisms and biological processes.",
      "education":
          "Bachelor's degree in Biology or related biological science.",
      "skills": [
        "Biology",
        "Research",
        "Laboratory Work",
        "Scientific Analysis"
      ],
      "scope":
          "Works in laboratories, universities, environmental organizations and research institutes.",
      "salaryRange": "Depends on experience and specialization.",
    },

    {
      "careerName": "Microbiologist",
      "category": "science_research",
      "categoryName": "Science & Research",
      "role": "graduate",
      "description":
          "Studies microorganisms and their effects on humans, animals, plants and environments.",
      "education":
          "Bachelor's degree in Microbiology or related field.",
      "skills": [
        "Microbiology",
        "Laboratory Research",
        "Biology",
        "Scientific Analysis"
      ],
      "scope":
          "Works in hospitals, laboratories, food industries and research organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Environmental Scientist",
      "category": "science_research",
      "categoryName": "Science & Research",
      "role": "graduate",
      "description":
          "Studies environmental conditions and develops scientific approaches to environmental problems.",
      "education":
          "Bachelor's degree in Environmental Science or related field.",
      "skills": [
        "Environmental Science",
        "Research",
        "Data Analysis",
        "Field Work"
      ],
      "scope":
          "Works in environmental organizations, government departments, industries and research institutes.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Data Researcher",
      "category": "science_research",
      "categoryName": "Science & Research",
      "role": "graduate",
      "description":
          "Collects and analyzes research data to support scientific and organizational studies.",
      "education":
          "Bachelor's degree in Data Science, Statistics, Mathematics or related field.",
      "skills": [
        "Data Analysis",
        "Statistics",
        "Research",
        "Programming"
      ],
      "scope":
          "Works in research institutions, universities, technology companies and scientific organizations.",
      "salaryRange": "Depends on experience and field.",
    },

    {
      "careerName": "Scientific Writer",
      "category": "science_research",
      "categoryName": "Science & Research",
      "role": "graduate",
      "description":
          "Communicates scientific research and technical information through clear written content.",
      "education":
          "Degree in Science, Biology, Chemistry or related field.",
      "skills": [
        "Scientific Writing",
        "Research",
        "Communication",
        "Editing"
      ],
      "scope":
          "Works with research organizations, publishers, universities and scientific companies.",
      "salaryRange": "Depends on experience and specialization.",
    },

    // ==========================================================
    // 10. EDUCATION - 10
    // ==========================================================

    {
      "careerName": "School Teacher",
      "category": "education",
      "categoryName": "Education",
      "role": "graduate",
      "description":
          "Teaches students and supports their academic and personal development.",
      "education":
          "Bachelor's degree in Education or relevant subject.",
      "skills": [
        "Teaching",
        "Communication",
        "Classroom Management",
        "Lesson Planning"
      ],
      "scope":
          "Teachers work in schools, educational institutions and learning centers.",
      "salaryRange": "Depends on institution and experience.",
    },

    {
      "careerName": "College Lecturer",
      "category": "education",
      "categoryName": "Education",
      "role": "graduate",
      "description":
          "Teaches academic subjects to college-level students.",
      "education":
          "Relevant bachelor's or master's degree depending on institution requirements.",
      "skills": [
        "Teaching",
        "Subject Knowledge",
        "Communication",
        "Presentation"
      ],
      "scope":
          "Works in colleges and higher education institutions.",
      "salaryRange": "Depends on qualification and institution.",
    },

    {
      "careerName": "University Lecturer",
      "category": "education",
      "categoryName": "Education",
      "role": "graduate",
      "description":
          "Teaches university students and may participate in academic research.",
      "education":
          "Relevant higher education qualification according to institutional requirements.",
      "skills": [
        "Teaching",
        "Research",
        "Presentation",
        "Subject Knowledge"
      ],
      "scope":
          "Works in universities, colleges and higher education institutions.",
      "salaryRange": "Depends on qualification and institution.",
    },

    {
      "careerName": "Educational Consultant",
      "category": "education",
      "categoryName": "Education",
      "role": "graduate",
      "description":
          "Provides advice to students, institutions or organizations on educational planning and development.",
      "education":
          "Degree in Education, Management, Psychology or related field.",
      "skills": [
        "Education Planning",
        "Communication",
        "Research",
        "Advisory"
      ],
      "scope":
          "Works with schools, educational organizations, students and education projects.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Curriculum Developer",
      "category": "education",
      "categoryName": "Education",
      "role": "graduate",
      "description":
          "Designs and develops educational curricula, courses and learning materials.",
      "education":
          "Degree in Education, Subject Specialization or related field.",
      "skills": [
        "Curriculum Design",
        "Research",
        "Writing",
        "Education"
      ],
      "scope":
          "Works in schools, universities, educational publishers and education organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    {
      "careerName": "Academic Coordinator",
      "category": "education",
      "categoryName": "Education",
      "role": "graduate",
      "description":
          "Coordinates academic activities, schedules and educational programs.",
      "education":
          "Bachelor's or Master's degree in Education or related field.",
      "skills": [
        "Planning",
        "Coordination",
        "Communication",
        "Education Management"
      ],
      "scope":
          "Works in schools, colleges, universities and educational organizations.",
      "salaryRange": "Depends on institution and experience.",
    },

    {
      "careerName": "Instructional Designer",
      "category": "education",
      "categoryName": "Education",
      "role": "graduate",
      "description":
          "Designs effective learning experiences, courses and educational content.",
      "education":
          "Degree in Education, Instructional Design, Psychology or related field.",
      "skills": [
        "Instructional Design",
        "E-Learning",
        "Content Development",
        "Research"
      ],
      "scope":
          "Works in universities, online education companies and corporate training departments.",
      "salaryRange": "Depends on experience and specialization.",
    },

    {
      "careerName": "Education Researcher",
      "category": "education",
      "categoryName": "Education",
      "role": "graduate",
      "description":
          "Conducts research to improve teaching methods, learning outcomes and education systems.",
      "education":
          "Degree in Education, Psychology, Sociology or related field.",
      "skills": [
        "Research",
        "Data Analysis",
        "Education",
        "Scientific Writing"
      ],
      "scope":
          "Works in universities, research institutes and education organizations.",
      "salaryRange": "Depends on organization and qualification.",
    },

    {
      "careerName": "Career Counselor",
      "category": "education",
      "categoryName": "Education",
      "role": "graduate",
      "description":
          "Helps students and individuals explore education and career options.",
      "education":
          "Degree in Education, Psychology, Counseling or related field.",
      "skills": [
        "Counseling",
        "Communication",
        "Career Planning",
        "Assessment"
      ],
      "scope":
          "Works in schools, colleges, universities and career guidance organizations.",
      "salaryRange": "Depends on qualification and organization.",
    },

    {
      "careerName": "Training Specialist",
      "category": "education",
      "categoryName": "Education",
      "role": "graduate",
      "description":
          "Designs and delivers training programs to develop professional skills.",
      "education":
          "Degree in Education, Human Resources, Business or related field.",
      "skills": [
        "Training",
        "Presentation",
        "Communication",
        "Program Development"
      ],
      "scope":
          "Works in companies, educational institutions and professional training organizations.",
      "salaryRange": "Depends on experience and organization.",
    },

    // ==========================================================
    // 11. PSYCHOLOGY & SOCIAL SCIENCES - 10
    // ==========================================================

    {
      "careerName": "Psychologist",
      "category": "psychology_social_sciences",
      "categoryName": "Psychology & Social Sciences",
      "role": "graduate",
      "description":
          "Studies human behavior and provides psychological assessment and support within professional scope.",
      "education":
          "Degree in Psychology and required professional training.",
      "skills": [
        "Psychology",
        "Assessment",
        "Communication",
        "Research"
      ],
      "scope":
          "Psychologists can work in educational, organizational, research and healthcare settings.",
      "salaryRange": "Depends on qualification and experience.",
    },

    {
      "careerName": "Counselor",
      "category": "psychology_social_sciences",
      "categoryName": "Psychology & Social Sciences",
      "role": "graduate",
      "description":
          "Provides structured guidance and support to individuals dealing with personal, educational or career concerns.",
      "education":
          "Degree in Counseling, Psychology, Education or related field with appropriate training.",
      "skills": [
        "Counseling",
        "Communication",
        "Active Listening",
        "Assessment"
      ],
      "scope":
          "Works in schools, colleges, organizations and community services.",
      "salaryRange": "Depends on qualification and workplace.",
    },

    {
      "careerName": "Social Researcher",
      "category": "psychology_social_sciences",
      "categoryName": "Psychology & Social Sciences",
      "role": "graduate",
      "description":
          "Studies social behavior, communities and social issues through research methods.",
      "education":
          "Degree in Sociology, Social Sciences, Psychology or related field.",
      "skills": [
        "Research",
        "Data Collection",
        "Statistics",
        "Report Writing"
      ],
      "scope":
          "Works in universities, NGOs, research organizations and government projects.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Sociologist",
      "category": "psychology_social_sciences",
      "categoryName": "Psychology & Social Sciences",
      "role": "graduate",
      "description":
          "Studies society, social relationships, institutions and patterns of human behavior.",
      "education":
          "Bachelor's degree in Sociology or related social science.",
      "skills": [
        "Sociology",
        "Research",
        "Data Analysis",
        "Critical Thinking"
      ],
      "scope":
          "Works in research institutions, universities, NGOs and public organizations.",
      "salaryRange": "Depends on qualification and organization.",
    },

    {
      "careerName": "Social Worker",
      "category": "psychology_social_sciences",
      "categoryName": "Psychology & Social Sciences",
      "role": "graduate",
      "description":
          "Supports individuals and communities by connecting them with social services and resources.",
      "education":
          "Degree in Social Work, Sociology or related field.",
      "skills": [
        "Communication",
        "Community Work",
        "Case Management",
        "Problem Solving"
      ],
      "scope":
          "Works in NGOs, community organizations, hospitals and social services.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Organizational Psychologist",
      "category": "psychology_social_sciences",
      "categoryName": "Psychology & Social Sciences",
      "role": "graduate",
      "description":
          "Applies psychology principles to workplaces, employee behavior and organizational performance.",
      "education":
          "Degree in Psychology or Organizational Psychology with relevant training.",
      "skills": [
        "Psychology",
        "Employee Assessment",
        "Research",
        "Communication"
      ],
      "scope":
          "Works in corporations, HR departments and consulting organizations.",
      "salaryRange": "Depends on qualification and experience.",
    },

    {
      "careerName": "Community Development Officer",
      "category": "psychology_social_sciences",
      "categoryName": "Psychology & Social Sciences",
      "role": "graduate",
      "description":
          "Plans and supports projects aimed at improving community development and social wellbeing.",
      "education":
          "Degree in Social Sciences, Development Studies, Sociology or related field.",
      "skills": [
        "Community Development",
        "Project Management",
        "Communication",
        "Research"
      ],
      "scope":
          "Works in NGOs, development organizations and community programs.",
      "salaryRange": "Depends on organization and project.",
    },

    {
      "careerName": "Behavioral Researcher",
      "category": "psychology_social_sciences",
      "categoryName": "Psychology & Social Sciences",
      "role": "graduate",
      "description":
          "Researches patterns of human behavior using scientific and analytical methods.",
      "education":
          "Degree in Psychology, Behavioral Science, Sociology or related field.",
      "skills": [
        "Behavioral Research",
        "Statistics",
        "Data Analysis",
        "Research"
      ],
      "scope":
          "Works in universities, research institutes, organizations and consulting firms.",
      "salaryRange": "Depends on qualification and organization.",
    },

    {
      "careerName": "Human Services Specialist",
      "category": "psychology_social_sciences",
      "categoryName": "Psychology & Social Sciences",
      "role": "graduate",
      "description":
          "Supports people in accessing social, community and human services.",
      "education":
          "Degree in Social Work, Psychology, Sociology or related field.",
      "skills": [
        "Communication",
        "Case Management",
        "Social Services",
        "Problem Solving"
      ],
      "scope":
          "Works in community organizations, NGOs, social services and support programs.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Policy Researcher",
      "category": "psychology_social_sciences",
      "categoryName": "Psychology & Social Sciences",
      "role": "graduate",
      "description":
          "Researches social and public issues to support evidence-based policy development.",
      "education":
          "Degree in Social Sciences, Economics, Political Science or related field.",
      "skills": [
        "Policy Research",
        "Data Analysis",
        "Research",
        "Report Writing"
      ],
      "scope":
          "Works in think tanks, universities, NGOs and government-related organizations.",
      "salaryRange": "Depends on organization and experience.",
    },

    // ==========================================================
    // 12. GOVERNMENT & PUBLIC ADMINISTRATION - 10
    // ==========================================================

    {
      "careerName": "Civil Services Officer",
      "category": "government",
      "categoryName": "Government & Public Administration",
      "role": "graduate",
      "description":
          "Works in government administration and public service through relevant civil service pathways.",
      "education":
          "Bachelor's degree followed by the required competitive examination and selection process.",
      "skills": [
        "Administration",
        "Communication",
        "Leadership",
        "Problem Solving"
      ],
      "scope":
          "Civil service officers can work across different government departments and public institutions.",
      "salaryRange": "Depends on government grade and position.",
    },

    {
      "careerName": "Policy Analyst",
      "category": "government",
      "categoryName": "Government & Public Administration",
      "role": "graduate",
      "description":
          "Researches public issues and analyzes policies to support government decision making.",
      "education":
          "Degree in Public Policy, Economics, Political Science, Social Sciences or related field.",
      "skills": [
        "Policy Analysis",
        "Research",
        "Data Analysis",
        "Report Writing"
      ],
      "scope":
          "Works in government departments, think tanks, NGOs and policy organizations.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Government Officer",
      "category": "government",
      "categoryName": "Government & Public Administration",
      "role": "graduate",
      "description":
          "Performs administrative and public service responsibilities within government departments.",
      "education":
          "Bachelor's degree or qualification required for the relevant government position.",
      "skills": [
        "Administration",
        "Communication",
        "Documentation",
        "Problem Solving"
      ],
      "scope":
          "Works in federal, provincial and local government departments.",
      "salaryRange": "Depends on government grade and position.",
    },

    {
      "careerName": "Administrative Officer",
      "category": "government",
      "categoryName": "Government & Public Administration",
      "role": "graduate",
      "description":
          "Manages administrative processes, records and departmental operations.",
      "education":
          "Bachelor's degree in Public Administration, Business or related field.",
      "skills": [
        "Administration",
        "Planning",
        "Documentation",
        "Communication"
      ],
      "scope":
          "Works in government offices, public institutions and administrative departments.",
      "salaryRange": "Depends on government grade and organization.",
    },

    {
      "careerName": "Public Administration Specialist",
      "category": "government",
      "categoryName": "Government & Public Administration",
      "role": "graduate",
      "description":
          "Supports effective management and administration of public sector organizations.",
      "education":
          "Degree in Public Administration, Management, Political Science or related field.",
      "skills": [
        "Public Administration",
        "Management",
        "Policy",
        "Planning"
      ],
      "scope":
          "Works in government departments, public institutions and development organizations.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Foreign Affairs Officer",
      "category": "government",
      "categoryName": "Government & Public Administration",
      "role": "graduate",
      "description":
          "Works on international relations, diplomacy and foreign affairs matters.",
      "education":
          "Degree in International Relations, Political Science, Law or related field.",
      "skills": [
        "International Relations",
        "Communication",
        "Research",
        "Negotiation"
      ],
      "scope":
          "Works in foreign affairs departments, diplomatic services and international organizations.",
      "salaryRange": "Depends on government grade and position.",
    },

    {
      "careerName": "Revenue Officer",
      "category": "government",
      "categoryName": "Government & Public Administration",
      "role": "graduate",
      "description":
          "Handles government revenue, taxation or related administrative responsibilities.",
      "education":
          "Degree in Finance, Accounting, Economics, Law or relevant field.",
      "skills": [
        "Taxation",
        "Finance",
        "Administration",
        "Record Management"
      ],
      "scope":
          "Works in government revenue and taxation departments.",
      "salaryRange": "Depends on government grade and position.",
    },

    {
      "careerName": "Public Policy Researcher",
      "category": "government",
      "categoryName": "Government & Public Administration",
      "role": "graduate",
      "description":
          "Conducts research on public policies and evaluates their potential impact.",
      "education":
          "Degree in Public Policy, Political Science, Economics or Social Sciences.",
      "skills": [
        "Policy Research",
        "Data Analysis",
        "Research",
        "Report Writing"
      ],
      "scope":
          "Works in government departments, think tanks, universities and research organizations.",
      "salaryRange": "Depends on organization and experience.",
    },

    {
      "careerName": "Local Government Officer",
      "category": "government",
      "categoryName": "Government & Public Administration",
      "role": "graduate",
      "description":
          "Supports administration and service delivery at the local government level.",
      "education":
          "Bachelor's degree in Public Administration, Management or related field.",
      "skills": [
        "Local Administration",
        "Planning",
        "Communication",
        "Public Service"
      ],
      "scope":
          "Works in municipal and local government organizations.",
      "salaryRange": "Depends on government grade and position.",
    },

    {
      "careerName": "Development Program Officer",
      "category": "government",
      "categoryName": "Government & Public Administration",
      "role": "graduate",
      "description":
          "Coordinates development programs and projects designed to improve public services and communities.",
      "education":
          "Degree in Development Studies, Public Administration, Economics or related field.",
      "skills": [
        "Project Management",
        "Development Planning",
        "Research",
        "Communication"
      ],
      "scope":
          "Works in government development departments, NGOs and development organizations.",
      "salaryRange": "Depends on organization and project.",
    },
  ];

  // ============================================================
  // INSERT CAREERS
  // ============================================================

  int added = 0;

  for (final career in careers) {
    try {
      await firestore.collection("careerBank").add({
        ...career,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });

      added++;

      print(
        "✅ Added: ${career["careerName"]} "
        "(${career["category"]}) "
        "[${career["role"]}]",
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
  print("Computer Science & IT : 10");
  print("Medical & Healthcare  : 10");
  print("Engineering            : 10");
  print("Business & Management  : 10");
  print("Finance & Accounting   : 10");
  print("Law                    : 10");
  print("Arts & Design          : 10");
  print("Media & Communication  : 10");
  print("Science & Research     : 10");
  print("Education              : 10");
  print("Psychology & Social    : 10");
  print("Government             : 10");
  print("");
  print("TOTAL                  : 120");
  print("");
  print("Role       : graduate");
  print("Collection : careerBank");
  print("======================================");
}