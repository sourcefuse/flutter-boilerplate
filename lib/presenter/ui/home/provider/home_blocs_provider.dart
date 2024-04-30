import 'package:clean_arch/core/domain/usecases/note_module/delete_note_usecase.dart';
import 'package:clean_arch/core/domain/usecases/note_module/get_note_usecase.dart';
import 'package:clean_arch/core/injector.dart';
import 'package:clean_arch/presenter/bloc/provider/note_list_bloc.dart';

// Singleton Bloc Provider,
// This will help to provide multiple bloc through single instance
class HomeBlocsProvider {
  NoteListBloc? _noteListBloc;
  late GetNotes getNotesUseCaseImpl;
  late DeleteNote deleteNoteUseCaseImpl;

  /// The `HomeBlocsProvider._privateConstructor()` method is a private constructor within the
  /// `HomeBlocsProvider` class in Dart. This constructor is used to initialize the
  /// `deleteNoteUseCaseImpl` property of the `HomeBlocsProvider` class by obtaining an instance of the
  /// `DeleteNote` class using the service locator (`sl`) provided by the `injector.dart` file.
  HomeBlocsProvider._privateConstructor() {
    deleteNoteUseCaseImpl = sl<DeleteNote>();
  }

  /// The line `static final HomeBlocsProvider instance = HomeBlocsProvider._privateConstructor();` in
  /// the Dart code snippet is creating a static instance of the `HomeBlocsProvider` class using the
  /// private constructor `_privateConstructor()`. This is a common implementation of the Singleton
  /// design pattern in Dart.
  static final HomeBlocsProvider instance =
      HomeBlocsProvider._privateConstructor();

  /// This Dart function returns an instance of a specific bloc type, creating a new instance if
  /// specified or returning an existing one.
  ///
  /// Args:
  ///   blocType (dynamic): The `blocType` parameter is used to determine the type of Bloc that needs to
  /// be retrieved. In this code snippet, it is used to check if the Bloc type is `NoteListBloc`.
  ///   newInstance (bool): The `newInstance` parameter in the `getBloc` function is a boolean flag that
  /// indicates whether a new instance of the bloc should be created or not. If `newInstance` is set to
  /// `true`, a new instance of the bloc will be created regardless of whether an existing instance
  /// already exists. If. Defaults to false
  ///
  /// Returns:
  ///   If the `blocType` is `NoteListBloc` and `newInstance` is `true` or `_noteListBloc` is `null`, a
  /// new instance of `NoteListBloc` is being returned with the specified dependencies injected. If
  /// `_noteListBloc` is not `null`, the existing instance of `_noteListBloc` is being returned.
  dynamic getBloc({dynamic blocType, bool newInstance = false}) {
    getNotesUseCaseImpl = sl<GetNotes>();
    if (blocType == NoteListBloc) {
      if (newInstance || _noteListBloc == null) {
        return _noteListBloc = NoteListBloc(
            getNotesUseCase: getNotesUseCaseImpl,
            deleteNoteUseCase: deleteNoteUseCaseImpl);
      }
      if (_noteListBloc != null) {
        return _noteListBloc;
      }
    }
  }

  void dispose() {
    _noteListBloc?.close();
  }
}
