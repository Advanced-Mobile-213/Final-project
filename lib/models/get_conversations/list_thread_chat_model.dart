import 'package:chatbot_agents/models/get_conversations/thread_chat_model.dart';

class ListThreadChatModel {
  final String? cursor;
  final bool hasMore;
  final int limit;
  final List<ThreadChatModel> items;

  ListThreadChatModel({
    required this.cursor,
    required this.hasMore,
    required this.limit,
    required this.items,
  });

  factory ListThreadChatModel.fromJson(Map<String, dynamic> json) {
    //print('json: ${json}');
    return ListThreadChatModel(
      cursor: json['cursor'],
      hasMore: json['has_more'],
      limit: json['limit'],
      items: (json['items'] as List)
          .map((e) => ThreadChatModel.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'ListThreadChatModel{cursor: $cursor, hasMore: $hasMore, limit: $limit, items: $items}';
  }
}