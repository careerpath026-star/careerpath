// lib/models/career_model.dart

class CareerModel {
  final String id;
  final String title;
  final String description;
  final String domain;
  final List<String> requiredSkills;
  final String educationPath;
  final String expectedSalary;

  CareerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.domain,
    required this.requiredSkills,
    required this.educationPath,
    required this.expectedSalary,
  });

  factory CareerModel.fromMap(String id, Map<String, dynamic> map) {
    return CareerModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      domain: map['domain'] ?? '',
      requiredSkills: List<String>.from(map['required_skills'] ?? []),
      educationPath: map['education_path'] ?? '',
      expectedSalary: map['expected_salary'] ?? '',
    );
  }
}