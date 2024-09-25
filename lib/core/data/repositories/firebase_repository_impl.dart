import 'package:clean_arch/core/data/datasource/firebase_ds.dart';
import 'package:clean_arch/core/data/dto/item_model.dart';
import 'package:clean_arch/core/data/dto/item_request_model.dart';
import 'package:clean_arch/core/domain/repositories/firebase_repository_contract.dart';

class FirebaseRepositoryImpl implements FirebaseRepositoryContract {
  FirebaseHelperContract firebaseHelper;

  FirebaseRepositoryImpl({required this.firebaseHelper});

  /// The function `getItems` retrieves items from Firebase and returns a `void` object,
  /// handling any exceptions with a `ServerConnectionException`.
  ///
  /// Returns:
  ///   The `getItems` method is returning a `Future<List<ItemModel>>`. Inside a try-catch block, it is
  /// attempting to await the result of `firebaseHelper.getItems()`. If successful, the result of
  /// `firebaseHelper.getItems()` is returned. If an exception is caught during the execution, a
  /// `void` object is returned with the exception details wrapped in a
  /// `ServerConnectionException
  @override
  Future<List<ItemModel>> getItems() async {
    try {
      return await firebaseHelper.getItems();
    } catch (e) {
      rethrow;
    }
  }

  /// The function `addItem` in Dart language adds a item using a `ItemModel` and handles exceptions by
  /// returning a `void`.
  ///
  /// Args:
  ///   itemModel (ItemModel): The `itemModel` parameter in the `addItem` method represents a model that
  /// contains the data of a item to be added. It likely includes information such as the title,
  /// content, timestamp, and any other relevant details of the item. This parameter is used to pass the
  /// item data to the
  ///
  /// Returns:
  ///   A `Future<void>` is being returned. The `addItem` method is attempting to add a
  /// `ItemModel` using the `firebaseHelper`, and if successful, it returns the result from
  /// `firebaseHelper.addItem`. If an exception occurs during the process, it catches the exception and
  /// returns a `void` object with `success` set to `false` and an `exception`
  @override
  Future<void> addItem(ItemModel itemModel) async {
    try {
      return await firebaseHelper.addItem(itemModel);
    } catch (e) {
      rethrow;
    }
  }

  /// This function deletes a item using the FirebaseHelper class and returns a void indicating
  /// success or failure.
  ///
  /// Args:
  ///   itemRequestModel (ItemRequestModel): The `itemRequestModel` parameter in the `deleteItem` method
  /// is of type `ItemRequestModel`. It is used to provide the necessary information required to delete
  /// a item, such as the unique identifier (`uid`) of the item to be deleted.
  ///
  /// Returns:
  ///   A `Future<void>` is being returned. This future will either contain the result of
  /// deleting a item using the `firebaseHelper.deleteItem` method, or a `void` object with an
  /// exception if an error occurs during the deletion process.
  @override
  Future<void> deleteItem(ItemRequestModel itemRequestModel) async {
    try {
      return await firebaseHelper.deleteItem(itemRequestModel.uid!);
    } catch (e) {
      rethrow;
    }
  }

  /// The function `updateItem` in Dart is currently throwing an `UnimplementedError`.
  ///
  /// Args:
  ///   itemRequestModel (ItemRequestModel): The `itemRequestModel` parameter in the `updateItem` method
  /// is of type `ItemRequestModel`. This parameter likely contains the data needed to update a item,
  /// such as the item content, title, or any other relevant information.
  @override
  Future<void> updateItem(ItemRequestModel itemRequestModel) {
    throw UnimplementedError();
  }
}
