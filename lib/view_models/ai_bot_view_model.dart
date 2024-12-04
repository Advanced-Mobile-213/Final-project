import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'package:chatbot_agents/service/ai_bot_service.dart';
import 'dart:developer';
import 'package:chatbot_agents/models/knowledge/knowledge.dart';
import 'package:chatbot_agents/service/knowledge_service.dart';

class AiBotViewModel extends ChangeNotifier {
  final AiBotService _aiBotService = GetItInstance.getIt<AiBotService>();
  final KnowledgeService _knowledgeService =
      GetItInstance.getIt<KnowledgeService>();

  List<AiBot> aiBots = [];
  bool isLoading = false;
  bool success = false;
  List<Knowledge> importedKnowledges = [];
  List<Knowledge> unImportedKnowledges = [];

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
    String? order_field,
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
        orderField: order_field,
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
}
