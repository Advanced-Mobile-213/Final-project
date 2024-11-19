import 'package:chatbot_agents/models/get_conversation_history/message_response_model.dart';

class ListMessageResponseModel {
  final String cursor;
  final bool hasMore;
  final int limit;
  final List<MessageResponseModel> items;

  ListMessageResponseModel({
    required this.cursor,
    required this.hasMore,
    required this.limit,
    required this.items,
  });

  factory ListMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return ListMessageResponseModel(
      cursor: json['cursor'],
      hasMore: json['has_more'],
      limit: json['limit'],
      items: (json['items'] as List)
          .map((e) => MessageResponseModel.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'ListMessageResponseModel{cursor: $cursor, hasMore: $hasMore, limit: $limit, items: $items}';
  }
}