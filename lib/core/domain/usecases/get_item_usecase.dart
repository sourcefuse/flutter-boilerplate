import 'package:clean_arch/core/data/dto/item_model.dart';
import 'package:clean_arch/core/domain/repositories/firebase_repository_contract.dart';
import 'package:clean_arch/core/domain/usecases/usecase_contracts.dart';

class GetItemsUseCase implements UseCase<List<ItemModel>, NoParams> {
  final FirebaseRepositoryContract firebaseRepository;

  GetItemsUseCase({required this.firebaseRepository});

  @override
  Future<List<ItemModel>> call(NoParams params) async {
    return await firebaseRepository.getItems();
  }
}
