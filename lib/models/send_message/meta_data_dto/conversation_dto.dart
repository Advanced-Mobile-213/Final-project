import 'package:chatbot_agents/models/send_message/meta_data_dto/message_metadata_dto.dart';

class ConversationDto {
  final List<MessageMetadataDto> messages;
  final String id;

  ConversationDto({
    required this.messages,
    required this.id,
  });

  factory ConversationDto.fromJson(Map<String, dynamic> json) {
    return ConversationDto(
      messages: List<MessageMetadataDto>
          .from(
            json['messages'].map(
              (x) => MessageMetadataDto.fromJson(x)
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