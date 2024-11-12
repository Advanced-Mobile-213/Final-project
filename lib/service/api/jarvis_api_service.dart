import 'package:dio/dio.dart';

class JarvisApiService {
  static final JarvisApiService _instance = JarvisApiService._internal();
  factory JarvisApiService() => _instance;
  JarvisApiService._internal();

  // Dio instances
  late Dio publicDio;          // For public APIs
  late Dio authenticatedDio;   // For authenticated APIs

  String? _accessToken;
  String? _refreshToken;

  JarvisApiService.init(String baseUrl) {
    // Initialize public Dio instance without Authorization
    publicDio = Dio(BaseOptions(baseUrl: baseUrl));

    // Initialize authenticated Dio instance (interceptor added after login)
    authenticatedDio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  // Method to set the tokens after login and add interceptor
  void setToken(String accessToken, String refreshToken) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    // Add the interceptor to authenticatedDio for attaching tokens
    authenticatedDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_accessToken != null) {
            options.headers['Authorization'] = 'Bearer $_accessToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 && _refreshToken != null) {
            // Attempt to refresh the token if unauthorized (401) error occurs
            final success = await _refreshAccessToken();
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
                return handler.reject(e);
              }
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  // Optional: Clear the tokens on logout
  void clearToken() {
    _accessToken = null;
    _refreshToken = null;
    authenticatedDio.interceptors.clear(); // Remove interceptor on logout
  }

  // Private method to refresh the access token
  Future<bool> _refreshAccessToken() async {
    if (_refreshToken  == null) {
      return false;
    }
    try {
      final response = await publicDio.get("api/v1/auth/refresh?refreshToken=${_refreshToken}");
      _accessToken = response.data["accessToken"];
      return true;
    } catch (e) {
      clearToken(); // Clear tokens if refresh fails
      return false;
    }
  }
}
