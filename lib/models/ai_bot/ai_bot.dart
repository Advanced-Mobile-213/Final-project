class AiBot {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String id;
  final String assistantName;
  final String openAiAssistantId;
  final String? instructions;
  final String? description;
  final String? openAiThreadIdPlay;

  AiBot({
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.id,
    required this.assistantName,
    required this.openAiAssistantId,
    this.instructions,
    this.description,
    this.openAiThreadIdPlay,
  });

  factory AiBot.fromJson(Map<String, dynamic> json) {
    return AiBot(
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      id: json['id'],
      assistantName: json['assistantName'],
      openAiAssistantId: json['openAiAssistantId'],
      instructions: json['instructions'],
      description: json['description'],
      openAiThreadIdPlay: json['openAiThreadIdPlay'],
    );
  }
}
