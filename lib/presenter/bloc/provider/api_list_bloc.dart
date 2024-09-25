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
import 'package:clean_arch/utils/logs_util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../event/api_list_event.dart';
part '../state/api_list_state.dart';

class APIListBloc extends Bloc<APIListEvent, APIListState> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final GetTasksUsescase getTasksUsescase;
  List<Task> tasksList = [];

  /// This code snippet is defining the behavior of the `APIListBloc` class.
  APIListBloc(
      {required this.getTasksUsescase})
      : super(const InitialState('')) {
    on<GetTasksListEvent>((event, emit) {
      return getTasksList(event, emit);
    });
  }

  /// This Dart function retrieves a list of tasks and emits loading, success, or error states
  /// accordingly.
  /// 
  /// Args:
  ///   event (GetTasksListEvent): The `event` parameter in the `getTasksList` function is of type
  /// `GetTasksListEvent`. It is used to provide information or trigger specific actions related to
  /// getting the tasks list.
  ///   emit (Emitter<APIListState>): The `emit` parameter in the `getTasksList` function is an
  /// `Emitter` object that is used to emit states to the UI. In this case, it is used to emit different
  /// states such as `LoadingState`, `TasksListSuccessState`, and `TasksListErrorState` based
  Future<void> getTasksList(
      GetTasksListEvent event, Emitter<APIListState> emit) async {
    try {
      emit(const LoadingState('Loading'));
      tasksList = await getTasksUsescase(NoParams());
      emit(TasksListSuccessState(tasksList));
    } catch (e) {
      emit(const TasksListErrorState(kSomethingWentWrongMessage));
    }
  }
}
