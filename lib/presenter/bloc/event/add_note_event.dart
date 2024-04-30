part of '../provider/add_note_bloc.dart';

abstract class AddNoteEvent {}

class AddNoteSubmitEvent extends AddNoteEvent {
  final NoteModel note;

  AddNoteSubmitEvent(this.note);
}
