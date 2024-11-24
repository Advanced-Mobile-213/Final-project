import 'dart:developer';

import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/utils/local/shared_preferences_util.dart';
import 'package:chatbot_agents/utils/network/knowledge_base_api_client.dart';
import 'package:chatbot_agents/utils/network/knowledge_base_api_client.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/network/jarvis_api_client.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(

  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

class AuthService {
  late final JarvisApiClient jarvisApiClient = GetItInstance.getIt<JarvisApiClient>();
  late final KnowledgeBaseApiClient knowledgeBaseApiClient = GetItInstance.getIt<KnowledgeBaseApiClient>();
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
      log("--> Login Jarvis... ");
      final jarvisResponse = await jarvisApiClient.publicDio.post(
          "api/v1/auth/sign-in",
          data: {"email": email, "password": password});
      final String jarvisAccessToken =
      jarvisResponse.data["token"]["accessToken"]!.toString();
      final String jarvisRefreshToken =
      jarvisResponse.data["token"]["refreshToken"]!.toString();
      jarvisApiClient.setToken(jarvisAccessToken, jarvisRefreshToken);


      // TODO: DON'T ERASE THIS COMMENT, FIX THIS LATER
      // log("--> Login Knowledge... ");
      // final knowledgeResponse = await knowledgeBaseApiClient.publicDio.post(
      //     "kb-core/v1/auth/external-sign-in",
      //     data: {"token": jarvisAccessToken});
      // final String knowledgeAccessToken =
      // knowledgeResponse.data["token"]["accessToken"]!.toString();
      // final String knowledgeRefreshToken =
      // knowledgeResponse.data["token"]["refreshToken"]!.toString();
      // knowledgeBaseApiClient.setToken(knowledgeAccessToken, knowledgeRefreshToken);

      // Save tokens to shared preferences
      // await SharedPreferencesUtil.saveTokens(accessToken, refreshToken);

      return null;
    } on DioException catch (e) {
      log("--> Login error... ", error: e.message);

      if (e.response?.data["details"]?[0]["issue"] != null) {
        return e.response!.data["details"][0]["issue"].toString();
      }
      return "Internal server error, please try again";
    }
  }

  // Logout the user

  Future<String?> googleLogin() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      log("--> Login Google in Jarvis... ");
      if (account == null) {
        return "Internal server error, please try again";
      }
      GoogleSignInAuthentication authentication = await account.authentication;
      String? token = authentication.accessToken;
      if (token == null ) {
        return "Internal server error, please try again";
      }
      final jarvisResponse = await jarvisApiClient.publicDio.post(
          "api/v1/auth/google-sign-in",
          data: {"token": token});
      final String jarvisAccessToken =
      jarvisResponse.data["token"]["accessToken"]!.toString();
      final String jarvisRefreshToken =
      jarvisResponse.data["token"]["refreshToken"]!.toString();
      jarvisApiClient.setToken(jarvisAccessToken, jarvisRefreshToken);

      // TODO: DON'T ERASE THIS COMMENT, FIX THIS LATER
      // log("--> Login Knowledge... ");
      // final knowledgeResponse = await knowledgeBaseApiClient.publicDio.post(
      //     "kb-core/v1/auth/external-sign-in",
      //     data: {"token": jarvisAccessToken});
      // final String knowledgeAccessToken =
      // knowledgeResponse.data["token"]["accessToken"]!.toString();
      // final String knowledgeRefreshToken =
      // knowledgeResponse.data["token"]["refreshToken"]!.toString();
      // knowledgeBaseApiClient.setToken(knowledgeAccessToken, knowledgeRefreshToken);
      log("--> Login Knowledge... ");
      final knowledgeResponse = await knowledgeBaseApiClient.publicDio.post(
          "kb-core/v1/auth/external-sign-in",
          data: {"token": jarvisAccessToken});
      final String knowledgeAccessToken =
      knowledgeResponse.data["token"]["accessToken"]!.toString();
      final String knowledgeRefreshToken =
      knowledgeResponse.data["token"]["refreshToken"]!.toString();
      knowledgeBaseApiClient.setToken(knowledgeAccessToken, knowledgeRefreshToken);

      // Save tokens to shared preferences
      // await SharedPreferencesUtil.saveTokens(accessToken, refreshToken);

      return null;
    } on DioException catch (e) {
      log("--> Login error... ", error: e.message);

      if (e.response?.data["details"]?[0]["issue"] != null) {
        return e.response!.data["details"][0]["issue"].toString();
      }
      return "Internal server error, please try again";
    }
  }
  Future<void> logout() async {
    try {
      await jarvisApiClient.authenticatedDio.get(
        "/api/v1/auth/sign-out",
      );
    } on DioException {
      // Handle logout errors
    } finally {
      await SharedPreferencesUtil.clearTokens(); // Clear tokens
      jarvisApiClient.clearToken(); // Reset API client token
      knowledgeBaseApiClient.clearToken();
    }
  }
}
