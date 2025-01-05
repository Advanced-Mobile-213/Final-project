class ThreadChatModel {
  final String? id;
  final String? title;
  final int? createdAt;

  ThreadChatModel({
     this.id,
     this.title,
     this.createdAt,
  });

  factory ThreadChatModel.fromJson(Map<String, dynamic> json) {
    return ThreadChatModel(
      id: json['id'],
      title: json['title'] ,
      createdAt: json['createdAt'],
    );
  }

  @override
  String toString() {
    return 'ThreadChatModel{id: $id, title: $title, createdAt: $createdAt}';
  }
}