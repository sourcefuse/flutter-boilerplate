import 'package:clean_arch/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetworkExceptions implements Exception {
  NetworkExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.unknown:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(dioError.response?.statusCode ?? 400, dioError);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String? message;

  String _handleError(int statusCode, DioException e) {
    ///-------Handle status codes and and messages
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return "unauthorized Request";
      case 402:
        /// return e.response?.data['msg']; ---this way you can find message from the exception
        return "";
      case 403:
        return "";
      case 404:
        return "Not found";
      case 409:
        return "";
      case 408:
        return "Connection request timeout";
      case 500:
        return 'Internal server error';
      case 503:
        return "Service unavailable";
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message ?? '';
}

void retryApiFromClient(DioException e, RequestOptions? reqOptions, Dio dio,
    ErrorInterceptorHandler handler) {
  var message = NetworkExceptions.fromDioError(e);
  if (navigatorKey.currentContext != null &&
      navigatorKey.currentContext!.mounted) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(content: Text('$message')),
    );
  }

  ///------Here you can find all the req option
}
