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
      final result = GetPromptsResponse.fromJson(response.data);
      return result;
    } on DioException catch (e) {
      print("--> An DioException occurs: ${e}");
    } catch (e) {
      print("--> An error occurs: ${e}");
    }
    return null;
  }

  Future<void> createPrompt({
    required PromptCategory category,
    required String content,
    required String description,
    required bool isPublic,
    required String language,
    required String title,
  }) async {}

  Future<void> updatePrompt({
    required String id,
    required PromptCategory category,
    required String content,
    required String description,
    required bool isPublic,
    required String language,
    required String title,
  }) async {}

  Future<void> deletePrompt(String id) async {}

  Future<void> addPromptToFavorite(String id) async {}

  Future<void> removePromptFromFavorite(String id) async {}
}
