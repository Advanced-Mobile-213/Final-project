import 'package:chatbot_agents/constants/prompt_category.dart';

class Prompt {
  final String _id;
  final String createdAt;
  final String updatedAt;
  final PromptCategory category;
  final String content;
  final String? description;
  final bool isPublic;
  final String language;
  final String title;
  final String userId;
  final String userName;
  final bool isFavorite;

  Prompt({
    required String id,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.content,
    this.description,
    required this.isPublic,
    required this.language,
    required this.title,
    required this.userId,
    required this.userName,
    required this.isFavorite,
  }) : _id = id;

  // constructor from json
  factory Prompt.fromJson(Map<String, dynamic> json) {
    return Prompt(
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      category: json['category'],
      content: json['content'],
      description: json['description'],
      isPublic: json['isPublic'],
      language: json['language'],
      title: json['title'],
      userId: json['userId'],
      userName: json['userName'],
      isFavorite: json['isFavorite'],
    );
  }

  String get id => _id;
}
