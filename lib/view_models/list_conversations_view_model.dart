import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/models/get_conversations/list_thread_chat_model.dart';
import 'package:chatbot_agents/dto/send_message/message_response.dart';
import 'package:chatbot_agents/service/conversation_service.dart';
import 'package:flutter/material.dart';

class ListConversationsViewModel extends ChangeNotifier {
  final ConversationService _conversationService = GetItInstance.getIt<ConversationService>();
  
  ListThreadChatModel? conversations;
  ListThreadChatModel? moreConversations;
  MessageResponse? messageResponseDto;
  bool isLoading = false;
  String? listConversationCursor;
  bool isLoadingMore = false;
  bool isInNewConversation = false;

  Future<void> getConversations({
    required String assistantModel, 
    required String assistantId,
    String? cursor, 
    int? limit 
  }) async {
    // Fetch conversation from the server
    try {
      isLoading = true;
      if (isInNewConversation) {
        isInNewConversation = false;
      } else {
        listConversationCursor = null;
      }

      conversations = null;
      conversations = await _conversationService.getConversations(
        assistantModel: assistantModel,
        assistantId: assistantId,
        cursor: cursor,
        limit: limit,
      );
      
      if (conversations != null) {
        listConversationCursor = conversations!.cursor;
      }
      
      isLoading = false;
      print('conversations: $conversations');
      //conversations = ListThreadChatModel.fromJson(response.data);
      notifyListeners();
    } catch (e) {
      print("An error occurs: ${e}");
      // Handle error
    }
  }

  Future<void> getMoreConversations({
    required String assistantModel, 
    required String assistantId,
    required String cursor, 
    int? limit 
  }) async {
    // Fetch conversation from the server
    try {
      isLoadingMore = true;
      moreConversations = null;

      moreConversations = await _conversationService.getConversations(
        assistantModel: assistantModel,
        assistantId: assistantId,
        cursor: cursor,
        limit: limit,
      );

      
      print('moreConversations: $moreConversations');
      if (moreConversations != null && moreConversations!.items.isNotEmpty) {
        if (conversations == null) {
          conversations = moreConversations;
        } else {
          conversations!.items.addAll(moreConversations!.items);
        }

        
          listConversationCursor = moreConversations!.cursor;

          conversations!.cursor = moreConversations!.cursor;
          conversations!.hasMore = moreConversations!.hasMore;
          conversations!.limit = moreConversations!.limit;

      }
      isLoadingMore = false;
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