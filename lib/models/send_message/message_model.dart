import 'package:chatbot_agents/models/send_message/meta_data_dto/assistant_dto.dart';

class MessageModel {
   final AssistantDto assistant;
  final String role;
  final String content;
  final List<String>? files;
  final bool? isError;

  MessageModel({
    required this.assistant,
    required this.role,
    required this.content,
    this.files,
    this.isError,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      assistant: AssistantDto.fromJson(json['assistant']),
      role: json['role'],
      content: json['content'],
      files: json['files'] != null 
          ? List<String>.from(json['files']) 
          : null,
      isError: json['isError'] ? json['isError'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assistant': assistant.toJson(),
      'role': role,
      'content': content,
      'files': files,
      'isError': isError,
    };
  }

  @override
  String toString() {
    return 'MessageModel{assistant: $assistant, role: $role, content: $content, files: $files, isError: $isError}';
  }
}
