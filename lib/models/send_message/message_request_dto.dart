import 'package:chatbot_agents/models/send_message/meta_data_dto/assistant_dto.dart';
import 'package:chatbot_agents/models/send_message/meta_data_dto/conversation_dto.dart';

class MessageRequestDto {
  final AssistantDto? assistant;
  final String content;
  final List<String>? files;
  final ConversationDto? conversation;

  MessageRequestDto({
    this.assistant,
    required this.content,
    this.files,
    this.conversation,
  });

  factory MessageRequestDto.fromJson(Map<String, dynamic> json) {
    return MessageRequestDto(
      assistant: json['assistant'] != null 
          ? AssistantDto.fromJson(json['assistant']) 
          : null,
      content: json['content'],
      files: json['files'] != null 
          ? List<String>.from(json['files']) 
          : null,
      conversation: json['metadata']['conversation'] != null 
          ? ConversationDto.fromJson(json['metadata']['conversation']) 
          : null,
    );
  }

  @override
  String toString() {
    return 'MessageRequestDto{assistant: $assistant, content: $content, files: $files, conversation: $conversation}';
  }
}