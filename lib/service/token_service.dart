import 'package:chatbot_agents/di/get_it_instance.dart';
import 'package:chatbot_agents/utils/network/jarvis_api_client.dart';
import 'package:dio/dio.dart';

class TokenService {
  late final JarvisApiClient _jarvisApiClient =  GetItInstance.getIt<JarvisApiClient>();

  Future<int> getRemainingToken() async {
    try {
      final response = await _jarvisApiClient
        .authenticatedDio
        .get(
          '/api/v1/tokens/usage',
        );

      print(response);

      if (response.statusCode! <300 && response.statusCode! >= 200) {
        return response.data['availableTokens'] ?? 0;
      }

    } on  DioException catch (e) {
      print("An DioException occurs: ${e}");
    } catch (e) {
      print("An error occurs: ${e}");
    }

    return 0;
  }
}