import 'package:clean_arch/core/data/dto/item_model.dart';
import 'package:clean_arch/core/domain/usecases/add_item_usescase.dart';
import 'package:clean_arch/presenter/bloc/provider/firebase_list_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../event/add_item_event.dart';
part '../state/add_item_state.dart';

/// The `AddItemBloc` class in Dart handles the submission of a new item, updating the item list
/// accordingly, and managing different states during the process.
class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  final FirebaseListBloc itemListBloc;
  final AddItemUseCase addItem;

  /// This code snippet is defining the behavior of the `AddItemBloc` class in Dart. Let's break it down:
  AddItemBloc(this.addItem, this.itemListBloc)
      : super(const AddItemInitialState('')) {
    on<AddItemSubmitEvent>((event, emit) {
      return submitItem(event, emit);
    });
  }

  /// The `submitItem` function in Dart handles the submission of a item, updating the state accordingly
  /// based on the result.
  ///
  /// Args:
  ///   event (AddItemSubmitEvent): The `event` parameter in the `submitItem` function is of type
  /// `AddItemSubmitEvent`. It is used to pass the data related to the item that needs to be added.
  ///   emit (Emitter<AddItemState>): The `emit` parameter in the `submitItem` function is an
  /// `Emitter<AddItemState>` object. This object is used to emit states during the execution of the
  /// function. It allows you to notify the UI or other parts of your application about the current
  /// state of the item submission process.
  Future<void> submitItem(
      AddItemSubmitEvent event, Emitter<AddItemState> emit) async {
    try {
      emit(const AddItemLoadingState('Loading'));
      await addItem(event.item);
      itemListBloc.add(AddNewItemEvent(event.item));
      emit(const AddItemSuccessState(null));
    } catch (e) {
      emit(AddItemErrorState(e.toString()));
    }
  }
}
