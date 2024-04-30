import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:clean_arch/utils/logs_util.dart';

import '../../common/constants.dart';
import '../../network/entities/app_exception.dart';
import '../../network/entities/base_response.dart';

/// Base class for all the data source which will call
/// external APIs for the data.
class BaseApiDS {
  /// Wrapper for API calls for handling errors at common place
  /// instead of parsing it in calling Widgets.
  Future<BaseResponse<T>> callApi<T>(Future<Response<T>> future) {
    return future.then((response) {
      jsonEncode(response.data);
      return BaseResponse(data: response.data, success: true);
    }).onError((error, stackTrace) {
      // If error is DioError i.e http exception, we
      // should parse the exact message instead of
      // returning the HTTP Status code and standard message.
      if (error is DioException) {
        // Check if error is of time out error
        if (error.type == DioExceptionType.sendTimeout ||
            error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout) {
          return const BaseResponse(
            exception: ServerConnectionException(kServerConnectionErrorMessage),
          );
        }

        // Check if the error is regarding no internet connection.
        if (error.type == DioExceptionType.unknown &&
            error.error is SocketException) {
          return const BaseResponse(
            exception: NoInternetException(),
          );
        }

        final exception = _getErrorObject(error);
        return BaseResponse(exception: exception);
      }

      // We are here that means the error wasn't http exception.
      // This could be any un-handled exception from server.
      // In this case, instead of showing weird errors to users
      // like bad response or internal server error, show him
      // a generic message.
      return const BaseResponse(
        exception: AppException(kSomethingWentWrongMessage),
      );
    });
  }

  /// Parses the response to get the error object if any
  /// from the API response based on status code.
  AppException _getErrorObject(DioException error) {
    final responseData = error.response?.data;

    try {
      return AppException(
          responseData['message'] ?? kSomethingWentWrongMessage);
    } on Exception catch (e) {
      LogsUtil.getInstance.printLog(e.toString());
      return const AppException(kSomethingWentWrongMessage);
    }
  }
}
