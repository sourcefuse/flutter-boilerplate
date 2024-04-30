part of '../provider/note_list_bloc.dart';

abstract class NoteListState<T> extends Equatable {
  final T data;

  const NoteListState(this.data);

  @override
  List<Object?> get props => [data];
}

class NoteListInitialState extends NoteListState {
  const NoteListInitialState(super.data);
}

class NoteListLoadingState extends NoteListState {
  const NoteListLoadingState(super.data);
}

class NoteListSuccessState extends NoteListState {
  const NoteListSuccessState(super.data);
}

class NoteListErrorState extends NoteListState {
  const NoteListErrorState(super.data);
}
