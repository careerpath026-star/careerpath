// lib/models/success_story_model.dart

class SuccessStoryModel {
  final String id;
  final String rname;
  final String domain;
  final String storyText;
  final String imageUrl;

  SuccessStoryModel({
    required this.id,
    required this.rname,
    required this.domain,
    required this.storyText,
    required this.imageUrl,
  });

  factory SuccessStoryModel.fromMap(String id, Map<String, dynamic> map) {
    return SuccessStoryModel(
      id: id,
      rname: map['rname'] ?? '',
      domain: map['domain'] ?? '',
      storyText: map['story_text'] ?? '',
      imageUrl: map['image_url'] ?? '',
    );
  }
}