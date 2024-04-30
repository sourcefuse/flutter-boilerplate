import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_arch/core/data/datasource/firebase_ds.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/core/data/dto/note_request_model.dart';
import 'package:clean_arch/core/data/repositories/note_repository_impl.dart';
import 'package:clean_arch/network/entities/app_exception.dart';
import 'package:clean_arch/network/entities/base_response.dart';

import 'note_repository_impl_test.mocks.dart';

@GenerateMocks([FirebaseHelperContract])
void main() {
  late MockFirebaseHelperContract mockFirebaseHelper;
  late NoteRepositoryImpl repository;

  setUp(() {
    mockFirebaseHelper = MockFirebaseHelperContract();
    repository = NoteRepositoryImpl(firebaseHelper: mockFirebaseHelper);
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


  const tTestUid = 'testUid';

  final tResponse = BaseResponse(
    data: [tNoteModel],
    success: true,
  );

  const tExceptionBaseResponse = BaseResponse(
    exception: ServerConnectionException('Some thing went wrong!'),
    success: false,
  );

  group('check repo call for getNotes', () {
    test('should return a firebase data when getNote is called', () async {
      //arrange
      when(mockFirebaseHelper.getNotes())
          .thenAnswer((realInvocation) async => tResponse);

      //act
      final result = await repository.getNotes();

      //assert
      verify(mockFirebaseHelper.getNotes()).called(1);
      expect(result, tResponse);
    });

    test('should return an exception when firebase call goes unsuccessful', () async {
      //arrange
      when(mockFirebaseHelper.getNotes()).thenThrow('Some thing went wrong!');

      //act
      final result = await repository.getNotes();

      //assert
      verify(mockFirebaseHelper.getNotes()).called(1);
      expect(result, tExceptionBaseResponse);
    });
  });

  group('check repo call for addNotes', () {
    test('should return a firebase data when addNotes is called', () async {
      //arrange
      when(mockFirebaseHelper.addNote(tNoteModel))
          .thenAnswer((realInvocation) async => tResponse);

      //act
      final result = await repository.addNote(tNoteModel);

      //assert
      verify(mockFirebaseHelper.addNote(tNoteModel)).called(1);
      expect(result, tResponse);
    });

    test('should return an exception when firebase call goes unsuccessful', () async {
      //arrange
      when(mockFirebaseHelper.addNote(tNoteModel)).thenThrow('Some thing went wrong!');

      //act
      final result = await repository.addNote(tNoteModel);

      //assert
      verify(mockFirebaseHelper.addNote(tNoteModel)).called(1);
      expect(result, tExceptionBaseResponse);
    });
  });


  group('check repo call for deleteNotes', () {
    test('should return a firebase data when deleteNotes is called', () async {
      //arrange
      when(mockFirebaseHelper.deleteNote(tTestUid))
          .thenAnswer((realInvocation) async => tResponse);

      //act
      final result = await repository.deleteNote(tDeleteNoteRequestModel);

      //assert
      verify(mockFirebaseHelper.deleteNote(tTestUid)).called(1);
      expect(result, tResponse);
    });

    test('should return an exception when firebase call goes unsuccessful', () async {
      //arrange
      when(mockFirebaseHelper.deleteNote(tTestUid)).thenThrow('Some thing went wrong!');

      //act
      final result = await repository.deleteNote(tDeleteNoteRequestModel);

      //assert
      verify(mockFirebaseHelper.deleteNote(tTestUid)).called(1);
      expect(result, tExceptionBaseResponse);
    });
  });

  // group('check repo call for updateNotes', () {
  //   test('should return a firebase data when deleteNotes is called', () async {
  //     //arrange
  //     when(mockFirebaseHelper.updateNote(tTestUid))
  //         .thenAnswer((realInvocation) async => tResponse);
  //
  //     //act
  //     final result = await repository.updateNote(tUpdateNoteRequestModel);
  //
  //     //assert
  //     verify(mockFirebaseHelper.updateNote(tTestUid)).called(1);
  //     expect(result, tResponse);
  //   });
  //
  //   test('should return an exception when firebase call goes unsuccessful', () async {
  //     //arrange
  //     when(mockFirebaseHelper.updateNote(tTestUid)).thenThrow('Some thing went wrong!');
  //
  //     //act
  //     final result = await repository.updateNote(tUpdateNoteRequestModel);
  //
  //     //assert
  //     verify(mockFirebaseHelper.updateNote(tTestUid)).called(1);
  //     expect(result, tExceptionBaseResponse);
  //   });
  // });
}
