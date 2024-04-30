import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/core/data/dto/note_request_model.dart';
import 'package:clean_arch/core/domain/usecases/note_module/delete_note_usecase.dart';
import 'package:clean_arch/network/entities/base_response.dart';

import 'add_note_usescase_test.mocks.dart';

void main() {
  late DeleteNote usecase;
  late MockNoteRepositoryContract mockNoteRepositoryContract;

  setUp(() {
    mockNoteRepositoryContract = MockNoteRepositoryContract();
    usecase = DeleteNote(noteRepository: mockNoteRepositoryContract);
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

  final tDeleteNoteRequestModel = NoteRequestModel('testUid');

  final BaseResponse<List<NoteModel>> tBaseResponse = BaseResponse(
    data: [tNoteModel],
    success: true,
  );

  
  test(
    'should get deleted model from the repository',
    () async {
      //arrange
      when(mockNoteRepositoryContract.deleteNote(tDeleteNoteRequestModel))
          .thenAnswer((_) async => tBaseResponse);

      //act
      final result = await usecase(tDeleteNoteRequestModel);

      //assert
      expect(
        result,
        tBaseResponse,
      );

      ///here called will verify the number of calls happen on the
      ///method when we shall call the above usecase(tDeleteNoteRequestModel)
      verify(mockNoteRepositoryContract.deleteNote(tDeleteNoteRequestModel))
          .called(1);
      verifyNoMoreInteractions(mockNoteRepositoryContract);
    },
  );
}
