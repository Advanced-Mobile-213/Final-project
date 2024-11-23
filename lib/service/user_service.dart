import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/models/user.dart';
import 'package:chatbot_agents/utils/network/jarvis_api_client.dart';

class UserService {
  final jarvisApiClient = GetItInstance.getIt<JarvisApiClient>();
  // Fetch the current user's data
  Future<User?> fetchCurrentUser() async {
    try {
      final response = await jarvisApiClient
          .authenticatedDio
          .get("api/v1/auth/me");
      return User.fromJson(response.data);
    } catch (e) {
      print("Error when fetch current user " + e.toString());
      // Handle error fetching user data if needed
      return null;
    }
  }
}
