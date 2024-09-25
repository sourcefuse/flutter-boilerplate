part of '../provider/firebase_list_bloc.dart';

abstract class FirebaseListEvent {}

class GetItemListEvent extends FirebaseListEvent {}

class AddNewItemEvent extends FirebaseListEvent {
  AddNewItemEvent(this.item);

  final ItemModel item;
}

class DeleteItemEvent extends FirebaseListEvent {
  DeleteItemEvent(this.itemRequestModel);

  final ItemRequestModel itemRequestModel;
}
