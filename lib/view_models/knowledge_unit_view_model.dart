import 'dart:developer';
import 'dart:io';

import 'package:chatbot_agents/models/knowledge/knowledge_unit.dart';
import 'package:chatbot_agents/service/knowledge_data_source_service.dart';
import 'package:flutter/cupertino.dart';
import '../di/get_it_instance.dart';
import '../service/knowledge_service.dart';

class KnowledgeUnitViewModel extends ChangeNotifier {
  final KnowledgeService _knowledgeService =
      GetItInstance.getIt<KnowledgeService>();
  final KnowledgeDataSourceService _knowledgeDataSourceService =
      GetItInstance.getIt<KnowledgeDataSourceService>();

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
      log('--> Error in getKnowledgeUnits of KnowledgeUnitViewModel: $e');
    }
  }

  Future<String?> uploadFileFromLocal({
    required String knowledgeId,
    required File file,
  }) async {
    try {
      final response = await _knowledgeDataSourceService.uploadLocalFile(
        knowledgeId: knowledgeId,
        file: file,
      );
      if (response.data != null) {
        knowledgeUnits.add(response.data!);
      }
      notifyListeners();
      if (response.errorMessage != null) {
        return response.errorMessage;
      }
    } catch (e) {
      log('--> Error in uploadFileFromLocal of KnowledgeUnitViewModel: $e');
    }
    return null;
  }

  Future<String?> uploadFromWebsite({
    required String knowledgeId,
    required String unitName,
    required String webUrl
  }) async {
    try {
      final response = await _knowledgeDataSourceService.uploadFromWebsite(
        knowledgeId: knowledgeId,
        unitName: unitName,
        webUrl: webUrl
      );
      if (response.data != null) {
        knowledgeUnits.add(response.data!);
      }
      notifyListeners();
      if (response.errorMessage != null) {
        return response.errorMessage;
      }
    } catch (e) {
      log('--> Error in uploadFromWebsite of KnowledgeUnitViewModel: $e');
    }
    return null;
  }

  Future<String?> uploadFromConfluence({
    required String knowledgeId,
    required String unitName,
    required String confluenceAccessToken,
    required String confluenceUsername,
    required String wikiPageUrl,
  }) async {
    try {
      final response = await _knowledgeDataSourceService.uploadFromConfluence(
          knowledgeId: knowledgeId,
          unitName: unitName,
          confluenceAccessToken: confluenceAccessToken,
          confluenceUsername: confluenceUsername,
          wikiPageUrl: wikiPageUrl
      );
      if (response.data != null) {
        knowledgeUnits.add(response.data!);
      }
      notifyListeners();
      if (response.errorMessage != null) {
        return response.errorMessage;
      }
    } catch (e) {
      log('--> Error in uploadFromConfluence of KnowledgeUnitViewModel: $e');
    }
    return null;
  }

  Future<String?> uploadFromSlack({
    required String knowledgeId,
    required String unitName,
    required String slackBotToken,
    required String slackWorkspace,
  }) async {
    try {
      final response = await _knowledgeDataSourceService.uploadFromSlack(
          knowledgeId: knowledgeId,
          unitName: unitName,
          slackBotToken: slackBotToken,
          slackWorkspace: slackWorkspace,
      );
      if (response.data != null) {
        knowledgeUnits.add(response.data!);
      }
      notifyListeners();
      if (response.errorMessage != null) {
        return response.errorMessage;
      }
    } catch (e) {
      log('--> Error in uploadFromSlack of KnowledgeUnitViewModel: $e');
    }
    return null;
  }

}
