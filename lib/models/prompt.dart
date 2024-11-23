import 'package:chatbot_agents/constants/prompt_category.dart';
import 'package:chatbot_agents/constants/constants.dart';

class Prompt {
  String? id; // remember to set id to final when the service is implemented
  String? createdAt;
  String? updatedAt;
  PromptCategory category;
  String content;
  String description;
  bool isPublic;
  String language;
  String title;
  final String? userId;
  final String? userName;
  bool isFavorite;

  Prompt({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.category,
    required this.content,
    required this.description,
    required this.isPublic,
    required this.language,
    required this.title,
    this.userId,
    this.userName,
    this.isFavorite = false,
  });

  // constructor from json
  factory Prompt.fromJson(Map<String, dynamic> json) {
    return Prompt(
      id: json['_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      category: getCategory(json['category'] ?? ''),
      content: json['content'] ?? '',
      description: json['description'] ?? '',
      isPublic: json['isPublic'],
      language: json['language'] ?? '',
      title: json['title'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Prompt('
        'id: $id, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'category: ${category.name}, '
        'content: $content, '
        'description: $description, '
        'isPublic: $isPublic, '
        'language: $language, '
        'title: $title, '
        'userId: $userId, '
        'userName: $userName, '
        'isFavorite: $isFavorite'
        ')';
  }
}
