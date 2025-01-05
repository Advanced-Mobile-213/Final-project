import 'package:chatbot_agents/models/send_message/message_model.dart';

class ListMessageModel {
  List<MessageModel> messages;
  String id;

  ListMessageModel({
    required this.messages,
    required this.id,
  });

  factory ListMessageModel.fromJson(Map<String, dynamic> json) {
    return ListMessageModel(
      id: json['id'],
      messages: List<MessageModel>
        .from(json['messages']
          .map(
            (x) => MessageModel.fromJson(x)
          )
        ),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}