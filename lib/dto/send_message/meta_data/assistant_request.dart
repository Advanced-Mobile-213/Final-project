class AssistantRequest {
  final String id;
  final String model;
  final String name;
  AssistantRequest({
    required this.id,
    required this.model,
    required this.name,
  });

  factory AssistantRequest.fromJson(Map<String, dynamic> json) {
    return AssistantRequest(
      id: json['id'],
      model: json['model'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model': model,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'AssistantDto{id: $id, model: $model, name: $name}';
  }
}