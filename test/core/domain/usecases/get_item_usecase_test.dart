import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_arch/core/data/dto/item_model.dart';
import 'package:clean_arch/core/domain/usecases/get_item_usecase.dart';
import 'package:clean_arch/core/domain/usecases/usecase_contracts.dart';

import 'add_item_usescase_test.mocks.dart';


void main() {
  late GetItemsUseCase usecase;
  late MockFirebaseRepositoryContract mockNoteRepositoryContract;

  setUp(() {
    mockNoteRepositoryContract = MockFirebaseRepositoryContract();
    usecase = GetItemsUseCase(firebaseRepository: mockNoteRepositoryContract);
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

  final List<ItemModel> tBaseResponse = [tNoteModel];

  test(
    'should get notes from the repository',
    () async {
      //arrange
      when(mockNoteRepositoryContract.getItems())
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
      verify(mockNoteRepositoryContract.getItems()).called(1);
      verifyNoMoreInteractions(mockNoteRepositoryContract);
    },
  );
}
