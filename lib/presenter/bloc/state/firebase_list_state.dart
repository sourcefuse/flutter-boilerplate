part of '../provider/firebase_list_bloc.dart';

abstract class FirebaseListState<T> extends Equatable {
  final T data;

  const FirebaseListState(this.data);

  @override
  List<Object?> get props => [data];
}

class ItemListInitialState extends FirebaseListState {
  const ItemListInitialState(super.data);
}

class ItemListLoadingState extends FirebaseListState {
  const ItemListLoadingState(super.data);
}

class ItemListSuccessState extends FirebaseListState {
  const ItemListSuccessState(super.data);
}

class ItemListErrorState extends FirebaseListState {
  const ItemListErrorState(super.data);
}
