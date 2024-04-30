import 'package:flutter/foundation.dart';

class LogsUtil {
  LogsUtil._privateConstructor();

  static final LogsUtil getInstance = LogsUtil._privateConstructor();

  /// The `printLog` function prints the provided log message only in debug mode.
  ///
  /// Args:
  ///   log (String): The `log` parameter in the `printLog` function is a string that represents the
  /// message or information that you want to log or print.
  void printLog(String log) {
    if (kDebugMode) {
      print(log);
    }
  }
}
