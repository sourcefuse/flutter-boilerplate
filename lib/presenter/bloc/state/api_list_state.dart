part of '../provider/api_list_bloc.dart';

abstract class APIListState<T> extends Equatable {
  final T data;

  const APIListState(this.data);

  @override
  List<Object?> get props => [data];
}

class InitialState extends APIListState {
  const InitialState(super.data);
}

class LoadingState extends APIListState {
  const LoadingState(super.data);
}

class TasksListSuccessState extends APIListState {
  const TasksListSuccessState(super.data);
}

class TasksListErrorState extends APIListState {
  const TasksListErrorState(super.data);
}
