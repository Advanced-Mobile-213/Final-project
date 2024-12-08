import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatbot_agents/models/knowledge/knowledge_unit.dart';
import 'package:dio/dio.dart';

import '../di/get_it_instance.dart';
import '../utils/network/knowledge_base_api_client.dart';

class KnowledgeDataSourceService {
  late final KnowledgeBaseApiClient knowledgeBaseApiClient =
  GetItInstance.getIt<KnowledgeBaseApiClient>();



// Upload File Using Dio with Correct Key Mapping & FormData


  Future<KnowledgeUnit?> uploadLocalFile({
    required String knowledgeId,
    required File file,
  }) async {
    // Create the FormData with the correct key name "File"
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
      ),
    });
    try {
      // Send the POST request
      final response = await knowledgeBaseApiClient.authenticatedDio.post(
        'kb-core/v1/knowledge/$knowledgeId/local-file',
        data: formData,
      );

      log("Request URL: ${response.requestOptions.path}");
      log("Request Headers: ${response.requestOptions.headers}");
      log("Response Data: ${response.data}");

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        if (response.data != null && response.data['data'] != null) {
          return KnowledgeUnit.fromJson(response.data);
        }
      }
    } on DioException catch (e) {
      log("--> A DioException occurred in uploadLocalFile of KnowledgeDataSource: $e");
    } catch (e) {
      log("--> An error occurred in uploadLocalFile of KnowledgeDataSource: $e");
    }

    return null;
  }




}
