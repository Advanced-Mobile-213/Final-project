
import 'dart:developer';

import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/models/knowledge/knowledge.dart';
import 'package:chatbot_agents/service/knowledge_service.dart';
import 'package:flutter/cupertino.dart';

class KnowledgeViewModel extends ChangeNotifier {
  final KnowledgeService _knowledgeService = GetItInstance.getIt<KnowledgeService>();
  List<Knowledge> knowledges = [];

  Future<void> getKnowledges({
    String? q,
    String? order,
    String? orderField,
    int? offset,
    int? limit,
  }) async {
    try {
      final response = await _knowledgeService.getKnowledges(
        q: q,
        order: order,
        orderField: orderField,
        offset: offset,
        limit: limit,
      );
      if (response != null) {
        knowledges = response;
      } else {
        knowledges = [];
      }
    } catch (e) {
      log('--> Error in getKnowledges of KnowledgeViewModel: $e');
    }
  }
  Future<void> createKnowledge({
    required String knowledgeName,
    String? description,
  }) async {
    try {
      final response = await _knowledgeService.createKnowledge(
        knowledgeName: knowledgeName,
        description: description,
      );

      if (response != null) {
        knowledges.add(response);
      }
      notifyListeners();
    } catch (e) {
      log('--> Error in createKnowledge of KnowledgeViewModel: $e');
    }
  }

  Future<Knowledge?> updateKnowledge({
    required id,
    required String knowledgeName,
    String? description,
  }) async {
    try {
      notifyListeners();
      final response = await _knowledgeService.updateKnowledge(
        id: id,
        knowledgeName: knowledgeName,
        description: description
      );
      if (response != null) {
        final index = knowledges.indexWhere((element) => element.id == id);
        if (index != -1) {
          knowledges[index] = response;
        }
        notifyListeners();
        return response;
      }
    } catch (e) {
      log('--> Error in updateKnowledge of KnowledgeViewModel: $e');
    }
    return null;
  }

  Future<void> deleteKnowledge({
    required String id,
  }) async {
    try {
      final response = await _knowledgeService.deleteKnowledge(id: id);
      if (response == true) {
        knowledges.removeWhere((element) => element.id == id);
        notifyListeners();

      }
    } catch (e) {
      log('--> Error in deleteKnowledge of KnowledgeViewModel: $e');
      notifyListeners();
    }
  }
}