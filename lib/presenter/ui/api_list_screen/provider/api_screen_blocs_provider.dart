// ignore_for_file: unused_import

import 'package:clean_arch/core/domain/usecases/delete_item_usecase.dart';
import 'package:clean_arch/core/domain/usecases/get_item_usecase.dart';
import 'package:clean_arch/core/domain/usecases/get_tasks_usescase.dart';
import 'package:clean_arch/core/injector.dart';
import 'package:clean_arch/presenter/bloc/provider/api_list_bloc.dart';
import 'package:clean_arch/presenter/bloc/provider/firebase_list_bloc.dart';

// Singleton Bloc Provider,
// This will help to provide multiple bloc through single instance
class APIScreenBlocsProvider {
  APIListBloc? _apiListBloc;
  late GetTasksUsescase getTasksUsescase;

  /// The `APIScreenBlocsProvider._privateConstructor()` method is a private constructor within the
  /// `APIScreenBlocsProvider` class in Dart. This constructor is used to initialize the
  APIScreenBlocsProvider._privateConstructor() {
    getTasksUsescase = sl<GetTasksUsescase>();
  }

  /// The line `static final APIScreenBlocsProvider instance = APIScreenBlocsProvider._privateConstructor();` in
  /// the Dart code snippet is creating a static instance of the `APIScreenBlocsProvider` class using the
  /// private constructor `_privateConstructor()`. This is a common implementation of the Singleton
  /// design pattern in Dart.
  static final APIScreenBlocsProvider instance =
      APIScreenBlocsProvider._privateConstructor();

  /// This Dart function returns an instance of a specific bloc type, creating a new instance if
  /// specified or returning an existing one.
  ///
  /// Args:
  ///   blocType (dynamic): The `blocType` parameter is used to determine the type of Bloc that needs to
  /// be retrieved. In this code snippet, it is used to check if the Bloc type is `APIListBloc`.
  ///   newInstance (bool): The `newInstance` parameter in the `getBloc` function is a boolean flag that
  /// indicates whether a new instance of the bloc should be created or not. If `newInstance` is set to
  /// `true`, a new instance of the bloc will be created regardless of whether an existing instance
  /// already exists. If. Defaults to false
  ///
  /// Returns:
  ///   If the `blocType` is `APIListBloc` and `newInstance` is `true` or `_APIListBloc` is `null`, a
  /// new instance of `APIListBloc` is being returned with the specified dependencies injected. If
  /// `_APIListBloc` is not `null`, the existing instance of `_APIListBloc` is being returned.
  dynamic getBloc({dynamic blocType, bool newInstance = false}) {
    if (blocType == APIListBloc) {
      if (newInstance || _apiListBloc == null) {
        return _apiListBloc = APIListBloc(
            getTasksUsescase: getTasksUsescase);
      }
      if (_apiListBloc != null) {
        return _apiListBloc;
      }
    }
  }

  void dispose() {
    _apiListBloc?.close();
  }
}
