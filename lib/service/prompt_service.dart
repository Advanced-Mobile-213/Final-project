import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:dio/dio.dart';
import '../utils/network/jarvis_api_client.dart';
import 'package:chatbot_agents/constants/constants.dart';
import 'package:chatbot_agents/models/models.dart';

class PromptService {
  late final JarvisApiClient jarvisApiClient =
      GetItInstance.getIt<JarvisApiClient>();

  Future<GetPromptsResponse?> getPrompts({
    String? query,
    int? offset,
    int? limit,
    PromptCategory? category,
    bool? isFavorite,
    bool? isPublic,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        if (query != null) 'query': query,
        if (offset != null) 'offset': offset,
        if (limit != null) 'limit': limit,
        if (category != null) 'category': category.id,
        if (isFavorite != null) 'isFavorite': isFavorite,
        if (isPublic != null) 'isPublic': isPublic,
      };


      final response = await jarvisApiClient.authenticatedDio
          .get("/api/v1/prompts", queryParameters: queryParams);

      if (response.statusCode! <300 && response.statusCode! >= 200) {
        return GetPromptsResponse.fromJson(response.data);
      }
   
    } on DioException catch (e) {
      print("--> An DioException occurs: ${e}");
    } catch (e) {
      print("--> An error occurs: ${e}");
    }
    return null;
  }

  Future<Prompt?> createPrompt({
    required PromptCategory category,
    required String content,
    required String description,
    required bool isPublic,
    required String language,
    required String title,
  }) async {
    try {
      final response = await jarvisApiClient.authenticatedDio.post(
        "/api/v1/prompts",
        data: {
          'category': category.id,
          'content': content,
          'description': description,
          'isPublic': isPublic,
          'language': language,
          'title': title,
        },
      );

      if (response.statusCode! <300 && response.statusCode! >= 200) {
        return Prompt.fromJson(response.data);
      }
      
    } on DioException catch (e) {
      print("--> An DioException occurs: ${e}");
    } catch (e) {
      print("--> An error occurs: ${e}");
    }
    return null;
  }

  Future<bool> updatePrompt({
    required String id,
    required PromptCategory category,
    required String content,
    required String description,
    required bool isPublic,
    required String language,
    required String title,
  }) async {
    try {
      final response = await jarvisApiClient.authenticatedDio.patch(
        "/api/v1/prompts/$id",
        data: {
          'category': category.id,
          'content': content,
          'description': description,
          'isPublic': isPublic,
          'language': language,
          'title': title,
        },
      );

      if (response.statusCode! <300 && response.statusCode! >= 200) {
        return true;
      }
      
    } on DioException catch (e) {
      print("--> An DioException occurs: ${e}");
    } catch (e) {
      print("--> An error occurs: ${e}");
    }

    return false;
  }

  Future<bool> deletePrompt(String id) async {
    try {
      final response = await jarvisApiClient.authenticatedDio.delete(
        "/api/v1/prompts/$id",
      );

      if (response.statusCode! <300 && response.statusCode! >= 200) {
        return true;
      }
      
    } on DioException catch (e) {
      print("--> An DioException occurs: ${e}");
    } catch (e) {
      print("--> An error occurs: ${e}");
    }

    return false;
  }

  Future<void> addPromptToFavorite(String id) async {
    try {
      await jarvisApiClient.authenticatedDio.post("/api/v1/prompts/$id/favorite");
    } on DioException catch (e) {
      print("--> An DioException occurs: ${e}");
    } catch (e) {
      print("--> An error occurs: ${e}");
    }
  }

  Future<void> removePromptFromFavorite(String id) async {
    try {
      await jarvisApiClient.authenticatedDio.delete("/api/v1/prompts/$id/favorite");
    } on DioException catch (e) {
      print("--> An DioException occurs: ${e}");
    } catch (e) {
      print("--> An error occurs: ${e}");
    }
  }
}
