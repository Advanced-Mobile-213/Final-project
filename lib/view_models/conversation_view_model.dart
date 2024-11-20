import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/models/get_conversation_history/list_message_response_model.dart';
import 'package:chatbot_agents/models/send_message/list_message_model.dart';
import 'package:chatbot_agents/models/send_message/message_model.dart';
import 'package:chatbot_agents/models/send_message/message_response_dto.dart';
import 'package:chatbot_agents/models/send_message/meta_data_dto/assistant_dto.dart';
import 'package:chatbot_agents/service/conversation_service/conversation_service.dart';
import 'package:chatbot_agents/service/token_service/token_service.dart';
import 'package:flutter/material.dart';

class ConversationViewModel extends ChangeNotifier {
  final ConversationService _conversationService = GetItInstance.getIt<ConversationService>();
  final TokenService _tokenService = GetItInstance.getIt<TokenService>();

  ListMessageModel? messages = ListMessageModel(messages: [], id: '');

  ListMessageResponseModel? listHistoryMessages;
  bool isLoadingConversationHistory = false;

  ListMessageResponseModel? moreMessage;
  bool isLoadingMoreConversationHistory = false;

  MessageResponseDto? messageResponseDto;

  int remainingToken = 0;

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
      //notifyListeners();

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

      if (listHistoryMessages != null) {
        messages = ListMessageModel(messages: [], id: conversationId);
        listHistoryMessages!.items.forEach((element) {
          messages!.messages.add(
            MessageModel(
              assistant: AssistantDto(
                id: assistantId, 
                model: assistantModel, 
                name: ''), 
              role: 'user', 
              content: element.query!, 
            ),
          );

          messages!.messages.add(
            MessageModel(
              assistant: AssistantDto(
                id: assistantId, 
                model: assistantModel, 
                name: ''), 
              role: 'model', 
              content: element.answer!,
            ),
          );
        });
      }

      notifyListeners();
    } catch (e) {
      print("An error occurs: ${e}");
      // Handle error
    }
  }

  Future<void> getMoreConversationHistory({
    required String conversationId,
    required String assistantModel, 
    required String assistantId,
    required String cursor, 
    int? limit 
  }) async {
    // Fetch conversation from the server
    try {
      isLoadingMoreConversationHistory = true;
      //notifyListeners();

      moreMessage =null;

      moreMessage = await _conversationService.getConversationHistory(
        conversationId: conversationId,
        assistantModel: assistantModel,
        assistantId: assistantId,
        cursor: cursor,
        limit: limit,
      );

      if (moreMessage != null && moreMessage!.items.isNotEmpty) {
        if (listHistoryMessages == null) {
          listHistoryMessages = moreMessage;
        } else {
          listHistoryMessages!.items.insertAll(0, moreMessage!.items);
        }
        listHistoryMessages?.cursor = moreMessage!.cursor;
        listHistoryMessages?.hasMore = moreMessage!.hasMore;
        listHistoryMessages?.limit = moreMessage!.limit;
      }

      print('list history Messages: $listHistoryMessages');
      isLoadingMoreConversationHistory = false;
      //conversations = ListThreadChatModel.fromJson(response.data);

      if (listHistoryMessages != null && moreMessage != null && moreMessage!.items.isNotEmpty) {
        moreMessage!.items.forEach((element) {
          messages!.messages.insert(0,
            MessageModel(
              assistant: AssistantDto(
                id: assistantId, 
                model: assistantModel, 
                name: ''), 
              role: 'user', 
              content: element.query!, 
            ),
          );

          messages!.messages.insert(0,
            MessageModel(
              assistant: AssistantDto(
                id: assistantId, 
                model: assistantModel, 
                name: ''), 
              role: 'model', 
              content: element.answer!,
            ),
          );
        });
        // messages = ListMessageModel(messages: [], id: conversationId);
        // listHistoryMessages!.items.forEach((element) {
        //   messages!.messages.add(
        //     MessageModel(
        //       assistant: AssistantDto(
        //         id: assistantId, 
        //         model: assistantModel, 
        //         name: ''), 
        //       role: 'user', 
        //       content: element.query!, 
        //     ),
        //   );

        //   messages!.messages.add(
        //     MessageModel(
        //       assistant: AssistantDto(
        //         id: assistantId, 
        //         model: assistantModel, 
        //         name: ''), 
        //       role: 'model', 
        //       content: element.answer!,
        //     ),
        //   );
        // });
      }

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
      
      if (conversationId!= null) {
        messages?.id = conversationId;
      }

      messageResponseDto = await _conversationService.sendMessage(
        assistantModel: assistantModel,
        assistantId: assistantId,
        content: content,
        files: files, 
        listMessageModel: messages!,
      );

      print('messageResponseDto: $messageResponseDto');
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

        remainingToken = messageResponseDto!.remainingUsage;

      }

      
      //conversations = ListThreadChatModel.fromJson(response.data);
      notifyListeners();
    } catch (e) {
      print("An error occurs: ${e}");
      // Handle error
    }
  }

  void clearContextOfConversation() {
    messages = ListMessageModel(messages: [], id: '');
    notifyListeners();
  }

  void setContextOfConversation(ListMessageModel listMessageModel) {
    messages = listMessageModel;
    notifyListeners();
  }

  Future<void> getRemainingToken() async {
    try {
      remainingToken = await _tokenService.getRemainingToken();
      notifyListeners();
      
    } catch (e) {
      print("An error occurs: ${e}");
      // Handle error
    }
  }

}