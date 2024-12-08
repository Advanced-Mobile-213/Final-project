import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatbot_agents/dto/knowledge_data_source/knowledge_unit_response.dart';
import 'package:chatbot_agents/models/knowledge/knowledge_unit.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

import '../di/get_it_instance.dart';
import '../utils/network/knowledge_base_api_client.dart';

class KnowledgeDataSourceService {
  late final KnowledgeBaseApiClient knowledgeBaseApiClient =
  GetItInstance.getIt<KnowledgeBaseApiClient>();

  Future<KnowledgeUnitResponse> uploadLocalFile({
    required String knowledgeId,
    required File file,
  }) async {
    final mimeType = lookupMimeType(file.path) ?? 'text/plain';
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
        contentType: DioMediaType.parse(mimeType),
      ),
    });
    try {
      // Send the POST request
      final response = await knowledgeBaseApiClient.authenticatedDio.post(
        'kb-core/v1/knowledge/$knowledgeId/local-file',
        data: formData,
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        if (response.data != null && response.data != null) {
          return KnowledgeUnitResponse(data: KnowledgeUnit.fromJson(response.data));
        }
      }
    } on DioException catch (e) {
      log("--> A DioException occurred in uploadLocalFile of KnowledgeDataSource: $e");
      // log("DioException occurred: ${e.response?.data}");
      return KnowledgeUnitResponse(errorMessage: e.response?.data['details']![0]!['issue'] ?? "Something went wrong, try again!");
    } catch (e) {
      log("--> An error occurred in uploadLocalFile of KnowledgeDataSource: $e");
    }
    return const KnowledgeUnitResponse(errorMessage:  "Something went wrong, try again!");
  }

  Future<KnowledgeUnitResponse> uploadFromWebsite({
    required String knowledgeId,
    required String unitName,
    required String webUrl,
  }) async {

    final requestBody = <String, dynamic>  {
      "unitName" : unitName,
      "webUrl" : webUrl
    };
    try {
      // Send the POST request
      final response = await knowledgeBaseApiClient.authenticatedDio.post(
        'kb-core/v1/knowledge/$knowledgeId/web',
        data: requestBody,
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        if (response.data != null && response.data != null) {
          return KnowledgeUnitResponse(data: KnowledgeUnit.fromJson(response.data));
        }
      }
    } on DioException catch (e) {
      log("--> A DioException occurred in uploadFromWebsite of KnowledgeDataSource: $e");
      return KnowledgeUnitResponse(errorMessage: e.response?.data['details']![0]!['issue'] ?? "Something went wrong, try again!");
    } catch (e) {
      log("--> An error occurred in uploadFromWebsite of KnowledgeDataSource: $e");
    }
    return const KnowledgeUnitResponse(errorMessage:  "Something went wrong, try again!");
  }

  Future<KnowledgeUnitResponse> uploadFromSlack({
    required String knowledgeId,
    required String unitName,
    required String slackWorkspace,
    required String slackBotToken,
  }) async {

    final requestBody = <String, dynamic>  {
      "unitName" : unitName,
      "slackWorkspace" : slackWorkspace,
      "slackBotToken" : slackBotToken,
    };
    try {
      // Send the POST request
      final response = await knowledgeBaseApiClient.authenticatedDio.post(
        'kb-core/v1/knowledge/$knowledgeId/slack',
        data: requestBody,
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        if (response.data != null && response.data != null) {
          return KnowledgeUnitResponse(data: KnowledgeUnit.fromJson(response.data));
        }
      }
    } on DioException catch (e) {
      log("--> A DioException occurred in uploadFromSlack of KnowledgeDataSource: $e");
      return KnowledgeUnitResponse(errorMessage: e.response?.data['details']![0]!['issue'] ?? "Something went wrong, try again!");
    } catch (e) {
      log("--> An error occurred in uploadFromSlack of KnowledgeDataSource: $e");
    }
    return const KnowledgeUnitResponse(errorMessage:  "Something went wrong, try again!");
  }

  Future<KnowledgeUnitResponse> uploadFromConfluence({
    required String knowledgeId,
    required String unitName,
    required String wikiPageUrl,
    required String confluenceUsername,
    required String confluenceAccessToken,
  }) async {

    final requestBody = <String, dynamic>  {
      "unitName" : unitName,
      "wikiPageUrl" : wikiPageUrl,
      "confluenceUsername" : confluenceUsername,
      "confluenceAccessToken" : confluenceAccessToken,
    };
    try {
      // Send the POST request
      final response = await knowledgeBaseApiClient.authenticatedDio.post(
        'kb-core/v1/knowledge/$knowledgeId/confluence',
        data: requestBody,
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        if (response.data != null && response.data != null) {
          return KnowledgeUnitResponse(data: KnowledgeUnit.fromJson(response.data));
        }
      }
    } on DioException catch (e) {
      log("--> A DioException occurred in uploadFromConfluence of KnowledgeDataSource: $e");
      return KnowledgeUnitResponse(errorMessage: e.response?.data['details']![0]!['issue'] ?? "Something went wrong, try again!");
    } catch (e) {
      log("--> An error occurred in uploadFromConfluence of KnowledgeDataSource: $e");
    }
    return const KnowledgeUnitResponse(errorMessage:  "Something went wrong, try again!");
  }
}
