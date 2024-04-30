part of '../provider/add_note_bloc.dart';

abstract class AddNoteState<T> extends Equatable {
  final T data;

  const AddNoteState(this.data);

  @override
  List<Object?> get props => [data];
}

class AddNoteInitialState extends AddNoteState {
  const AddNoteInitialState(super.data);
}

class AddNoteLoadingState extends AddNoteState {
  const AddNoteLoadingState(super.data);
}

class AddNoteSuccessState extends AddNoteState {
  const AddNoteSuccessState(super.data);
}

class AddNoteErrorState extends AddNoteState {
  const AddNoteErrorState(super.data);
}
