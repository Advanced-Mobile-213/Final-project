import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:chatbot_agents/models/ai_bot/bot_configuration.dart';
import 'package:chatbot_agents/service/bot_integration_service.dart';

class BotConfigurationViewModel extends ChangeNotifier {
  final _botIntegrationService = GetItInstance.getIt<BotIntegrationService>();

  bool isLoading = false;

  Future<List<BotConfiguration>?> getConfigurations({
    required String assistantId,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _botIntegrationService.getConfigurations(
        assistantId: assistantId,
      );

      isLoading = false;
      notifyListeners();
      if (response != null) {
        return response;
      } else {
        return [];
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('--> Error in getConfigurations of BotConfigurationViewModel: $e');
    }
    return null;
  }

  Future<bool> disconnectBotIntegration({
    required String assistantId,
    required BotType botType,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _botIntegrationService.disconnectBotIntegration(
        assistantId: assistantId,
        botType: botType,
      );

      isLoading = false;
      notifyListeners();
      if (response) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('--> Error in disconnectBotIntegration of BotConfigurationViewModel: $e');
    }
    return false;
  }

  Future<bool?> verifyTelegramBotConfigure({
    required String botToken,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _botIntegrationService.verifyTelegramBotConfigure(
        botToken: botToken,
      );

      isLoading = false;
      notifyListeners();
      if (response != null) {
        return response.ok;
      } else {
        return null;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('--> Error in verifyTelegramBotConfigure of BotConfigurationViewModel: $e');
    }
    return null;
  }

  Future<String?> publishTelegramBot({
    required String assistantId,
    required String botToken,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _botIntegrationService.publishTelegramBot(
        assistantId: assistantId,
        botToken: botToken,
      );

      isLoading = false;
      notifyListeners();
      if (response != null) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('--> Error in publishTelegramBot of BotConfigurationViewModel: $e');
    }
    return null;
  }
}
