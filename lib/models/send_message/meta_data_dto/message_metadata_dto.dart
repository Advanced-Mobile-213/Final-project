import 'package:chatbot_agents/models/send_message/meta_data_dto/assistant_dto.dart';

class MessageMetadataDto {
  final AssistantDto assistant;
  final String role;
  final String content;
  final List<String> files;
  final bool? isError;

  MessageMetadataDto({
    required this.assistant,
    required this.role,
    required this.content,
    required this.files,
    this.isError,
  });

  factory MessageMetadataDto.fromJson(Map<String, dynamic> json) {
    return MessageMetadataDto(
      assistant: AssistantDto.fromJson(json['assistant']),
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