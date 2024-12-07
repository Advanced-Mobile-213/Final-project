

import 'dart:developer';
import 'dart:io';

import 'package:chatbot_agents/models/knowledge/knowledge_unit.dart';
import 'package:chatbot_agents/service/knowledge_data_source_service.dart';
import 'package:flutter/cupertino.dart';

import '../di/get_it_instance.dart';
import '../service/knowledge_service.dart';

class KnowledgeUnitViewModel extends ChangeNotifier {
  final KnowledgeService _knowledgeService = GetItInstance.getIt<KnowledgeService>();
  final KnowledgeDataSourceService _knowledgeDataSourceService = GetItInstance.getIt<KnowledgeDataSourceService>();

  List<KnowledgeUnit> knowledgeUnits = [];

  Future<void> getKnowledgeUnits({
    required String knowledgeId,
    String? q,
    String? order,
    String? orderField,
    int? offset,
    int? limit,
  }) async {
    try {
      final response = await _knowledgeService.getKnowledgeUnits(
        knowledgeId: knowledgeId,
        q: q,
        order: order,
        orderField: orderField,
        offset: offset,
        limit: limit,
      );
      if (response != null) {
        knowledgeUnits = response;
      } else {
        knowledgeUnits = [];
      }
      notifyListeners();
    } catch (e) {
      log('--> Error in getKnowledges of KnowledgeViewModel: $e');
    }
  }

  Future<void> uploadFile({
    required String knowledgeId,
    required File file,
  }) async {
    try {
      final response = await _knowledgeDataSourceService.uploadLocalFile(
        knowledgeId: knowledgeId,
        file: file,
      );
      if (response != null) {
        knowledgeUnits.add(response);
      }
      notifyListeners();

    } catch (e) {
      log('--> Error in getKnowledges of KnowledgeViewModel: $e');
    }
  }
}