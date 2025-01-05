import 'dart:developer';

import 'package:chatbot_agents/models/knowledge/knowledge.dart';
import 'package:chatbot_agents/models/knowledge/knowledge_unit.dart';
import 'package:dio/dio.dart';

import '../di/get_it_instance.dart';
import '../utils/network/knowledge_base_api_client.dart';

class KnowledgeService {
  late final KnowledgeBaseApiClient knowledgeBaseApiClient =
  GetItInstance.getIt<KnowledgeBaseApiClient>();

  Future<List<Knowledge>?> getKnowledges({
    String? q,
    String? order,
    String? orderField,
    int? offset,
    int? limit,
  }) async {
    final queryParams = <String, dynamic>{
      if (q != null) 'q': q,
      if (order != null) 'order': order,
      if (orderField != null) 'order_field': orderField,
      if (offset != null) 'offset': offset,
      if (limit != null) 'limit': limit,
    };
    try {
      final response = await knowledgeBaseApiClient.authenticatedDio.get(
        '/kb-core/v1/knowledge',
        queryParameters: queryParams,
      );
      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        if (response.data != null && response.data['data'] != null) {
          final List<dynamic> data = response.data['data'];
          return data.map((e) => Knowledge.fromJson(e)).toList();
        }
      }
    } on DioException catch(e) {
      log("--> An DioException occurs in getKnowledges of KnowledgeService: $e");
    } catch (e) {
      log("--> An error occurs in getKnowledges of KnowledgeService: $e");
    }
    return null;
  }

  Future<List<KnowledgeUnit>?> getKnowledgeUnits({
    required String knowledgeId,
    String? q,
    String? order,
    String? orderField,
    int? offset,
    int? limit,
  }) async {
    final queryParams = <String, dynamic>{
      if (q != null) 'q': q,
      if (order != null) 'order': order,
      if (orderField != null) 'order_field': orderField,
      if (offset != null) 'offset': offset,
      if (limit != null) 'limit': limit,
    };
    try {
      final response = await knowledgeBaseApiClient.authenticatedDio.get(
        '/kb-core/v1/knowledge/$knowledgeId/units',
        queryParameters: queryParams,
      );
      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        if (response.data != null && response.data['data'] != null) {
          final List<dynamic> data = response.data['data'];
          return data.map((e) => KnowledgeUnit.fromJson(e)).toList();
        }
      }
    } on DioException catch(e) {
      log("--> An DioException occurs in getKnowledges of KnowledgeService: $e");
    } catch (e) {
      log("--> An error occurs in getKnowledges of KnowledgeService: $e");
    }
    return null;
  }

  Future<Knowledge?> createKnowledge({
    required String knowledgeName,
    String? description,
  }) async {
    try {
      final postData = <String, dynamic>{
         'knowledgeName': knowledgeName,
         if (description != null) 'description': description,
      };

      final response = await knowledgeBaseApiClient.authenticatedDio.post(
        '/kb-core/v1/knowledge',
        data: postData,
      );

      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        return Knowledge.fromJson(response.data);
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in createKnowledge of KnowledgeService: $e");
    } catch (e) {
      log("--> An error occurs in createKnowledge of KnowledgeService: $e");
    }
    return null;
  }

  Future<Knowledge?> updateKnowledge({
    required String id,
    required knowledgeName,
    String? description,
  }) async {
    try {
      final postData = <String, dynamic>{
        'knowledgeName': knowledgeName,
         if (description!=null) 'description': description,
      };

      final response = await knowledgeBaseApiClient.authenticatedDio.patch(
        '/kb-core/v1/knowledge/$id',
        data: postData,
      );

      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        return Knowledge.fromJson(response.data);
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in updateKnowledge of KnowledgeService: $e");
    } catch (e) {
      log("--> An error occurs in updateKnowledge of KnowledgeService: $e");
    }
    return null;
  }

  Future<bool> deleteKnowledge({required String id}) async {
    try {
      final response = await knowledgeBaseApiClient.authenticatedDio.delete(
        '/kb-core/v1/knowledge/$id',
      );

      if (response.statusCode! < 300 && response.statusCode! >= 200) {
        final result = response.data == 'true' ? true : false;
        return result;
      }
    } on DioException catch (e) {
      log("--> An DioException occurs in deleteAssistant of KnowledgeService: $e");
    } catch (e) {
      log("--> An error occurs in deleteAssistant of KnowledgeService: $e");
    }
    return false;
  }
}