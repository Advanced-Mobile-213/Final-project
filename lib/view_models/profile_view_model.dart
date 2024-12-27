import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/dto/token_usage/token_usage_response.dart';
import 'package:chatbot_agents/service/analytics_service.dart';
import 'package:chatbot_agents/service/token_service.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier{
  final TokenService _tokenService = GetItInstance.getIt<TokenService>();
  final AnalyticsService _analyticsService = GetItInstance.getIt<AnalyticsService>();
  TokenUsageResponse? tokenUsageResponse;
  bool isLoading = false;
  bool isPremiumUser = false;
  
  Future<void> checkIsPremiumUser() async {
    try {
      isLoading = true;
      tokenUsageResponse = await _tokenService.getTokenUsage();

      if (tokenUsageResponse != null) {
        isPremiumUser = tokenUsageResponse!.unlimited ?? false;
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> logEvent(
    {required String eventName, 
    Map<String, Object>? parameters
  }) async {
    await _analyticsService.logEvent(eventName, parameters);
  }
}