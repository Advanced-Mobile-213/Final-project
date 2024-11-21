import 'package:chatbot_agents/models/get_conversation_history/couple_message_model.dart';

class ListCoupleMessageModel {
  String cursor;
  bool hasMore;
  int limit;
  List<CoupleMessageModel> items;

  ListCoupleMessageModel({
    required this.cursor,
    required this.hasMore,
    required this.limit,
    required this.items,
  });

  factory ListCoupleMessageModel.fromJson(Map<String, dynamic> json) {
    return ListCoupleMessageModel(
      cursor: json['cursor'],
      hasMore: json['has_more'],
      limit: json['limit'],
      items: (json['items'] as List)
          .map((e) => CoupleMessageModel.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'ListMessageResponseModel{cursor: $cursor, hasMore: $hasMore, limit: $limit, items: $items}';
  }
}