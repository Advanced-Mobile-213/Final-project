import 'package:chatbot_agents/dto/email_reply/meta_data/ai_email_meta_data_request.dart';
import 'package:chatbot_agents/dto/send_message/meta_data/assistant_request.dart';

class SuggestReplyIdeaRequest {
  final AssistantRequest assistant;
  final String email;
  final String action;
  final AiEmailMetaDataRequest metadata;

  SuggestReplyIdeaRequest({
    required this.assistant,
    required this.email,
    required this.action,
    required this.metadata,
  });

  factory SuggestReplyIdeaRequest.fromJson(Map<String, dynamic> json) {
    return SuggestReplyIdeaRequest(
      assistant: AssistantRequest.fromJson(json['assistant']),
      email: json['email'],
      action: json['action'],
      metadata: AiEmailMetaDataRequest.fromJson(json['metadata']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assistant': assistant.toJson(),
      'email': email,
      'action': action,
      'metadata': metadata.toJson(),
    };
  }

  @override
  String toString() {
    return 'SuggestReplyIdeaRequest{assistant: $assistant, email: $email, action: $action, metadata: $metadata}';
  }
}