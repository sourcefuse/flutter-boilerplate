import 'package:equatable/equatable.dart';

import 'app_exception.dart';

class BaseResponse<T> extends Equatable {
  final T? data;
  final bool? success;
  final AppException? exception;

  const BaseResponse({
    this.data,
    this.success,
    this.exception,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        data: json['data'],
        success: json['success'] ?? false,
      );

  @override
  List<Object?> get props => [data, success, exception];
}
