import 'package:chatbot_agents/main.dart';
import 'package:chatbot_agents/service/api/JarvisApiService.dart';
import 'package:chatbot_agents/view_models/UserViewModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  UserViewModel? _user;

  bool get isAuthenticated => _isAuthenticated;
  UserViewModel? get user => _user;

  // Function for registering
  Future<String?> register(
      String email, String password, String username) async {
    try {
      await getIt<JarvisApiService>().publicDio.post(
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
      final response = await getIt<JarvisApiService>().publicDio.post(
          "api/v1/auth/sign-in",
          data: {"email": email, "password": password});

      _isAuthenticated = true;
      final String accessToken =
          response.data["token"]["accessToken"]!.toString();
      final String refreshToken =
          response.data["token"]["refreshToken"]!.toString();
      getIt<JarvisApiService>().setToken(accessToken, refreshToken);
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
      final response = await getIt<JarvisApiService>()
          .authenticatedDio
          .get("api/v1/auth/me");
      _user = UserViewModel.fromJson(response.data);
    } catch (e) {
      // Handle error fetching user data if needed
    }
  }

  // Function to log out
  Future<void> logout() async {
    try {
      final response = await getIt<JarvisApiService>().authenticatedDio.get("/api/v1/auth/sign-out",);
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
