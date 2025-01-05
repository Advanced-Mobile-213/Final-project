import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get jarvisUrl {
    final url = dotenv.env['JARVIS_URL'];
    if (url == null) {
      throw Exception("Environment variable JARVIS_URL is not defined in the .env file");
    }
    return url;
  }
  static String get knowledgeUrl {
    final url = dotenv.env['KNOWLEDGE_URL'];
    if (url == null) {
      throw Exception("Environment variable JARVIS_URL is not defined in the .env file");
    }
    return url;
  }
}
