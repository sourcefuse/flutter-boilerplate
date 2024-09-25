import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_arch/core/data/dto/item_model.dart';
import 'package:clean_arch/core/domain/repositories/firebase_repository_contract.dart';
import 'package:clean_arch/core/domain/usecases/add_item_usescase.dart';

import 'add_item_usescase_test.mocks.dart';

@GenerateMocks([FirebaseRepositoryContract])
void main() {
  late AddItemUseCase usecase;
  late MockFirebaseRepositoryContract mockItemRepositoryContract;

  setUp(() {
    mockItemRepositoryContract = MockFirebaseRepositoryContract();
    usecase = AddItemUseCase(firebaseRepository: mockItemRepositoryContract);
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

  test(
    'should call addItem on the repository',
    () async {
      // Arrange
      when(mockItemRepositoryContract.addItem(tNoteModel))
          .thenAnswer((_) async => Future.value());

      // Act
      await usecase(tNoteModel);

      // Assert
      verify(mockItemRepositoryContract.addItem(tNoteModel)).called(1);
    },
  );
}
