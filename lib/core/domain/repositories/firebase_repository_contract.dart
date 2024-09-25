
import 'package:clean_arch/core/data/dto/item_model.dart';
import 'package:clean_arch/core/data/dto/item_request_model.dart';

// Repository Contracts
abstract class FirebaseRepositoryContract {
  Future<List<ItemModel>> getItems();

  Future<void> addItem(ItemModel itemModel);

  Future<void> deleteItem(ItemRequestModel itemRequestModel);

  Future<void> updateItem(ItemRequestModel itemRequestModel);
}
