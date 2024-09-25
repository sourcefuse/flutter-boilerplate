part of '../provider/add_item_bloc.dart';

abstract class AddItemEvent {}

class AddItemSubmitEvent extends AddItemEvent {
  final ItemModel item;

  AddItemSubmitEvent(this.item);
}
