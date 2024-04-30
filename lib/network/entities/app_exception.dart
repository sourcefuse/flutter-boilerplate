import 'package:equatable/equatable.dart';

// coverage:ignore-file
class AppException  extends Equatable implements Exception {
  final String? message;
  final String? prefix;

  const AppException([this.message, this.prefix]);

  @override
  String toString() {
    return "${prefix ?? ""}${message ?? ""}";
  }

  @override
  List<Object?> get props => [message, prefix];
}

class FetchDataException extends AppException {
  const FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  const BadRequestException([String? message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  const UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  const InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class NoInternetException extends AppException {
  const NoInternetException([String? message])
      : super(message, "No internet connection found!");
}

class ServerConnectionException extends AppException {
  const ServerConnectionException([String? message]) : super(message, '');
}
