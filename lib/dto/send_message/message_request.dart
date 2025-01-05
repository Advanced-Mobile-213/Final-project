import 'package:chatbot_agents/dto/send_message/meta_data/assistant_request.dart';
import 'package:chatbot_agents/dto/send_message/meta_data/conversation_request.dart';

class MessageRequest {
  final AssistantRequest? assistant;
  final String content;
  final List<String>? files;
  final ConversationRequest? conversation;

  MessageRequest({
    this.assistant,
    required this.content,
    this.files,
    this.conversation,
  });

  factory MessageRequest.fromJson(Map<String, dynamic> json) {
    return MessageRequest(
      assistant: json['assistant'] != null 
          ? AssistantRequest.fromJson(json['assistant'])
          : null,
      content: json['content'],
      files: json['files'] != null 
          ? List<String>.from(json['files']) 
          : null,
      conversation: json['metadata']['conversation'] != null 
          ? ConversationRequest.fromJson(json['metadata']['conversation'])
          : null,
    );
  }

  @override
  String toString() {
    return 'MessageRequestDto{assistant: $assistant, content: $content, files: $files, conversation: $conversation}';
  }
}