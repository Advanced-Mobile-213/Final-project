import 'prompt.dart';

class GetPromptsResponse {
  final bool hasNext;
  final int offset;
  final int limit;
  final int total;
  final List<Prompt> items;

  GetPromptsResponse({
    required this.hasNext,
    required this.offset,
    required this.limit,
    required this.total,
    required this.items,
  });

  factory GetPromptsResponse.fromJson(Map<String, dynamic> json) {
    final List<Prompt> items = [];
    json['items'].forEach((item) {
      items.add(Prompt.fromJson(item));
    });

    return GetPromptsResponse(
      hasNext: json['hasNext'],
      offset: json['offset'],
      limit: json['limit'],
      total: json['total'],
      items: items,
    );
  }
}
