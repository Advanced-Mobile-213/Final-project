import 'package:flutter/material.dart';
import 'package:chatbot_agents/models/ai_bot/ai_bot.dart';
import 'package:chatbot_agents/service/ai_bot_service.dart';
import 'dart:developer';

class AiBotViewModel extends ChangeNotifier {
  final AiBotService _aiBotService = AiBotService();

  List<AiBot> aiBots = [];
  bool isLoading = false;
  bool success = false;

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
        notifyListeners();
      } else {
        success = false;
      }
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
}
