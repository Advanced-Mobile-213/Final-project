import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/models/get_conversation_history/list_message_response_model.dart';
import 'package:chatbot_agents/models/send_message/list_message_model.dart';
import 'package:chatbot_agents/models/send_message/message_model.dart';
import 'package:chatbot_agents/models/send_message/message_response_dto.dart';
import 'package:chatbot_agents/models/send_message/meta_data_dto/assistant_dto.dart';
import 'package:chatbot_agents/service/conversation_service/conversation_service.dart';
import 'package:flutter/material.dart';

class ConversationViewModel extends ChangeNotifier {
  ListMessageResponseModel? listHistoryMessages;
  ListMessageModel? messages = ListMessageModel(messages: [], id: '');
  MessageResponseDto? messageResponseDto;
  final ConversationService _conversationService = GetItInstance.getIt<ConversationService>();

  bool isLoadingConversationHistory = false;

  Future<void> getConversationHistory({
    required String conversationId,
    required String assistantModel, 
    required String assistantId,
    String? cursor, 
    int? limit 
  }) async {
    // Fetch conversation from the server
    try {
      isLoadingConversationHistory = true;
      notifyListeners();

      listHistoryMessages = await _conversationService.getConversationHistory(
        conversationId: conversationId,
        assistantModel: assistantModel,
        assistantId: assistantId,
        cursor: cursor,
        limit: limit,
      );

      print('list history Messages: $listHistoryMessages');
      isLoadingConversationHistory = false;
      //conversations = ListThreadChatModel.fromJson(response.data);
      notifyListeners();
    } catch (e) {
      print("An error occurs: ${e}");
      // Handle error
    }
  }

  Future<void> sendMessage({
    required String assistantModel,
    required String assistantId,
    required String content,
    String? conversationId,
    List<String>? files,
  }) async {
    // Send message to the server
    try {
      messageResponseDto = null;
      
      messageResponseDto = await _conversationService.sendMessage(
        assistantModel: assistantModel,
        assistantId: assistantId,
        content: content,
        files: files, 
        listMessageModel: messages!,
      );

      print('response: $messageResponseDto');
      if (messageResponseDto != null) {
        messages!.messages.add(
          MessageModel(
            assistant: AssistantDto(
              id: assistantId, 
              model: assistantModel, 
              name: ''), 
            role: 'user', 
            content: content
          )
        );

        messages!.messages.add(
          MessageModel(
            assistant: AssistantDto(
              id: assistantId, 
              model: assistantModel, 
              name: ''), 
            role: 'model', 
            content: messageResponseDto!.message
          )
        );
      }

      //conversations = ListThreadChatModel.fromJson(response.data);
      notifyListeners();
    } catch (e) {
      print("An error occurs: ${e}");
      // Handle error
    }
  }

}