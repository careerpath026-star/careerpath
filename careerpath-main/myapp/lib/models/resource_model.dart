// lib/models/resource_model.dart

class ResourceModel {
  final String id;
  final String title;
  final String category;
  final String fileUrl;
  final String tag;

  ResourceModel({
    required this.id,
    required this.title,
    required this.category,
    required this.fileUrl,
    required this.tag,
  });

  factory ResourceModel.fromMap(String id, Map<String, dynamic> map) {
    return ResourceModel(
      id: id,
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      fileUrl: map['file_url'] ?? '',
      tag: map['tag'] ?? '',
    );
  }
}