import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/dto/token_usage/token_usage_response.dart';
import 'package:chatbot_agents/service/token_service.dart';
import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier{
  final TokenService _tokenService = GetItInstance.getIt<TokenService>();

  TokenUsageResponse? tokenUsageResponse;
  bool isLoading = false;

  Future<void> getTokenUsage() async {
    try {
      isLoading = true;
      tokenUsageResponse = await _tokenService.getTokenUsage();
      isLoading = false;
    } catch (e) {
      print('--> Error fetching token usage: $e');
      isLoading = false;
    }
    notifyListeners();
  }
}