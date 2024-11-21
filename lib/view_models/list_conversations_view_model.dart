import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/models/get_conversations/list_thread_chat_model.dart';
import 'package:chatbot_agents/dto/send_message/message_response.dart';
import 'package:chatbot_agents/service/conversation_service.dart';
import 'package:flutter/material.dart';

class ListConversationsViewModel extends ChangeNotifier {
  ListThreadChatModel? conversations;
  MessageResponse? messageResponseDto;
  bool isLoading = false;
  final ConversationService _conversationService = GetItInstance.getIt<ConversationService>();

  Future<void> getConversations({
    required String assistantModel, 
    required String assistantId,
    String? cursor, 
    int? limit 
  }) async {
    // Fetch conversation from the server
    try {
      isLoading = true;
      conversations = await _conversationService.getConversations(
        assistantModel: assistantModel,
        assistantId: assistantId,
        cursor: cursor,
        limit: limit,
      );
      isLoading = false;
      print('conversations: $conversations');
      //conversations = ListThreadChatModel.fromJson(response.data);
      notifyListeners();
    } catch (e) {
      print("An error occurs: ${e}");
      // Handle error
    }
  }

  Future<void> createConversation({
    required String assistantModel, 
    required String assistantId,
    String? assistantName,
    required String content,
    List<String>? files,
  }) async {
    try {
      messageResponseDto = null; 
      messageResponseDto = await _conversationService.createConversation(
        assistantModel: assistantModel,
        assistantId: assistantId,
        assistantName: assistantName,
        content: content,
        files: files,
      );

      print('messageResponseDto: $messageResponseDto');
      notifyListeners();
    } catch (e) {
      print("An error occurs: ${e}");
      // Handle error
    }
  }

}