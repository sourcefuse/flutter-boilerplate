import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_arch/core/data/dto/item_request_model.dart';
import 'package:clean_arch/core/domain/usecases/delete_item_usecase.dart';

import 'add_item_usescase_test.mocks.dart';

void main() {
  late DeleteItemUseCase usecase;
  late MockFirebaseRepositoryContract mockItemRepositoryContract;

  setUp(() {
    mockItemRepositoryContract = MockFirebaseRepositoryContract();
    usecase = DeleteItemUseCase(firebaseRepository: mockItemRepositoryContract);
  });

  const tDeleteNoteRequestModel = ItemRequestModel('testUid');

  test(
    'should call addItem on the repository',
    () async {
      // Arrange
      when(mockItemRepositoryContract.deleteItem(tDeleteNoteRequestModel))
          .thenAnswer((_) async => Future.value());

      // Act
      await usecase(tDeleteNoteRequestModel);

      // Assert
      verify(mockItemRepositoryContract.deleteItem(tDeleteNoteRequestModel))
          .called(1);
    },
  );
}
