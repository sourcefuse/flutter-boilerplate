import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_arch/core/data/datasource/firebase_ds.dart';
import 'package:clean_arch/core/data/dto/item_model.dart';
import 'package:clean_arch/core/data/dto/item_request_model.dart';
import 'package:clean_arch/core/data/repositories/firebase_repository_impl.dart';
import 'package:clean_arch/network/entities/app_exception.dart';

import 'firebase_repository_impl_test.mocks.dart';

@GenerateMocks([FirebaseHelperContract])
void main() {
  late MockFirebaseHelperContract mockFirebaseHelper;
  late FirebaseRepositoryImpl repository;

  setUp(() {
    mockFirebaseHelper = MockFirebaseHelperContract();
    repository = FirebaseRepositoryImpl(firebaseHelper: mockFirebaseHelper);
  });

  final tNoteModel = ItemModel(
    description: 'testD',
    id: 'testId',
    isDeleted: false,
    priority: 1,
    title: 'testTitle',
    uid: 'testUid',
    date: DateTime.now(),
  );

  const tDeleteNoteRequestModel = ItemRequestModel('testUid');

  const tTestUid = 'testUid';

  final tResponse = [tNoteModel];

  const tExceptionBaseResponse =
      ServerConnectionException('Some thing went wrong!');

  group('check repo call for getNotes', () {
    test('should return a firebase data when getNote is called', () async {
      //arrange
      when(mockFirebaseHelper.getItems())
          .thenAnswer((realInvocation) async => tResponse);

      //act
      final result = await repository.getItems();

      //assert
      verify(mockFirebaseHelper.getItems()).called(1);
      expect(result, tResponse);
    });

    test('should return an exception when firebase call goes unsuccessful',
        () async {
      //arrange
      when(mockFirebaseHelper.getItems()).thenThrow('Some thing went wrong!');

      //act
      final result = await repository.getItems();

      //assert
      verify(mockFirebaseHelper.getItems()).called(1);
      expect(result, tExceptionBaseResponse);
    });
  });

  group('check repo call for addNotes', () {
    test(
      'should call addItem on the repository',
      () async {
        // Arrange
        when(mockFirebaseHelper.addItem(tNoteModel))
            .thenAnswer((_) async => Future.value());

        // Act
        await repository.addItem(tNoteModel);

        // Assert
        verify(mockFirebaseHelper.addItem(tNoteModel)).called(1);
      },
    );

    test('should return an exception when firebase call goes unsuccessful',
        () async {
      // Arrange
      when(mockFirebaseHelper.addItem(tNoteModel))
          .thenThrow('Some thing went wrong!');

      // Act
      await repository.addItem(tNoteModel);

      // Assert
      verify(mockFirebaseHelper.addItem(tNoteModel)).called(1);
    });
  });

  group('check repo call for deleteNotes', () {
    test('should return a firebase data when deleteNotes is called', () async {
      // Arrange
      when(mockFirebaseHelper.deleteItem(tTestUid))
          .thenAnswer((_) async => Future.value());

      // Act
      await repository.deleteItem(tDeleteNoteRequestModel);

      // Assert
      verify(mockFirebaseHelper.deleteItem(tTestUid)).called(1);
    });

    test('should return an exception when firebase call goes unsuccessful',
        () async {
      //arrange
      when(mockFirebaseHelper.deleteItem(tTestUid))
          .thenThrow('Some thing went wrong!');

      // Act
      await repository.deleteItem(tDeleteNoteRequestModel);

      // Assert
      verify(mockFirebaseHelper.deleteItem(tTestUid)).called(1);
    });
  });
}
