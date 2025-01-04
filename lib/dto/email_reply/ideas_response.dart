class IdeasResponse {
  final List<String> ideas;

  IdeasResponse({
    required this.ideas,
  });

  factory IdeasResponse.fromJson(Map<String, dynamic> json) {
    return IdeasResponse(
      ideas: List<String>.from(json['ideas']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ideas': ideas,
    };
  }
}