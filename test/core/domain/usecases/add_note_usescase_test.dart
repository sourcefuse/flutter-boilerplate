import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/core/domain/repositories/note_repository_contract.dart';
import 'package:clean_arch/core/domain/usecases/note_module/add_note_usescase.dart';
import 'package:clean_arch/network/entities/base_response.dart';

import 'add_note_usescase_test.mocks.dart';

@GenerateMocks([NoteRepositoryContract])
void main() {
  late AddNote usecase;
  late MockNoteRepositoryContract mockNoteRepositoryContract;

  setUp(() {
    mockNoteRepositoryContract = MockNoteRepositoryContract();
    usecase = AddNote(noteRepository: mockNoteRepositoryContract);
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

  final tResponse = BaseResponse(
    data: [tNoteModel],
    success: true,
  );

  test(
    'should get notes from the repository',
    () async {
      when(mockNoteRepositoryContract.addNote(tNoteModel))
          .thenAnswer((_) async => tResponse);
      //act
      final result = await usecase(tNoteModel);

      //assert
      expect(
        result,
        tResponse,
      );

      ///here called will verify the number of calls happen on the
      ///method when we shall call the above usecase(tNoteModel)
      verify(mockNoteRepositoryContract.addNote(tNoteModel)).called(1);
      verifyNoMoreInteractions(mockNoteRepositoryContract);
    },
  );
}
