class KnowledgeUnit {
  final String createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String id;
  final String name;
  final bool status;
  final String userId;
  final String knowledgeId;

  KnowledgeUnit({
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.id,
    required this.name,
    this.status = true,
    required this.userId,
    required this.knowledgeId,
  });

  factory KnowledgeUnit.fromJson(Map<String, dynamic> json) {
    return KnowledgeUnit(
      createdAt: json['createdAt'] ?? DateTime.parse(json['createdAt']).toString(),
      updatedAt: json['updatedAt'] ?? DateTime.parse(json['updatedAt']) .toString(),
      createdBy: json['createdBy'] ?? "",
      updatedBy: json['updatedBy'] ?? "",
      id: json['id'],
      name: json['name'],
      status: json['status'] ?? false,
      userId: json['userId'],
      knowledgeId: json['knowledgeId'],
    );
  }
}
