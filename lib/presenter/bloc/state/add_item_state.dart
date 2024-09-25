part of '../provider/add_item_bloc.dart';

abstract class AddItemState<T> extends Equatable {
  final T data;

  const AddItemState(this.data);

  @override
  List<Object?> get props => [data];
}

class AddItemInitialState extends AddItemState {
  const AddItemInitialState(super.data);
}

class AddItemLoadingState extends AddItemState {
  const AddItemLoadingState(super.data);
}

class AddItemSuccessState extends AddItemState {
  const AddItemSuccessState(super.data);
}

class AddItemErrorState extends AddItemState {
  const AddItemErrorState(super.data);
}
