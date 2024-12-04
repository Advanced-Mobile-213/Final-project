import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/utils/network/knowledge_base_api_client.dart';
import 'package:dio/dio.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'dart:developer';
import 'package:chatbot_agents/models/knowledge/knowledge.dart';

class AiBotService {
  late final KnowledgeBaseApiClient knowledgeBaseApiClient =
      GetItInstance.getIt<KnowledgeBaseApiClient>();

  Future<AiBot?> createAssistant({
    required assistantName,
    String? instructions,
    String? description,
  }) async {
    try {
      final postData = <String, dynamic>{
        'assistantName': assistantName,
        if (instructions != null) 'instructions': instructions,
        if (description != null) 'description': description,
      };

      final response = await knowledgeBaseApiClient.authenticatedDio.post(
        '/kb-core/v1/ai-assistant',
        data: postData,
      );

      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        return AiBot.fromJson(response.data);
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in createAssistant of AiBot Service: $e");
    } catch (e) {
      log("--> An error occurs in createAssistant of AiBot Service: $e");
    }
    return null;
  }

  Future<List<AiBot>?> getAssistants({
    String? q,
    String? order,
    String? orderField,
    int? offset,
    int? limit,
    bool? isFavorite,
    bool? isPublic,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        if (q != null) 'q': q,
        if (order != null) 'order': order,
        if (orderField != null) 'order_field': orderField,
        if (offset != null) 'offset': offset,
        if (limit != null) 'limit': limit,
        if (isFavorite != null) 'isFavorite': isFavorite,
        if (isPublic != null) 'isPublic': isPublic,
      };

      final response = await knowledgeBaseApiClient.authenticatedDio.get(
        '/kb-core/v1/ai-assistant',
        queryParameters: queryParams,
      );

      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        if (response.data != null && response.data['data'] != null) {
          final List<dynamic> data = response.data['data'];
          return data.map((e) => AiBot.fromJson(e)).toList();
        }
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in getAssistant of AiBot Service: $e");
    } catch (e) {
      log("--> An error occurs in getAssistant of AiBot Service: $e");
    }
    return null;
  }

  Future<AiBot?> updateAssistant({
    required String assistantId,
    required String assistantName,
    String? instructions,
    String? description,
  }) async {
    try {
      final postData = <String, dynamic>{
        'assistantName': assistantName,
        if (instructions != null) 'instructions': instructions,
        if (description != null) 'description': description,
      };

      final response = await knowledgeBaseApiClient.authenticatedDio.patch(
        '/kb-core/v1/ai-assistant/$assistantId',
        data: postData,
      );

      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        return AiBot.fromJson(response.data);
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in updateAssistant of AiBot Service: $e");
    } catch (e) {
      log("--> An error occurs in updateAssistant of AiBot Service: $e");
    }
    return null;
  }

  Future<bool> deleteAssistant({required String assistantId}) async {
    try {
      final response = await knowledgeBaseApiClient.authenticatedDio.delete(
        '/kb-core/v1/ai-assistant/$assistantId',
      );

      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        final result = response.data == 'true' ? true : false;
        return result;
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in deleteAssistant of AiBot Service: $e");
    } catch (e) {
      log("--> An error occurs in deleteAssistant of AiBot Service: $e");
    }
    return false;
  }

  Future<bool> importKnowledgeToAssistant(
      {required String assistantId, required String knowledgeId}) async {
    try {
      final response = await knowledgeBaseApiClient.authenticatedDio.post(
        '/kb-core/v1/ai-assistant/$assistantId/knowledges/$knowledgeId',
      );

      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        final result = response.data == 'true' ? true : false;
        return result;
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in importKnowledgeToAssistant of AiBot Service: $e");
    } catch (e) {
      log("--> An error occurs in importKnowledgeToAssistant of AiBot Service: $e");
    }
    return false;
  }

  Future<bool> removeKnowledgeFromAssistant(
      {required String assistantId, required String knowledgeId}) async {
    try {
      final response = await knowledgeBaseApiClient.authenticatedDio.delete(
        '/kb-core/v1/ai-assistant/$assistantId/knowledges/$knowledgeId',
      );

      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        final result = response.data == 'true' ? true : false;
        return result;
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in removeKnowledgeFromAssistant of AiBot Service: $e");
    } catch (e) {
      log("--> An error occurs in removeKnowledgeFromAssistant of AiBot Service: $e");
    }
    return false;
  }

  Future<List<Knowledge>?> getImportedKnowledgeInAssistant(
      {required String assistantId}) async {
    try {
      final response = await knowledgeBaseApiClient.authenticatedDio.get(
        '/kb-core/v1/ai-assistant/$assistantId/knowledges',
      );

      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        if (response.data != null && response.data['data'] != null) {
          final List<dynamic> data = response.data['data'];
          return data.map((e) => Knowledge.fromJson(e)).toList();
        }
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in getImportedKnowledgeInAssistant of AiBot Service: $e");
    } catch (e) {
      log("--> An error occurs in getImportedKnowledgeInAssistant of AiBot Service: $e");
    }
    return null;
  }
}
