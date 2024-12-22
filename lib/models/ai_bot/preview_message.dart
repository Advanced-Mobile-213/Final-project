class Text {
  final String value;
  final List<String> annotations;

  Text({required this.value, required this.annotations});

  factory Text.fromJson(Map<String, dynamic> json) {
    return Text(
      value: json['value'],
      annotations: List<String>.from(json['annotations']),
    );
  }
}

class Content {
  final String type;
  final Text text;

  Content({required this.type, required this.text});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      type: json['type'],
      text: Text.fromJson(json['text']),
    );
  }
}

class PreviewMessage {
  final String role; // "assistant" or "user" only
  final DateTime createdAt;
  final List<Content> content;

  PreviewMessage({
    required this.role,
    required this.createdAt,
    required this.content,
  });

  factory PreviewMessage.fromJson(Map<String, dynamic> json) {
    return PreviewMessage(
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt'].toString()),
      content: (json['content'] as List)
          .map((item) => Content.fromJson(item))
          .toList(),
    );
  }
}
