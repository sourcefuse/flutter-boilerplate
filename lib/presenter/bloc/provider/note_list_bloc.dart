import 'package:bloc/bloc.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/core/data/dto/note_request_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clean_arch/common/constants.dart';
import 'package:clean_arch/core/domain/usecases/note_module/delete_note_usecase.dart';
import 'package:clean_arch/core/domain/usecases/note_module/get_note_usecase.dart';
import 'package:clean_arch/core/domain/usecases/usecase_contracts.dart';
import 'package:clean_arch/network/entities/base_response.dart';
import 'package:clean_arch/presenter/ui/home/helper/note_tile_widget.dart';
import 'package:clean_arch/utils/logs_util.dart';

part '../event/note_list_event.dart';
part '../state/note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final GetNotes getNotesUseCase;
  final DeleteNote deleteNoteUseCase;
    List<NoteModel> noteList = [];

/// This code snippet is defining the behavior of the `NoteListBloc` class.
  NoteListBloc({required this.getNotesUseCase, required this.deleteNoteUseCase})
      : super(const NoteListInitialState('')) {
    on<GetNoteListEvent>((event, emit) {
      return getNoteList(event, emit);
    });
    on<AddNewNoteEvent>((event, emit) {
      if (kDebugMode) {
        print('addNewNoteExtension');
      }
      return addNewNoteExtension(event, emit);
    });
    on<DeleteNoteEvent>((event, emit) {
      return deleteNote(event, emit);
    });
  }

/// This Dart function retrieves a list of notes and updates the state accordingly based on the result.
/// 
/// Args:
///   event (GetNoteListEvent): The `event` parameter in the `getNoteList` function is of type
/// `GetNoteListEvent`. It is used to provide any necessary information or context for fetching the note
/// list.
///   emit (Emitter<NoteListState>): The `emit` parameter in the `getNoteList` function is an `Emitter`
/// that is used to emit states to the UI. In this case, it is emitting different states such as
/// `NoteListLoadingState`, `NoteListSuccessState`, and `NoteListErrorState` based on
  Future<void> getNoteList(
      GetNoteListEvent event, Emitter<NoteListState> emit) async {
    try {
      emit(const NoteListLoadingState('Loading'));
      final BaseResponse result = await getNotesUseCase(NoParams());
      if (result.success ?? false) {
        noteList = result.data;
        emit(NoteListSuccessState(noteList));
      } else {
        emit(NoteListErrorState(
            result.exception?.message ?? kSomethingWentWrongMessage));
      }
    } catch (e) {
      emit(const NoteListErrorState(kSomethingWentWrongMessage));
    }
  }

/// The function `addNewNoteExtension` adds a new note to a list, updates the state to indicate loading,
/// and then updates the state to indicate success.
/// 
/// Args:
///   event (AddNewNoteEvent): The `event` parameter in the `addNewNoteExtension` function is of type
/// `AddNewNoteEvent`. It likely contains information about the new note that needs to be added.
///   emit (Emitter<NoteListState>): The `emit` parameter is an `Emitter` object that is used to emit
/// state changes in a Flutter Bloc or Cubit. It allows you to send new states to the Bloc or Cubit,
/// which will then notify the UI to update based on the new state. In the provided code snippet,
  Future<void> addNewNoteExtension(
      AddNewNoteEvent event, Emitter<NoteListState> emit) async {
    //add element in animated list using listKey
    listKey.currentState?.insertItem(noteList.length);
    emit(const NoteListLoadingState('Loading'));
    noteList.add(event.note);
    emit(NoteListSuccessState(noteList));
  }

/// This Dart function deletes a note from a list and updates the state accordingly.
/// 
/// Args:
///   event (DeleteNoteEvent): The `event` parameter in the `deleteNote` function is of type
/// `DeleteNoteEvent`. It is used to pass information related to the note that needs to be deleted, such
/// as the `noteRequestModel` containing the unique identifier (`uid`) of the note to be deleted.
///   emit (Emitter<NoteListState>): The `emit` parameter in the `deleteNote` function is an
/// `Emitter<NoteListState>` type. It is used to emit different states of the note list to notify the UI
/// about the current state of the operation, such as loading, success, or error.
/// 
/// Returns:
///   The `deleteNote` function returns a `Future<void>`.
  Future<void> deleteNote(
      DeleteNoteEvent event, Emitter<NoteListState> emit) async {
    try {
      emit(const NoteListLoadingState('Loading'));
      BaseResponse result = await deleteNoteUseCase(event.noteRequestModel);
      if (result.success ?? false) {
        final index = noteList.indexWhere((element) => element.uid == event.noteRequestModel.uid);
        listKey.currentState?.removeItem(
          index,
              (_, animation) {
            return _slide(animation, NoteTile(note: noteList[index]));
          },
          duration: const Duration(milliseconds: 400),
        );
        noteList.removeAt(index);
        emit(NoteListSuccessState(noteList));
      } else {
        emit(NoteListErrorState(
            result.exception?.message ?? kSomethingWentWrongMessage));
      }
    } catch (e) {
      LogsUtil.getInstance.printLog('Error: ${e.toString()}');
      emit(const NoteListErrorState(kSomethingWentWrongMessage));
    }
  }

/// The `_slide` function creates a SlideTransition widget that animates the position of a child widget
/// using the provided animation.
/// 
/// Args:
///   animation (Animation<double>): The `animation` parameter in the `_slide` function is of type
/// `Animation<double>`. It is used to control the transition animation of the `SlideTransition` widget.
/// The animation parameter is typically provided by an `AnimationController` which manages the
/// animation's progress and status.
///   child (Widget): The `child` parameter in the `_slide` function represents the widget that will be
/// transitioned using the `SlideTransition`. This widget will be animated based on the provided
/// animation parameter, which controls the transition effect.
/// 
/// Returns:
///   A `SlideTransition` widget is being returned. The `SlideTransition` widget is configured with a
/// position animation that moves the child widget from an offset of (-2, 0) to (0, 0) based on the
/// provided animation.
  SlideTransition _slide(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-2, 0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }
}