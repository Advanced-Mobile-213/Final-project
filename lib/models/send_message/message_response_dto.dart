class MessageResponseDto {
  final String conversationId;
  final String message;
  final int remainingUsage;

  MessageResponseDto({
    required this.conversationId, 
    required this.message,
    required this.remainingUsage,
  });

  factory MessageResponseDto.fromJson(Map<String, dynamic> json) {
    return MessageResponseDto(
      conversationId: json['conversationId'],
      message: json['message'],
      remainingUsage: json['remainingUsage'],
    );
  }

  @override
  String toString() {
    return 'MessageResponseDto{conversationId: $conversationId, message: $message, remainingUsage: $remainingUsage}';
  }
}