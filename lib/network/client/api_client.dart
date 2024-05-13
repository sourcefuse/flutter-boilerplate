import 'package:clean_arch/network/rest_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// The `ApiClient` class in Dart is a singleton class that provides a Dio instance for making API
/// requests with optional logging in debug mode.
class ApiClient {
  static final ApiClient _converter = ApiClient._internal();

  static const String kRequiredHeader = 'Header';
  static const String kAuthorization = 'Authorization';

  factory ApiClient() {
    return _converter;
  }

  ApiClient._internal();

  Dio dio() {
    var dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        error: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ));
    }
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add the access token to the request header
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == RestConstants.unauthorized) {
            // If a 401 response is received, refresh the access token
            // String newAccessToken = await refreshToken();
            // if (newAccessToken.isNotEmpty) {
            //   // Update the request header with the new access token
            //   e.requestOptions.headers['Authorization'] =
            //   'Bearer $newAccessToken';
            //   isRefreshTokenCalled = false;

              // Repeat the request with the updated header
              return handler.resolve(await dio.fetch(e.requestOptions));
            // }
          } else if (e.response?.statusCode == RestConstants.badRequest) {
            //Handle error code 400
          } else if (e.response?.statusCode == RestConstants.forbidden) {
            //Handle error code 403
          } else if (e.response?.statusCode == RestConstants.notFound) {
            //Handle error code 404
          } else if (e.response?.statusCode == RestConstants.internalServerError) {
            //Handle error code 500
          }
          return handler.next(e);
        },
      ),
    );
    return dio;
  }
}
