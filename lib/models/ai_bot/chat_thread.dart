class ChatThread {
  DateTime createdAt;
  DateTime? updatedAt;
  String? createdBy;
  String? updatedBy;
  String id;
  String assistantId;
  String openAiThreadId;
  String threadName;

  ChatThread({
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.id,
    required this.assistantId,
    required this.openAiThreadId,
    required this.threadName,
  });

  factory ChatThread.fromJson(Map<String, dynamic> json) {
    return ChatThread(
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      id: json['id'],
      assistantId: json['assistantId'],
      openAiThreadId: json['openAiThreadId'],
      threadName: json['threadName'],
    );
  }
}
