import 'package:dio/dio.dart';

class JarvisApiClient {
  static final JarvisApiClient _instance = JarvisApiClient._internal();
  factory JarvisApiClient() => _instance;
  JarvisApiClient._internal();

  // Dio instances
  late Dio publicDio;          // For public APIs
  late Dio authenticatedDio;   // For authenticated APIs

  String? _accessToken;
  String? _refreshToken;

  String get accessToken => _accessToken!;
  String get refreshToken => _refreshToken!;

  JarvisApiClient.init(String baseUrl) {
    // Initialize public Dio instance without Authorization
    publicDio = Dio(BaseOptions(baseUrl: baseUrl));

    // Initialize authenticated Dio instance (interceptor added after login)
    authenticatedDio = Dio(BaseOptions(baseUrl: baseUrl));
    // Add the interceptor to authenticatedDio for attaching tokens
    authenticatedDio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_accessToken != null) {
            options.headers['Authorization'] = 'Bearer $_accessToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 && _refreshToken != null) {
            // Attempt to refresh the token if unauthorized (401) error occurs
            print('${error.response?.statusCode} error occurred IN INTERCEPTOR');
            final success = await refreshAccessToken();
            if (success) {
              // Retry the original request with the new token
              final originalRequest = error.requestOptions;
              originalRequest.headers['Authorization'] = 'Bearer $_accessToken';

              try {
                final retryResponse = await authenticatedDio.request(
                  originalRequest.path,
                  options: Options(
                    method: originalRequest.method,
                    headers: originalRequest.headers,
                  ),
                  data: originalRequest.data,
                  queryParameters: originalRequest.queryParameters,
                );
                return handler.resolve(retryResponse);
              } on DioException catch (e) {
                print('Get access token failed');
                return handler.reject(e);
              }
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  // Method to set the tokens after login and add interceptor
  void setToken(String accessToken, String refreshToken) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  // Optional: Clear the tokens on logout
  void clearToken() {
    _accessToken = null;
    _refreshToken = null;
    authenticatedDio.interceptors.clear(); // Remove interceptor on logout
  }

  // Private method to refresh the access token
  Future<bool> refreshAccessToken() async {
    if (_refreshToken  == null) {
      return false;
    }
    try {
      print('refreshing token: $_refreshToken');
      final response = await publicDio.get("api/v1/auth/refresh?refreshToken=${_refreshToken}");
      _accessToken = response.data['token']["accessToken"];

      if (_accessToken != null) {
        return true;
      }

      return false;
    } catch (e) {
      clearToken(); // Clear tokens if refresh fails
      return false;
    }
  }
}
