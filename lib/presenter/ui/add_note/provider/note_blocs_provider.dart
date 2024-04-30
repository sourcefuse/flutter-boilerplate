import 'package:clean_arch/core/domain/usecases/note_module/add_note_usescase.dart';
import 'package:clean_arch/core/domain/usecases/note_module/delete_note_usecase.dart';
import 'package:clean_arch/core/domain/usecases/note_module/get_note_usecase.dart';
import 'package:clean_arch/core/injector.dart';
import 'package:clean_arch/presenter/bloc/provider/add_note_bloc.dart';
import 'package:clean_arch/presenter/bloc/provider/note_list_bloc.dart';

import '../../home/provider/home_blocs_provider.dart';

// Singleton Bloc Provider,
// This will help to provide multiple bloc through single instance
class NoteBlocsProvider {
  NoteListBloc? _noteListBloc;
  AddNoteBloc? _addNoteBloc;
  late AddNote addNoteUseCaseImpl;
  late GetNotes getNotesUseCaseImpl;
  late DeleteNote deleteNoteUseCaseImpl;

  NoteBlocsProvider._privateConstructor() {
    addNoteUseCaseImpl = sl<AddNote>();
    getNotesUseCaseImpl = sl<GetNotes>();
    deleteNoteUseCaseImpl = sl<DeleteNote>();
  }

  static final NoteBlocsProvider instance =
      NoteBlocsProvider._privateConstructor();

  dynamic getBloc({dynamic blocType, bool newInstance = false}) {
    if (blocType == AddNoteBloc) {
      if (newInstance || _addNoteBloc == null) {
        _noteListBloc ??=
            HomeBlocsProvider.instance.getBloc(blocType: NoteListBloc);
        return _addNoteBloc = AddNoteBloc(addNoteUseCaseImpl, _noteListBloc!);
      }
      if (_addNoteBloc != null) {
        return _addNoteBloc;
      }
    }
  }

  void dispose() {
    _noteListBloc?.close();
    _addNoteBloc?.close();
    _noteListBloc = null;
    _addNoteBloc = null;
  }
}
