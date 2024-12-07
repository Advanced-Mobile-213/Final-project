import 'dart:developer';
import 'dart:io';

import 'package:chatbot_agents/models/knowledge/knowledge_unit.dart';
import 'package:dio/dio.dart';

import '../di/get_it_instance.dart';
import '../utils/network/knowledge_base_api_client.dart';

class KnowledgeDataSourceService {
  late final KnowledgeBaseApiClient knowledgeBaseApiClient =
  GetItInstance.getIt<KnowledgeBaseApiClient>();

  Future<List<KnowledgeUnit>?> uploadLocalFile(String knowledgeId, File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last, // Extract the file name
      ),
    });

    try {
      final response = await knowledgeBaseApiClient.authenticatedDio.post(
        'kb-core/v1/knowledge/$knowledgeId/local-file',
        data: formData,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        if (response.data != null && response.data['data'] != null) {
          final List<dynamic> data = response.data['data'];
          return data.map((e) => KnowledgeUnit.fromJson(e)).toList();
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
