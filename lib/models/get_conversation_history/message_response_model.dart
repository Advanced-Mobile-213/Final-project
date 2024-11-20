class MessageResponseModel {
  final String? answer;
  final int? createdAt;
  final List<String>? files;
  final String? query;

  MessageResponseModel({
    required this.answer,
    required this.createdAt,
    required this.files,
    required this.query,
  });

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(
      answer: json['answer'],
      createdAt: json['createdAt'],
      files: json['files'] != null 
          ? List<String>.from(json['files'] as List)
          : null,
      query: json['query'],
    );
  }

  @override
  String toString() {
    return 'MessageResponseModel{answer: answer, createdAt: $createdAt, files: $files, query: $query}'; //$answer
  }
}