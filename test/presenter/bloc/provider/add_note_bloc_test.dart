import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_arch/common/constants.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/core/domain/usecases/note_module/add_note_usescase.dart';
import 'package:clean_arch/network/entities/base_response.dart';
import 'package:clean_arch/presenter/bloc/provider/add_note_bloc.dart';
import 'package:clean_arch/presenter/bloc/provider/note_list_bloc.dart';

import 'add_note_bloc_test.mocks.dart';

@GenerateMocks([NoteListBloc, AddNote])
void main() {
  late AddNoteBloc addNoteBloc;
  late MockNoteListBloc mockNoteListBloc;
  late MockAddNote mockAddNote;

  setUp(() {
    mockNoteListBloc = MockNoteListBloc();
    mockAddNote = MockAddNote();
    addNoteBloc = AddNoteBloc(mockAddNote, mockNoteListBloc);
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
    const AddNoteLoadingState('Loading'),
    const AddNoteSuccessState(null),
  ];

  final expectedError = [
    const AddNoteLoadingState('Loading'),
    const AddNoteErrorState(kSomethingWentWrongMessage),
  ];

  blocTest(
    'emits Success state when AddNoteSubmit event is added',
    build: () {
      when(addNoteBloc.addNote(tNoteModel)).thenAnswer((_) async => tResponse);
      return addNoteBloc;
    },
    act: (bloc) => addNoteBloc.add(AddNoteSubmitEvent(tNoteModel)),
    expect: () => expectedSuccess,
  );

  blocTest(
    'emits Error state when AddNoteSubmit event is added',
    build: () {
      when(addNoteBloc.addNote(tNoteModel)).thenAnswer((_) async => tErrorResponse);
      return addNoteBloc;
    },
    act: (bloc) => addNoteBloc.add(AddNoteSubmitEvent(tNoteModel)),
    expect: () => expectedError,
  );


  blocTest(
    'emits Error state when AddNoteSubmit event is added',
    build: () {
      when(addNoteBloc.addNote(tNoteModel)).thenThrow(kSomethingWentWrongMessage);
      return addNoteBloc;
    },
    act: (bloc) => addNoteBloc.add(AddNoteSubmitEvent(tNoteModel)),
    expect: () => expectedError,
  );
}
