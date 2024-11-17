class Knowledge {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String userId;
  final String knowledgeName;
  final String description;

  Knowledge({
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.userId,
    required this.knowledgeName,
    required this.description,
  });

  factory Knowledge.fromJson(Map<String, dynamic> json) {
    return Knowledge(
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      userId: json['userId'],
      knowledgeName: json['knowledgeName'],
      description: json['description'],
    );
  }
}