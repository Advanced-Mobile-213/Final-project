import 'package:chatbot_agents/dto/email_reply/meta_data/ai_email_meta_data_request.dart';
import 'package:chatbot_agents/dto/send_message/meta_data/assistant_request.dart';

class AiReplyEmailRequest {
  final AssistantRequest assistant;
  final String email;
  final String action;
  final String mainIdea;
  final AiEmailMetaDataRequest metadata;

  AiReplyEmailRequest({
    required this.assistant,
    required this.email,
    required this.action,
    required this.mainIdea,
    required this.metadata,
  });

  factory AiReplyEmailRequest.fromJson(Map<String, dynamic> json) {
    return AiReplyEmailRequest(
      assistant: AssistantRequest.fromJson(json['assistant']),
      email: json['email'],
      action: json['action'],
      mainIdea: json['mainIdea'],
      metadata: AiEmailMetaDataRequest.fromJson(json['metadata']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assistant': assistant.toJson(),
      'email': email,
      'action': action,
      'mainIdea': mainIdea,
      'metadata': metadata.toJson(),
    };
  }

  @override
  String toString() {
    return 'AiReplyEmailRequest{assistant: $assistant, email: $email, action: $action, mainIdea: $mainIdea, metadata: $metadata}';
  }
  
}