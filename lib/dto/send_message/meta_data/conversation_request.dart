import 'package:chatbot_agents/dto/send_message/meta_data/message_metadata_request.dart';

class ConversationRequest {
  final List<MessageMetadataRequest> messages;
  final String id;

  ConversationRequest({
    required this.messages,
    required this.id,
  });

  factory ConversationRequest.fromJson(Map<String, dynamic> json) {
    return ConversationRequest(
      messages: List<MessageMetadataRequest>
          .from(
            json['messages'].map(
              (x) => MessageMetadataRequest.fromJson(x)
            )
          ),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messages': messages.map((x) => x.toJson()).toList(),
      'id': id,
    };
  }

  @override
  String toString() {
    return 'ConversationDto{messages: $messages, id: $id}';
  }
}