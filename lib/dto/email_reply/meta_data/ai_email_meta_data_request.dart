import 'package:chatbot_agents/dto/email_reply/meta_data/ai_email_style_request.dart';
import 'package:chatbot_agents/dto/email_reply/meta_data/context_request.dart';

class AiEmailMetaDataRequest {
  final List<ContextRequest> context;
  final String subject;
  final String sender;
  final String receiver;
  final String language;
  final AiEmailStyleRequest? style;

  AiEmailMetaDataRequest({
    required this.context,
    required this.subject,
    required this.sender,
    required this.receiver,
    required this.language,
    this.style,
  });

  Map<String, dynamic> toJson() {
    return {
      'context': context.map((x) => x.toJson()).toList(),
      'subject': subject,
      'sender': sender,
      'receiver': receiver,
      'language': language,
      'style': style?.toJson(),
    };
  }

  factory AiEmailMetaDataRequest.fromJson(Map<String, dynamic> json) {
    return AiEmailMetaDataRequest(
      context: List<ContextRequest>
          .from(
            json['context'].map(
              (x) => ContextRequest.fromJson(x)
            )
          ),
      subject: json['subject'],
      sender: json['sender'],
      receiver: json['receiver'],
      language: json['language'],
      style: json['style'] != null ? AiEmailStyleRequest.fromJson(json['style']) : null,
    );
  }
  
}