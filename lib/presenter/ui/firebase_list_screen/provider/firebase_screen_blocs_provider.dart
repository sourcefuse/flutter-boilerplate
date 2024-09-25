// ignore_for_file: unused_import

import 'package:clean_arch/core/domain/usecases/delete_item_usecase.dart';
import 'package:clean_arch/core/domain/usecases/get_item_usecase.dart';
import 'package:clean_arch/core/domain/usecases/get_tasks_usescase.dart';
import 'package:clean_arch/core/injector.dart';
import 'package:clean_arch/presenter/bloc/provider/firebase_list_bloc.dart';

// Singleton Bloc Provider,
// This will help to provide multiple bloc through single instance
class FirebaseScreenBlocsProvider {
  FirebaseListBloc? _itemListBloc;
  late GetItemsUseCase getItemUseCaseImpl;
  late DeleteItemUseCase deleteItemUseCaseImpl;

  /// The `HomeBlocsProvider._privateConstructor()` method is a private constructor within the
  /// `HomeBlocsProvider` class in Dart. This constructor is used to initialize the
  /// `deleteItemUseCaseImpl` property of the `HomeBlocsProvider` class by obtaining an instance of the
  /// `DeleteItem` class using the service locator (`sl`) provided by the `injector.dart` file.
  FirebaseScreenBlocsProvider._privateConstructor() {
    deleteItemUseCaseImpl = sl<DeleteItemUseCase>();
  }

  /// The line `static final HomeBlocsProvider instance = HomeBlocsProvider._privateConstructor();` in
  /// the Dart code snippet is creating a static instance of the `HomeBlocsProvider` class using the
  /// private constructor `_privateConstructor()`. This is a common implementation of the Singleton
  /// design pattern in Dart.
  static final FirebaseScreenBlocsProvider instance =
      FirebaseScreenBlocsProvider._privateConstructor();

  /// This Dart function returns an instance of a specific bloc type, creating a new instance if
  /// specified or returning an existing one.
  ///
  /// Args:
  ///   blocType (dynamic): The `blocType` parameter is used to determine the type of Bloc that needs to
  /// be retrieved. In this code snippet, it is used to check if the Bloc type is `ItemListBloc`.
  ///   newInstance (bool): The `newInstance` parameter in the `getBloc` function is a boolean flag that
  /// indicates whether a new instance of the bloc should be created or not. If `newInstance` is set to
  /// `true`, a new instance of the bloc will be created regardless of whether an existing instance
  /// already exists. If. Defaults to false
  ///
  /// Returns:
  ///   If the `blocType` is `ItemListBloc` and `newInstance` is `true` or `_itemListBloc` is `null`, a
  /// new instance of `ItemListBloc` is being returned with the specified dependencies injected. If
  /// `_itemListBloc` is not `null`, the existing instance of `_itemListBloc` is being returned.
  dynamic getBloc({dynamic blocType, bool newInstance = false}) {
    getItemUseCaseImpl = sl<GetItemsUseCase>();
    if (blocType == FirebaseListBloc) {
      if (newInstance || _itemListBloc == null) {
        return _itemListBloc = FirebaseListBloc(
          getItemsUseCase: getItemUseCaseImpl,
          deleteItemUseCase: deleteItemUseCaseImpl,
        );
      }
      if (_itemListBloc != null) {
        return _itemListBloc;
      }
    }
  }

  void dispose() {
    _itemListBloc?.close();
  }
}
