import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/dto/email_reply/ai_reply_email_request.dart';
import 'package:chatbot_agents/dto/email_reply/ai_reply_email_response.dart';
import 'package:chatbot_agents/dto/email_reply/ideas_response.dart';
import 'package:chatbot_agents/dto/email_reply/meta_data/ai_email_meta_data_request.dart';
import 'package:chatbot_agents/dto/email_reply/meta_data/ai_email_style_request.dart';
import 'package:chatbot_agents/dto/email_reply/suggest_reply_idea_request.dart';
import 'package:chatbot_agents/dto/send_message/meta_data/assistant_request.dart';
import 'package:chatbot_agents/service/email_service.dart';
import 'package:chatbot_agents/service/token_service.dart';
import 'package:flutter/material.dart';

class EmailReplyViewModel extends ChangeNotifier {
  final TokenService _tokenService = GetItInstance.getIt<TokenService>();
  final EmailService _emailService = GetItInstance.getIt<EmailService>();
  IdeasResponse? ideasResponse=null;
  AiReplyEmailResponse? replyEmailResponse=null;
  int remainingToken = 0;
  bool isLoading = false;
  bool isReplying = false;

  Future<void> replyEmail({
    required String emailSubject,
    required String emailContent,
    required String emailSender,
    required String emailReceiver,
    required String emailLanguage,
    required String mainIdea,
    required String emailLength,
    required String emailFormality,
    required String emailTone,
    required String emailAction,
    required String assistantModel, 
    required String assistantId,
  }) async {
    try {
      
      replyEmailResponse = null;
      AssistantRequest assistant = AssistantRequest(
        id: assistantId, 
        model: assistantModel, 
        name: ''
      );

      AiEmailStyleRequest style = AiEmailStyleRequest(
        length: emailLength, 
        formality: emailFormality, 
        tone: emailTone
      );

      AiEmailMetaDataRequest metadata = AiEmailMetaDataRequest(
        context: [], 
        subject: emailSubject,
        sender: emailSender,
        receiver: emailReceiver, 
        language: emailLanguage,
        style: style
      );

      AiReplyEmailRequest request = AiReplyEmailRequest(
        assistant: assistant,
        email: emailContent,
        action: emailAction,
        mainIdea: mainIdea,
        metadata: metadata,
        
       
      );

      isReplying = true;
      replyEmailResponse = await _emailService.replyEmail(
        request,
      );
      
      isReplying = false;
      notifyListeners();
    } catch (e) {
      print("An error occurs: ${e}");
      // Handle error
    }
  }

  Future<void> suggestEmailReplyIdeas({
    required String emailSubject,
    required String emailContent,
    required String emailSender,
    required String emailReceiver,
    required String emailLanguage,
    required String action,
    required String length,
    required String assistantModel, 
    required String assistantId,
  }) async {
    try {
      
      ideasResponse = null;
      AssistantRequest assistantRequest = AssistantRequest(
        id: assistantId, 
        model: assistantModel, 
        name: ''
      );

      AiEmailMetaDataRequest metadata = AiEmailMetaDataRequest(
        context: [], 
        subject: emailSubject,
        sender: emailSender,
        receiver: emailReceiver,
        language: emailLanguage,
      );

      SuggestReplyIdeaRequest request = SuggestReplyIdeaRequest(
        action: action, email: 
        emailContent,
        assistant: assistantRequest,
        metadata: metadata,
      );

      print('request in vm: ${request.toJson()}');

      isLoading = true;
      ideasResponse = await _emailService.suggestEmailReplyIdeas(
        request,
      );

      //await Future.delayed(Duration(seconds: 1));

      // ideasResponse = IdeasResponse(
      //   ideas: [
      //     "I will get back to you as soon as possible 1",
      //     "I will get back to you as soon as possible 2",
      //     "I will get back to you as soon as possible 3",
      //   ]
      // );
      isLoading = false;
      notifyListeners();

    } catch (e) {
      print("An error occurs: ${e}");
      // Handle error
    }
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

  void clearData() {
    ideasResponse = null;
    replyEmailResponse = null;
    isLoading = false;
    isReplying = false;
    notifyListeners();
  }
}