import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/models/ai_bot/chat_thread.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'package:chatbot_agents/service/ai_bot_service.dart';
import 'dart:developer';
import 'package:chatbot_agents/models/knowledge/knowledge.dart';
import 'package:chatbot_agents/service/knowledge_service.dart';

class Message {
  final String role;
  final String message;

  Message({required this.role, required this.message});
}

class AiBotViewModel extends ChangeNotifier {
  final AiBotService _aiBotService = GetItInstance.getIt<AiBotService>();
  final KnowledgeService _knowledgeService =
      GetItInstance.getIt<KnowledgeService>();

  List<AiBot> aiBots = [];
  bool isLoading = false;
  bool success = false;
  List<Knowledge> importedKnowledges = [];
  List<Knowledge> unImportedKnowledges = [];
  List<Message> messages = [];
  List<ChatThread> threads = [];

  Future<void> createAssistant({
    required String assistantName,
    String? instructions,
    String? description,
  }) async {
    try {
      isLoading = true;
      success = false;
      notifyListeners();
      final response = await _aiBotService.createAssistant(
        assistantName: assistantName,
        instructions: instructions,
        description: description,
      );

      isLoading = false;
      if (response != null) {
        aiBots.add(response);
        success = true;
      } else {
        success = false;
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      success = false;
      notifyListeners();
      log('--> Error in createAssistant of AiBotViewModel: $e');
    }
  }

  Future<void> getAssistants({
    String? q,
    String? order,
    String? orderField,
    int? offset,
    int? limit,
    bool? isFavorite,
    bool? isPublic,
  }) async {
    try {
      isLoading = true;
      success = false;
      notifyListeners();
      final response = await _aiBotService.getAssistants(
        q: q,
        order: order,
        orderField: orderField,
        offset: offset,
        limit: limit,
        isFavorite: isFavorite,
        isPublic: isPublic,
      );
      isLoading = false;
      if (response != null) {
        aiBots = response;
        success = true;
      } else {
        success = false;
        aiBots = [];
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      success = false;
      aiBots = [];
      log('--> Error in getAssistants of AiBotViewModel: $e');
      notifyListeners();
    }
  }

  Future<void> updateAssistant({
    required String assistantId,
    required String assistantName,
    String? instructions,
    String? description,
  }) async {
    try {
      isLoading = true;
      success = false;
      notifyListeners();
      final response = await _aiBotService.updateAssistant(
        assistantId: assistantId,
        assistantName: assistantName,
        instructions: instructions,
        description: description,
      );
      isLoading = false;
      if (response != null) {
        final index = aiBots.indexWhere((element) => element.id == assistantId);
        if (index != -1) {
          aiBots[index] = response;
          success = true;
        }
      } else {
        success = false;
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      success = false;
      log('--> Error in updateAssistant of AiBotViewModel: $e');
      notifyListeners();
    }
  }

  Future<void> deleteAssistant({
    required String assistantId,
  }) async {
    try {
      isLoading = true;
      success = false;
      notifyListeners();
      final response =
          await _aiBotService.deleteAssistant(assistantId: assistantId);
      isLoading = false;
      if (response == true) {
        aiBots.removeWhere((element) => element.id == assistantId);
        success = true;
      } else {
        success = false;
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      success = false;
      log('--> Error in deleteAssistant of AiBotViewModel: $e');
      notifyListeners();
    }
  }

  Future<AiBot?> getAssistant({
    required String assistantId,
  }) async {
    try {
      isLoading = true;
      success = false;
      notifyListeners();
      final response = await _aiBotService.getAssistant(
        assistantId: assistantId,
      );
      isLoading = false;
      if (response != null) {
        success = true;
      } else {
        success = false;
      }
      notifyListeners();
      return response;
    } catch (e) {
      isLoading = false;
      success = false;
      log('--> Error in getAssistant of AiBotViewModel: $e');
      notifyListeners();
      return null;
    }
  }

  Future<void> importKnowledgeToAssistant({
    required String assistantId,
    required Knowledge knowledge,
  }) async {
    try {
      isLoading = true;
      success = false;
      notifyListeners();
      final response = await _aiBotService.importKnowledgeToAssistant(
        assistantId: assistantId,
        knowledgeId: knowledge.id,
      );
      isLoading = false;
      if (response == true) {
        success = true;
        importedKnowledges.add(knowledge);
        unImportedKnowledges
            .removeWhere((element) => element.id == knowledge.id);
      } else {
        success = false;
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      success = false;
      log('--> Error in importKnowledgeToAssistant of AiBotViewModel: $e');
      notifyListeners();
    }
  }

  Future<void> removeKnowledgeFromAssistant({
    required String assistantId,
    required Knowledge knowledge,
  }) async {
    try {
      isLoading = true;
      success = false;
      notifyListeners();
      final response = await _aiBotService.removeKnowledgeFromAssistant(
        assistantId: assistantId,
        knowledgeId: knowledge.id,
      );
      isLoading = false;
      if (response == true) {
        success = true;
        importedKnowledges.removeWhere((element) => element.id == knowledge.id);
        unImportedKnowledges.add(knowledge);
      } else {
        success = false;
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      success = false;
      log('--> Error in removeKnowledgeFromAssistant of AiBotViewModel: $e');
      notifyListeners();
    }
  }

  Future<void> getImportedKnowledgeInAssistant({
    required String assistantId,
  }) async {
    try {
      isLoading = true;
      success = false;
      notifyListeners();
      final response = await _aiBotService.getImportedKnowledgeInAssistant(
        assistantId: assistantId,
      );
      isLoading = false;
      if (response != null) {
        success = true;
        importedKnowledges = response;
      } else {
        success = false;
        importedKnowledges = [];
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      success = false;
      importedKnowledges = [];
      log('--> Error in getImportedKnowledgeInAssistant of AiBotViewModel: $e');
      notifyListeners();
    }
  }

  // There are no direct API to get unimported knowledge of a assistant
  // So, we need to get all knowledge and then filter out the imported knowledge
  Future<void> getUnImportedKnowledgeInAssistant({
    required String assistantId,
  }) async {
    try {
      isLoading = true;
      success = false;
      notifyListeners();
      var importedKnowledges = await _aiBotService
          .getImportedKnowledgeInAssistant(assistantId: assistantId);

      var allKnowledges = await _knowledgeService.getKnowledges();

      List<Knowledge>? result;
      if (importedKnowledges != null && allKnowledges != null) {
        result = allKnowledges.where((element) {
          return !importedKnowledges
              .any((importedKnowledge) => importedKnowledge.id == element.id);
        }).toList();

        success = true;
        unImportedKnowledges = result;
      } else {
        success = false;
        unImportedKnowledges = [];
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      success = false;
      unImportedKnowledges = [];
      log('--> Error in getUnImportedKnowledgeInAssistant of AiBotViewModel: $e');
      notifyListeners();
    }
  }

  Future<ChatThread?> createThread({
    required String assistantId,
    String? firstMessage,
  }) async {
    try {
      isLoading = true;
      success = false;
      notifyListeners();
      final response = await _aiBotService.createThread(
        assistantId: assistantId,
        firstMessage: firstMessage,
      );
      isLoading = false;
      if (response != null) {
        success = true;
        notifyListeners();
        return response;
      } else {
        success = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      isLoading = false;
      success = false;
      log('--> Error in createThead of AiBotViewModel: $e');
      notifyListeners();
    }
    return null;
  }

  Future<String?> updateAssistantWithNewThreadPlayground(
      {required String assistantId, String? firstMessage}) async {
    try {
      isLoading = true;
      success = false;
      notifyListeners();
      final response =
          await _aiBotService.updateAssistantWithNewThreadPlayground(
        assistantId: assistantId,
        firstMessage: firstMessage,
      );
      isLoading = false;
      if (response != null) {
        success = true;
        await getAssistant(assistantId: assistantId);
        messages = [];
      } else {
        success = false;
      }
      notifyListeners();
      return response;
    } catch (e) {
      isLoading = false;
      success = false;
      log('--> Error in updateAssistantWithNewThreadPlayground of AiBotViewModel: $e');
      notifyListeners();
      return null;
    }
  }

  Future<void> askAssistant(
      {required String assistantId,
      required String message,
      required openAiThreadId,
      String? additionalInstruction}) async {
    try {
      log('--> Ask assistant: $assistantId, $message, $openAiThreadId');

      isLoading = true;
      success = false;
      messages.add(Message(role: 'user', message: message));
      notifyListeners();
      final response = await _aiBotService.askAssistant(
        assistantId: assistantId,
        message: message,
        openAiThreadId: openAiThreadId,
        additionalInstruction: additionalInstruction,
      );
      isLoading = false;
      if (response != null) {
        success = true;
        messages.add(Message(role: 'assistant', message: response));
      } else {
        success = false;
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      success = false;

      log('--> Error in askAssistant of AiBotViewModel: $e');
      notifyListeners();
    }
  }

  Future<void> retrieveMessageOfThread({
    required String openAiThreadId,
  }) async {
    try {
      isLoading = true;
      success = false;
      messages = [];
      notifyListeners();
      final response = await _aiBotService.retrieveMessageOfThread(
        openAiThreadId: openAiThreadId,
      );
      isLoading = false;
      if (response != null) {
        success = true;
        for (var element in response) {
          messages.insert(
            0,
            Message(
              role: element.role,
              message: element.content[0].text.value,
            ),
          );
        }
      } else {
        success = false;
        messages = [];
      }
      notifyListeners();
    } catch (e) {
      isLoading = false;
      success = false;
      messages = [];
      log('--> Error in getPreviewMessages of AiBotViewModel: $e');
      notifyListeners();
    }
  }

  Future<void> getThreads({
    required String assistantId,
    String? q,
    String? order,
    String? orderField,
    int? offset,
    int? limit,
  }) async {
    try {
      isLoading = true;
      success = false;
      notifyListeners();
      final response = await _aiBotService.getThreads(
        assistantId: assistantId,
        q: q,
        order: order,
        orderField: orderField,
        offset: offset,
        limit: limit,
      );
      isLoading = false;
      if (response != null) {
        threads = response;
        success = true;
      } else {
        success = false;
      }
      success = true;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      success = false;
      log('--> Error in getThreads of AiBotViewModel: $e');
      notifyListeners();
    }
  }

  Future<void> favoriteAssistant({
    required String assistantId,
  }) async {
    try {
      //isLoading = true;
      success = false;
      notifyListeners();
      final response = await _aiBotService.favoriteAssistant(
        assistantId: assistantId,
      );
      //isLoading = false;
      if (response != null) {
        success = true;
      } else {
        success = false;
      }
      notifyListeners();
    } catch (e) {
      //isLoading = false;
      success = false;
      log('--> Error in favoriteAssistant of AiBotViewModel: $e');
      notifyListeners();
    }
  }
}
