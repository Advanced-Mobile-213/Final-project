import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/dto/email_reply/ai_reply_email_request.dart';
import 'package:chatbot_agents/dto/email_reply/ai_reply_email_response.dart';
import 'package:chatbot_agents/dto/email_reply/ideas_response.dart';
import 'package:chatbot_agents/dto/email_reply/suggest_reply_idea_request.dart';
import 'package:chatbot_agents/utils/network/jarvis_api_client.dart';
import 'package:dio/dio.dart';

class EmailService {
  late final JarvisApiClient _jarvisApiClient =  GetItInstance.getIt<JarvisApiClient>();

  Future<IdeasResponse?> suggestEmailReplyIdeas(SuggestReplyIdeaRequest request) async {
    try {
      print('request: ${request.toJson()}');
      final response = await _jarvisApiClient
        .authenticatedDio
        .post(
          'api/v1/ai-email/reply-ideas',
          data: request.toJson()
        );

      print('response: ${response}');

      if (response.statusCode! >= 200 && response.statusCode! <300) {
        return IdeasResponse.fromJson(response.data);
      }

    } on DioException catch (e) {
      print("-->An DioException occurs: ${e}");
    }
    catch (e) {
      print("-->An error occurs: ${e}");
    } 

    return null;
  }

  Future<AiReplyEmailResponse?> replyEmail(AiReplyEmailRequest request) async {
    try {
      final response = await _jarvisApiClient
        .authenticatedDio
        .post(
          'api/v1/ai-email',
          data: request.toJson()
          
        );

      print('response: ${response}');
      if (response.statusCode! >= 200 && response.statusCode! <300) {
        return AiReplyEmailResponse.fromJson(response.data);
      }
    } on DioException catch (e) {
      print("-->An DioException occurs: ${e}");
    } catch (e) {
      print("-->An error occurs: ${e}");
    } 

    return null;
  }
}