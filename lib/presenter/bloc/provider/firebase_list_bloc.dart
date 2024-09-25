// ignore_for_file: unused_import

import 'package:clean_arch/common/constants.dart';
import 'package:clean_arch/core/data/dto/item_model.dart';
import 'package:clean_arch/core/data/dto/item_request_model.dart';
import 'package:clean_arch/core/domain/entities/task_model.dart';
import 'package:clean_arch/core/domain/usecases/delete_item_usecase.dart';
import 'package:clean_arch/core/domain/usecases/get_item_usecase.dart';
import 'package:clean_arch/core/domain/usecases/get_tasks_usescase.dart';
import 'package:clean_arch/core/domain/usecases/usecase_contracts.dart';
import 'package:clean_arch/presenter/ui/firebase_list_screen/adapter/item_adapter.dart';
import 'package:clean_arch/presenter/ui/firebase_list_screen/data_model/item_view_model.dart';
import 'package:clean_arch/presenter/ui/firebase_list_screen/helper/firebase_item_tile_widget.dart';
import 'package:clean_arch/utils/logs_util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../event/firebase_list_event.dart';
part '../state/firebase_list_state.dart';

class FirebaseListBloc extends Bloc<FirebaseListEvent, FirebaseListState> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final GetItemsUseCase getItemsUseCase;
  final DeleteItemUseCase deleteItemUseCase;
  List<ItemModel> itemList = [];

  /// This code snippet is defining the behavior of the `FirebaseListBloc` class.
  FirebaseListBloc(
      {required this.getItemsUseCase, required this.deleteItemUseCase})
      : super(const ItemListInitialState('')) {
    on<GetItemListEvent>((event, emit) {
      return getItemList(event, emit);
    });
    on<AddNewItemEvent>((event, emit) {
      if (kDebugMode) {
        print('addNewItemExtension');
      }
      return addNewItemExtension(event, emit);
    });
    on<DeleteItemEvent>((event, emit) {
      return deleteItem(event, emit);
    });
  }

  /// This Dart function retrieves a list of items and updates the state accordingly based on the result.
  ///
  /// Args:
  ///   event (GetItemListEvent): The `event` parameter in the `getItemList` function is of type
  /// `GetItemListEvent`. It is used to provide any necessary information or context for fetching the item
  /// list.
  ///   emit (Emitter<ItemListState>): The `emit` parameter in the `getItemList` function is an `Emitter`
  /// that is used to emit states to the UI. In this case, it is emitting different states such as
  /// `ItemListLoadingState`, `ItemListSuccessState`, and `ItemListErrorState` based on
  Future<void> getItemList(
      GetItemListEvent event, Emitter<FirebaseListState> emit) async {
    try {
      emit(const ItemListLoadingState('Loading'));
      itemList = await getItemsUseCase(NoParams());
      List<ItemViewModel> items = _getItemViewModelData();
      emit(ItemListSuccessState(items));
    } catch (e) {
      emit(const ItemListErrorState(kSomethingWentWrongMessage));
    }
  }

  List<ItemViewModel> _getItemViewModelData() {
    List<ItemViewModel> list = [];
    for (var item in itemList) {
      list.add(ItemAdapter.getItemModelData(item));
    }
    return list;
  }

  /// The function `addNewItemExtension` adds a new item to a list, updates the state to indicate loading,
  /// and then updates the state to indicate success.
  ///
  /// Args:
  ///   event (AddNewItemEvent): The `event` parameter in the `addNewItemExtension` function is of type
  /// `AddNewItemEvent`. It likely contains information about the new item that needs to be added.
  ///   emit (Emitter<ItemListState>): The `emit` parameter is an `Emitter` object that is used to emit
  /// state changes in a Flutter Bloc or Cubit. It allows you to send new states to the Bloc or Cubit,
  /// which will then notify the UI to update based on the new state. In the provided code snippet,
  Future<void> addNewItemExtension(
      AddNewItemEvent event, Emitter<FirebaseListState> emit) async {
    //add element in animated list using listKey
    listKey.currentState?.insertItem(itemList.length);
    emit(const ItemListLoadingState('Loading'));
    itemList.add(event.item);
    List<ItemViewModel> items = _getItemViewModelData();
    emit(ItemListSuccessState(items));
  }

  /// This Dart function deletes a item from a list and updates the state accordingly.
  ///
  /// Args:
  ///   event (DeleteItemEvent): The `event` parameter in the `deleteItem` function is of type
  /// `DeleteItemEvent`. It is used to pass information related to the item that needs to be deleted, such
  /// as the `itemRequestModel` containing the unique identifier (`uid`) of the item to be deleted.
  ///   emit (Emitter<ItemListState>): The `emit` parameter in the `deleteItem` function is an
  /// `Emitter<ItemListState>` type. It is used to emit different states of the item list to notify the UI
  /// about the current state of the operation, such as loading, success, or error.
  ///
  /// Returns:
  ///   The `deleteItem` function returns a `Future<void>`.
  Future<void> deleteItem(
      DeleteItemEvent event, Emitter<FirebaseListState> emit) async {
    try {
      emit(const ItemListLoadingState('Loading'));
      await deleteItemUseCase(event.itemRequestModel);
      final index = itemList
          .indexWhere((element) => element.uid == event.itemRequestModel.uid);
      listKey.currentState?.removeItem(
        index,
        (_, animation) {
          return _slide(
              animation,
              FirebaseListItemWidget(
                  item: ItemAdapter.getItemModelData(itemList[index])));
        },
        duration: const Duration(milliseconds: 400),
      );
      itemList.removeAt(index);
      List<ItemViewModel> items = _getItemViewModelData();
      emit(ItemListSuccessState(items));
    } catch (e) {
      LogsUtil.getInstance.printLog('Error: ${e.toString()}');
      emit(const ItemListErrorState(kSomethingWentWrongMessage));
    }
  }

  /// The `_slide` function creates a SlideTransition widget that animates the position of a child widget
  /// using the provided animation.
  ///
  /// Args:
  ///   animation (Animation<double>): The `animation` parameter in the `_slide` function is of type
  /// `Animation<double>`. It is used to control the transition animation of the `SlideTransition` widget.
  /// The animation parameter is typically provided by an `AnimationController` which manages the
  /// animation's progress and status.
  ///   child (Widget): The `child` parameter in the `_slide` function represents the widget that will be
  /// transitioned using the `SlideTransition`. This widget will be animated based on the provided
  /// animation parameter, which controls the transition effect.
  ///
  /// Returns:
  ///   A `SlideTransition` widget is being returned. The `SlideTransition` widget is configured with a
  /// position animation that moves the child widget from an offset of (-2, 0) to (0, 0) based on the
  /// provided animation.
  SlideTransition _slide(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-2, 0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }
}
