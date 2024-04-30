import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_arch/common/constants.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/core/data/dto/note_request_model.dart';
import 'package:clean_arch/core/domain/usecases/note_module/delete_note_usecase.dart';
import 'package:clean_arch/core/domain/usecases/note_module/get_note_usecase.dart';
import 'package:clean_arch/core/domain/usecases/usecase_contracts.dart';
import 'package:clean_arch/network/entities/base_response.dart';
import 'package:clean_arch/presenter/bloc/provider/note_list_bloc.dart';

import 'note_list_bloc_test.mocks.dart';

@GenerateMocks([GetNotes, DeleteNote])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late NoteListBloc noteListBloc;
  late MockGetNotes mockGetNotes;
  late MockDeleteNote mockDeleteNote;

  setUp(() {
    mockGetNotes = MockGetNotes();
    mockDeleteNote = MockDeleteNote();
    noteListBloc = NoteListBloc(
        getNotesUseCase: mockGetNotes, deleteNoteUseCase: mockDeleteNote);
  });

  final tNoteModel = NoteModel(
    description: 'testD',
    id: 'testId',
    isDeleted: false,
    priority: 1,
    title: 'testTitle',
    uid: 'testUid',
    date: DateTime.now(),
  );

  final tNoteRequestModel = NoteRequestModel('testUid');

  final tNoteList = [tNoteModel];

  final tResponse = BaseResponse(
    data: tNoteList,
    success: true,
  );

  final tErrorResponse = BaseResponse(
    data: tNoteList,
    success: false,
  );

  final expectedSuccess = [
    // const NoteListInitialState(''),
    const NoteListLoadingState('Loading'),
    NoteListSuccessState(tNoteList),
  ];

  final expectedError = [
    // const NoteListInitialState(''),
    const NoteListLoadingState('Loading'),
    const NoteListErrorState(kSomethingWentWrongMessage),
  ];

  // blocTest(
  //   'emits Success state when GetNoteList event is added',
  //   //arrange
  //   build: () {
  //     when(noteListBloc.getNotesUseCase(noParams))
  //         .thenAnswer((_) async => tResponse);
  //     return noteListBloc;
  //   },
  //   //act
  //   act: (bloc) => noteListBloc.add(GetNoteListEvent()),
  //   //assert
  //   expect: () => expectedSuccess,
  // );

  blocTest(
    'emits Error state when GetNoteList event is added',
    build: () {
      when(noteListBloc.getNotesUseCase(noParams))
          .thenAnswer((_) async => tErrorResponse);
      return noteListBloc;
    },
    act: (bloc) => noteListBloc.add(GetNoteListEvent()),
    expect: () => expectedError,
  );

  blocTest(
    'emits Error state when GetNoteList event is added',
    build: () {
      when(noteListBloc.getNotesUseCase(noParams)).thenThrow(kSomethingWentWrongMessage);
      return noteListBloc;
    },
    act: (bloc) => noteListBloc.add(GetNoteListEvent()),
    expect: () => expectedError,
  );

  blocTest(
    'emits Success state when AddNewNote event is added',
    build: () {
      return noteListBloc;
    },
    act: (bloc) => noteListBloc.add(AddNewNoteEvent(tNoteModel)),
    expect: () => expectedSuccess,
  );

  blocTest(
    'emits Success state when DeleteNote event is added',
    build: () {
      when(noteListBloc.deleteNoteUseCase(tNoteRequestModel))
          .thenAnswer((_) async => tResponse);
      // noteListBloc.add(AddNewNoteEvent(tNoteModel));
      noteListBloc.noteList = [tNoteModel];
      return noteListBloc;
    },
    act: (bloc) => noteListBloc.add(DeleteNoteEvent(tNoteRequestModel)),
    expect: () => [
      const NoteListLoadingState('Loading'),
      const NoteListSuccessState([]),
    ],
  );

  blocTest(
    'emits Error state when DeleteNote event is added',
    build: () {
      when(noteListBloc.deleteNoteUseCase(tNoteRequestModel))
          .thenAnswer((_) async => tErrorResponse);
      return noteListBloc;
    },
    act: (bloc) => noteListBloc.add(DeleteNoteEvent(tNoteRequestModel)),
    expect: () => expectedError,
  );

  blocTest(
    'emits Error state when DeleteNote event is added',
    build: () {
      when(noteListBloc.deleteNoteUseCase(tNoteRequestModel))
          .thenThrow('throwable');
      return noteListBloc;
    },
    act: (bloc) => noteListBloc.add(DeleteNoteEvent(tNoteRequestModel)),
    expect: () => expectedError,
  );
}
