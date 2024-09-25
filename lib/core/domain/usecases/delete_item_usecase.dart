import 'package:clean_arch/core/data/dto/item_request_model.dart';
import 'package:clean_arch/core/domain/repositories/firebase_repository_contract.dart';
import 'package:clean_arch/core/domain/usecases/usecase_contracts.dart';

class DeleteItemUseCase implements UseCase<void, ItemRequestModel> {
  final FirebaseRepositoryContract firebaseRepository;

  DeleteItemUseCase({required this.firebaseRepository});

  @override
  Future<void> call(ItemRequestModel itemRequestModel) {
    return firebaseRepository.deleteItem(itemRequestModel);
  }
}
