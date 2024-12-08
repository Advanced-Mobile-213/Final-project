import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/utils/network/knowledge_base_api_client.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:chatbot_agents/models/ai_bot/bot_configuration.dart';
import 'package:chatbot_agents/models/ai_bot/bot_configure_verify_response.dart';

class BotIntegrationService {
  late final KnowledgeBaseApiClient knowledgeBaseApiClient =
      GetItInstance.getIt<KnowledgeBaseApiClient>();

  Future<List<BotConfiguration>?> getConfigurations({
    required String assistantId,
  }) async {
    try {
      final response = await knowledgeBaseApiClient.authenticatedDio.get(
        '/kb-core/v1/bot-integration/$assistantId/configurations',
      );

      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        if (response.data != null && response.data != null) {
          final List<dynamic> data = response.data;
          return data.map((e) => BotConfiguration.fromJson(e)).toList();
        }
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in getConfigurations of BotIntegration Service: $e");
    } catch (e) {
      log("--> An error occurs in getConfigurations of BotIntegration Service: $e");
    }
    return null;
  }

  Future<bool> disconnectBotIntegration({
    required String assistantId,
    required BotType botType,
  }) async {
    try {
      final response = await knowledgeBaseApiClient.authenticatedDio.delete(
        '/kb-core/v1/bot-integration/$assistantId/${botType.string}',
      );
      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        final result = response.data == 'true' ? true : false;
        return result;
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in disconnectBotIntegration of BotIntegration Service: $e");
    } catch (e) {
      log("--> An error occurs in disconnectBotIntegration of BotIntegration Service: $e");
    }
    return false;
  }

  Future<BotConfigureVerifyResponse?> verifyTelegramBotConfigure({
    required String botToken,
  }) async {
    try {
      final response = await knowledgeBaseApiClient.authenticatedDio.post(
        '/kb-core/v1/bot-integration/telegram/validation',
        data: {
          'botToken': botToken,
        },
      );

      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        final result = BotConfigureVerifyResponse.fromJson(response.data);
        return result;
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in verifyTelegramBotConfigure of BotIntegration Service: $e");
    } catch (e) {
      log("--> An error occurs in verifyTelegramBotConfigure of BotIntegration Service: $e");
    }
    return null;
  }

  Future<String?> publishTelegramBot({
    required String assistantId,
    required String botToken,
  }) async {
    try {
      final response = await knowledgeBaseApiClient.authenticatedDio.post(
        '/kb-core/v1/bot-integration/telegram/publish/$assistantId',
        data: {
          'botToken': botToken,
        },
      );
      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        final redirectLink = response.data['redirect'];
        return redirectLink;
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in publishTelegramBot of BotIntegration Service: $e");
    } catch (e) {
      log("--> An error occurs in publishTelegramBot of BotIntegration Service: $e");
    }
    return null;
  }
}
