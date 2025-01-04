
class AiEmailStyleRequest {
  final String length;
  final String formality;
  final String tone;

  AiEmailStyleRequest({
    required this.length,
    required this.formality,
    required this.tone,
  });

  factory AiEmailStyleRequest.fromJson(Map<String, dynamic> json) {
    return AiEmailStyleRequest(
      length: json['length'],
      formality: json['formality'],
      tone: json['tone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'length': length,
      'formality': formality,
      'tone': tone,
    };
  }

  @override
  String toString() {
    return 'AiEmailStyleRequest{length: $length, formality: $formality, tone: $tone}';
  }

}