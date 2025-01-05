class Knowledge {
  final String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? deletedAt;
  final String id;
  String knowledgeName;
  String description;
  final String? userId;
  int? numUnits;
  int? totalSize;

  Knowledge({
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedAt,
    required this.id,
    required this.knowledgeName,
    required this.description,
    this.userId,
    this.numUnits,
    this.totalSize
  });

  factory Knowledge.fromJson(Map<String, dynamic> json) {
    return Knowledge(
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']).toString() : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']).toString() : null,
      createdBy: json['createdBy'] ?? null,
      updatedBy: json['updatedBy'] ?? null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']).toString() : null,
      id: json['id'],
      knowledgeName: json['knowledgeName'] ?? "",
      description: json['description'] ?? "",
      userId: json['userId'] ?? null,
      numUnits: json['numUnits'] != null ? json['numUnits'] as int : null,
      totalSize: json['totalSize'] != null ? json['totalSize'] as int : null,
    );
  }

}