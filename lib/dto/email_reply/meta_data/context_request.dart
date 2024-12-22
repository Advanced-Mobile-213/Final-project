class ContextRequest {
  final String subject;
  final String sender;
  final String receiver;
  final String content;

  ContextRequest({
    required this.subject,
    required this.sender,
    required this.receiver,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'sender': sender,
      'receiver': receiver,
      'content': content,
    };
  }

  factory ContextRequest.fromJson(Map<String, dynamic> json) {
    return ContextRequest(
      subject: json['subject'],
      sender: json['sender'],
      receiver: json['receiver'],
      content: json['content'],
    );
  }

  @override
  String toString() {
    return 'ContextRequest{subject: $subject, sender: $sender, receiver: $receiver, content: $content}';
  }

}