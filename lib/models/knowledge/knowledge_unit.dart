class KnowledgeUnit {
  final String createdAt;
  final String? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String id;
  final String name;
  final String type;
  final bool status;
  final String userId;
  final String knowledgeId;
  final Map<String, dynamic> metadata;

  KnowledgeUnit({
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.id,
    required this.name,
    required this.type,
    this.status = true,
    required this.userId,
    required this.knowledgeId,
    required this.metadata,
  });

  factory KnowledgeUnit.fromJson(Map<String, dynamic> json) {
    return KnowledgeUnit(
      createdAt: json['createdAt'] ?? DateTime.parse(json['createdAt']).toString(),
      updatedAt: json['updatedAt'] ?? DateTime.parse(json['updatedAt']) .toString(),
      createdBy: json['createdBy'] ?? "",
      updatedBy: json['updatedBy'] ?? "",
      type: json['type'],
      id: json['id'],
      name: json['name'],
      status: json['status'] ?? false,
      userId: json['userId'],
      knowledgeId: json['knowledgeId'],
      metadata: json['metadata']
    );
  }

  String get formattedType {
    switch (type) {
      case 'web':
        return 'Web';
      case 'confluence':
        return 'Confluence';
      case 'slack':
        return 'Slack';
      case 'local_file':
        return 'Local File';
      default:
        return 'Unknown';
    }
  }


}
