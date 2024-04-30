part of '../provider/note_list_bloc.dart';

abstract class NoteListEvent {}

class GetNoteListEvent extends NoteListEvent {}

class AddNewNoteEvent extends NoteListEvent {
  AddNewNoteEvent(this.note);

  final NoteModel note;
}

class DeleteNoteEvent extends NoteListEvent {
  DeleteNoteEvent(this.noteRequestModel);

  final NoteRequestModel noteRequestModel;
}
