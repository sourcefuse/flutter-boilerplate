import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/core/domain/usecases/note_module/get_note_usecase.dart';
import 'package:clean_arch/core/domain/usecases/usecase_contracts.dart';
import 'package:clean_arch/network/entities/base_response.dart';

import 'add_note_usescase_test.mocks.dart';

void main() {
  late GetNotes usecase;
  late MockNoteRepositoryContract mockNoteRepositoryContract;

  setUp(() {
    mockNoteRepositoryContract = MockNoteRepositoryContract();
    usecase = GetNotes(noteRepository: mockNoteRepositoryContract);
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

  final BaseResponse<List<NoteModel>> tBaseResponse = BaseResponse(
    data: [tNoteModel],
    success: true,
  );

  test(
    'should get notes from the repository',
    () async {
      //arrange
      when(mockNoteRepositoryContract.getNotes())
          .thenAnswer((_) async => tBaseResponse);

      //act
      final result = await usecase(NoParams());

      //assert
      expect(
        result,
        tBaseResponse,
      );

      ///here called will verify the number of calls happen on the
      ///method when we shall call the above usecase(NoParams())
      verify(mockNoteRepositoryContract.getNotes()).called(1);
      verifyNoMoreInteractions(mockNoteRepositoryContract);
    },
  );
}
