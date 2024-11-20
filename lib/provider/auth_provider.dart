import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/utils/local/shared_preferences_util.dart';
import 'package:chatbot_agents/utils/network/jarvis_api_client.dart';
import 'package:chatbot_agents/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  User? _user;

  bool get isAuthenticated => _isAuthenticated;
  User? get user => _user;

  // Function for registering
  Future<String?> register(
      String email, String password, String username) async {
    try {
      await GetItInstance.getIt<JarvisApiClient>().publicDio.post(
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

  // Function for logging in and fetching user data
  Future<String?> login(String email, String password) async {
    try {
      final response = await GetItInstance.getIt<JarvisApiClient>().publicDio.post(
          "api/v1/auth/sign-in",
          data: {"email": email, "password": password});

      _isAuthenticated = true;
      final String accessToken =
          response.data["token"]["accessToken"]!.toString();
      final String refreshToken =
          response.data["token"]["refreshToken"]!.toString();
      GetItInstance.getIt<JarvisApiClient>().setToken(accessToken, refreshToken);

      // Save tokens to shared preferences
      await SharedPreferencesUtil.saveTokens(accessToken, refreshToken);

      await _fetchUser();
      notifyListeners();

      return null;
    } on DioException catch (e) {
      if (e.response?.data["details"]?[0]["issue"] != null) {
        return e.response!.data["details"][0]["issue"].toString();
      }
      return "Internal server error, please try again";
    }
  }

  // Function to fetch the current user
  Future<void> _fetchUser() async {
    try {
      final response = await GetItInstance.getIt<JarvisApiClient>()
          .authenticatedDio
          .get("api/v1/auth/me");
      _user = User.fromJson(response.data);
    } catch (e) {
      // Handle error fetching user data if needed
    }
  }

  // Function to log out
  Future<void> logout() async {
    try {
      final response = await GetItInstance.getIt<JarvisApiClient>().authenticatedDio.get("/api/v1/auth/sign-out",);
      return;
    } on DioException catch (e) {
      rethrow;
    } finally {
      _isAuthenticated = false;
      _user = null; // Clear user data
      notifyListeners();
    }

  }
}
