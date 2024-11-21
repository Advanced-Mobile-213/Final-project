import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/models/get_conversation_history/list_couple_message_model.dart';
import 'package:chatbot_agents/models/get_conversations/list_thread_chat_model.dart';
import 'package:chatbot_agents/models/send_message/list_message_model.dart';
import 'package:chatbot_agents/dto/send_message/message_response.dart';
import 'package:chatbot_agents/dto/send_message/meta_data/assistant_request.dart';
import 'package:chatbot_agents/utils/local/shared_preferences_util.dart';
import 'package:chatbot_agents/utils/network/jarvis_api_client.dart';
import 'package:dio/dio.dart';

class ConversationService {
  
  late final JarvisApiClient _apiService =  GetItInstance.getIt<JarvisApiClient>();
 //final JarvisApiService _apiService = JarvisApiService();
 Future<ListThreadChatModel?> getConversations(
    {required String assistantModel, 
    required String assistantId,
    String? cursor, 
    int? limit 
    }
  ) async {
   // Fetch conversation from the server
   try {
    
      final queryParams = <String, dynamic>{
        'assistantModel': assistantModel,
        'assistantId': assistantId,
        if (cursor != null) 'cursor': cursor,
        if (limit != null) 'limit': limit,
      };

      //print(queryParams);

      final accessToken = await SharedPreferencesUtil.getAccessToken();
      final refreshToken = await SharedPreferencesUtil.getRefreshToken();

      //print('accessToken: $accessToken');
      //print('refreshToken: $refreshToken');

      if (accessToken != null && refreshToken != null) {
        _apiService.setToken(accessToken, refreshToken);
      }

      //print('_apiService.accessToken: ${_apiService.accessToken}');
      //print('_apiService.refreshToken: ${_apiService.refreshToken}');

      final response = await _apiService
        .authenticatedDio
        .get(
          'api/v1/ai-chat/conversations',
          queryParameters: queryParams
        );

      //print(response);

      if (response.statusCode! <300 && response.statusCode! >= 200) {
        return ListThreadChatModel.fromJson(response.data);
      }
    } on  DioException catch (e) {
      print("An DioException occurs: ${e}");
    }
    catch (e) {
      print("An error occurs: ${e}");
      
   }
   return null;
  
 }

 Future<ListCoupleMessageModel?> getConversationHistory({
    required String conversationId,
    required String assistantModel, 
    required String assistantId,
    String? cursor, 
    int? limit,
 }) async {
    // Fetch conversation from the server
    try {

        final queryParams = <String, dynamic>{
          'assistantModel': assistantModel,
          'assistantId': assistantId,
          if (cursor != null) 'cursor': cursor,
          if (limit != null) 'limit': limit,
        };

        final accessToken = await SharedPreferencesUtil.getAccessToken();
        final refreshToken = await SharedPreferencesUtil.getRefreshToken();

        if (accessToken != null && refreshToken != null) {
          _apiService.setToken(accessToken, refreshToken);
        }

        final response = await _apiService
          .authenticatedDio
          .get(
            'api/v1/ai-chat/conversations/$conversationId/messages',
            queryParameters: queryParams
          );
  
        if (response.statusCode! <300 && response.statusCode! >= 200) {
          return ListCoupleMessageModel.fromJson(response.data);
        }
      } on  DioException catch (e) {
        print("An DioException occurs: ${e}");
      }
      catch (e) {
        print("An error occurs: ${e}");
        
    }
    return null;
 }
 
 Future<MessageResponse?> createConversation({
    required String assistantModel, 
    required String assistantId,
    String? assistantName,
    required String content,
    List<String>? files,
 }) async {
    // Fetch conversation from the server
    try {

        final accessToken = await SharedPreferencesUtil.getAccessToken();
        final refreshToken = await SharedPreferencesUtil.getRefreshToken();

        if (accessToken != null && refreshToken != null) {
          _apiService.setToken(accessToken, refreshToken);
        }

        final AssistantRequest assistantDto = AssistantRequest(
          model: assistantModel,
          id: assistantId, 
          name: assistantName ?? ''
        );
        
        final response = await _apiService
          .authenticatedDio
          .post(
            'api/v1/ai-chat/messages',
            data: {
              'assistant': assistantDto.toJson(),
              'content': content,
              if (files != null) 'files': files,
            }
          );
  
        if (response.statusCode! <300 && response.statusCode! >= 200) {
          return MessageResponse.fromJson(response.data);
        }
      } on  DioException catch (e) {
        print("An DioException occurs: ${e}");
      }
      catch (e) {
        print("An error occurs: ${e}");
        
    }
    return null;
 }
 
 Future<MessageResponse?> sendMessage({
    required String assistantModel,
    required String assistantId,
    required String content,
    List<String>? files,
    required ListMessageModel listMessageModel,
 }) async {
    // Send message to the server
    try {

        final accessToken = await SharedPreferencesUtil.getAccessToken();
        final refreshToken = await SharedPreferencesUtil.getRefreshToken();

        if (accessToken != null && refreshToken != null) {
          _apiService.setToken(accessToken, refreshToken);
        }

        Map<String, dynamic> temp = {
              'assistant': {
                'model': assistantModel,
                'id': assistantId,
              },
              'content': content,
              if (files != null) 'files': files,
              'metadata': {
                'conversation': listMessageModel.toJson(),
              },
            };
        
        print('send data: $temp');

        final response = await _apiService
          .authenticatedDio
          .post(
            'api/v1/ai-chat/messages',
            data: {
              'assistant': {
                'model': assistantModel,
                'id': assistantId,
              },
              'content': content,
              if (files != null) 'files': files,
              'metadata': {
                'conversation': listMessageModel.toJson(),
              },
            }
          );
  
        if (response.statusCode! <300 && response.statusCode! >= 200) {
          return MessageResponse.fromJson(response.data);
        }
      } on  DioException catch (e) {
        print("An DioException occurs: ${e}");
      }
      catch (e) {
        print("An error occurs: ${e}");
        
    }
    return null;
 }
}

// _apiService.setToken(
    //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRlMmM2MGE3LWJmZDgtNDY4NC1hYmQxLTQ4NjZiOGQ1NGMwYiIsImVtYWlsIjoiaG9hbmdxdW9jMjEwNkBnbWFpbC5jb20iLCJpYXQiOjE3MzE3NTc1ODQsImV4cCI6MTczMTc1NzY0NH0.h1t69wIbQgGf3KqNxTd-tMQ4EaRcR1Rn9emf9T96Zz0',
    //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjRlMmM2MGE3LWJmZDgtNDY4NC1hYmQxLTQ4NjZiOGQ1NGMwYiIsImVtYWlsIjoiaG9hbmdxdW9jMjEwNkBnbWFpbC5jb20iLCJpYXQiOjE3MzE3NTc1ODQsImV4cCI6MTc2MzI5MzU4NH0.8ApmOFprWX290DmZKpuk8xExLGvgh318skwLtajiNkA'
    //   );

// final getIt = GetIt.asNewInstance();
// void setup() {
//   getIt.registerSingleton<JarvisApiService>(JarvisApiService.init('https://api.dev.jarvis.cx/'));
// }

// void main() async {
//   setup();
//   await ConversationService().getConversations(assistantModel: 'dify', assistantId: 'gpt-4o-mini');
// }