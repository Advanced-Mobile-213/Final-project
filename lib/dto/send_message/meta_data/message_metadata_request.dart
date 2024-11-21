import 'package:chatbot_agents/dto/send_message/meta_data/assistant_request.dart';

class MessageMetadataRequest {
  final AssistantRequest assistant;
  final String role;
  final String content;
  final List<String> files;
  final bool? isError;

  MessageMetadataRequest({
    required this.assistant,
    required this.role,
    required this.content,
    required this.files,
    this.isError,
  });

  factory MessageMetadataRequest.fromJson(Map<String, dynamic> json) {
    return MessageMetadataRequest(
      assistant: AssistantRequest.fromJson(json['assistant']),
      role: json['role'],
      content: json['content'],
      files: List<String>.from(json['files']),
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
    return 'MessageMetadataDto{assistant: $assistant, role: $role, content: $content, files: $files, isError: $isError}';
  }
}