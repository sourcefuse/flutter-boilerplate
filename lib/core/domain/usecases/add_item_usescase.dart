
import 'package:clean_arch/core/data/dto/item_model.dart';
import 'package:clean_arch/core/domain/repositories/firebase_repository_contract.dart';
import 'package:clean_arch/core/domain/usecases/usecase_contracts.dart';

class AddItemUseCase implements UseCase<void, ItemModel> {
  final FirebaseRepositoryContract firebaseRepository;

  AddItemUseCase({required this.firebaseRepository});

  @override
  Future<void> call(ItemModel itemModel) {
    return firebaseRepository.addItem(itemModel);
  }
}
