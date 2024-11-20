import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/utils/local/shared_preferences_util.dart';
import 'package:dio/dio.dart';

import '../utils/network/jarvis_api_client.dart';

class AuthService {
  late final JarvisApiClient jarvisApiClient = GetItInstance.getIt<JarvisApiClient>();
  // Register a new user
  Future<String?> register(String email, String password, String username) async {
    try {
      await jarvisApiClient.publicDio.post(
        "api/v1/auth/sign-up",
        data: {"email": email, "password": password, "username": username},
      );
      return null;
    } on DioException catch (e) {
      if (e.response?.data["details"]?[0]["issue"] != null) {
        return e.response!.data["details"][0]["issue"].toString();
      }
      return "Internal server error, please try again";
    }
  }

  // Login and set tokens
  Future<String?> login(String email, String password) async {
    try {
      final response = await jarvisApiClient.publicDio.post(
          "api/v1/auth/sign-in",
          data: {"email": email, "password": password});

      final String accessToken =
      response.data["token"]["accessToken"]!.toString();
      final String refreshToken =
      response.data["token"]["refreshToken"]!.toString();
      jarvisApiClient.setToken(accessToken, refreshToken);

      // Save tokens to shared preferences
      await SharedPreferencesUtil.saveTokens(accessToken, refreshToken);

      return null;
    } on DioException catch (e) {
      if (e.response?.data["details"]?[0]["issue"] != null) {
        return e.response!.data["details"][0]["issue"].toString();
      }
      return "Internal server error, please try again";
    }
  }

  // Logout the user
  Future<void> logout() async {
    try {
      await jarvisApiClient.authenticatedDio.get(
        "/api/v1/auth/sign-out",
      );
    } catch (DioException) {
      // Handle logout errors
    } finally {
      await SharedPreferencesUtil.clearTokens(); // Clear tokens
      jarvisApiClient.clearToken(); // Reset API client token
    }
  }
}
