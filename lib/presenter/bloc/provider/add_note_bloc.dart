import 'package:clean_arch/common/constants.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/core/domain/usecases/note_module/add_note_usescase.dart';
import 'package:clean_arch/network/entities/base_response.dart';
import 'package:clean_arch/presenter/bloc/provider/note_list_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../event/add_note_event.dart';
part '../state/add_note_state.dart';

/// The `AddNoteBloc` class in Dart handles the submission of a new note, updating the note list
/// accordingly, and managing different states during the process.
class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  final NoteListBloc noteListBloc;
  final AddNote addNote;

  /// This code snippet is defining the behavior of the `AddNoteBloc` class in Dart. Let's break it down:
  AddNoteBloc(this.addNote, this.noteListBloc)
      : super(const AddNoteInitialState('')) {
    on<AddNoteSubmitEvent>((event, emit) {
      return submitNote(event, emit);
    });
  }

  /// The `submitNote` function in Dart handles the submission of a note, updating the state accordingly
  /// based on the result.
  ///
  /// Args:
  ///   event (AddNoteSubmitEvent): The `event` parameter in the `submitNote` function is of type
  /// `AddNoteSubmitEvent`. It is used to pass the data related to the note that needs to be added.
  ///   emit (Emitter<AddNoteState>): The `emit` parameter in the `submitNote` function is an
  /// `Emitter<AddNoteState>` object. This object is used to emit states during the execution of the
  /// function. It allows you to notify the UI or other parts of your application about the current
  /// state of the note submission process.
  Future<void> submitNote(
      AddNoteSubmitEvent event, Emitter<AddNoteState> emit) async {
    try {
      emit(const AddNoteLoadingState('Loading'));
      BaseResponse result = await addNote(event.note);
      if (result.success ?? false) {
        noteListBloc.add(AddNewNoteEvent(event.note));
        emit(const AddNoteSuccessState(null));
      } else {
        emit(AddNoteErrorState(
            result.exception?.message ?? kSomethingWentWrongMessage));
      }
    } catch (e) {
      emit(AddNoteErrorState(e.toString()));
    }
  }
}
