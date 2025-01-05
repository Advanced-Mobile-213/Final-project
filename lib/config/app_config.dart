import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get GoogleOauthClientId {
    final googleOauthClientId = dotenv.env['GOOGLE_OAUTH_CLIENT_ID'];
    if (googleOauthClientId == null) {
      throw Exception("Environment variable GOOGLE_OAUTH_CLIENT_ID is not defined in the .env file");
    }
    return googleOauthClientId;
  }
}
