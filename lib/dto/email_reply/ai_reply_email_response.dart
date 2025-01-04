class AiReplyEmailResponse {
  final String email;
  final int remainingUsage;

  AiReplyEmailResponse({
    required this.email,
    required this.remainingUsage,
  });

  factory AiReplyEmailResponse.fromJson(Map<String, dynamic> json) {
    return AiReplyEmailResponse(
      email: json['email'],
      remainingUsage: json['remainingUsage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'remainingUsage': remainingUsage,
    };
  }

  @override
  String toString() {
    return 'AiReplyEmailResponse{email: $email, remainingUsage: $remainingUsage}';
  }
}