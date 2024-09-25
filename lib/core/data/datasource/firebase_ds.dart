import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clean_arch/common/constants.dart';
import 'package:clean_arch/core/data/dto/item_model.dart';

import '../../../utils/logger.dart';

abstract class FirebaseHelperContract {
  Future<void> addItem(ItemModel itemModel);

  Future<List<ItemModel>> getItems();

  Future<void> deleteItem(String uid);
}

class FirebaseHelperImpl implements FirebaseHelperContract {
  FirebaseHelperImpl({required this.firebaseFirestoreInstance});
  FirebaseFirestore firebaseFirestoreInstance;

  CollectionReference getItemsCollection() {
    return firebaseFirestoreInstance.collection(kCollectionItems);
  }

  @override
  Future<void> addItem(ItemModel itemModel) async {
    await getItemsCollection().doc(itemModel.uid).set(itemModel.toJson());
    return;
  }

  @override
  Future<List<ItemModel>> getItems() async {
    List<ItemModel> itemList = [];
    QuerySnapshot ds = await getItemsCollection().get();
    for (var element in ds.docs) {
      ItemModel item =
          ItemModel.fromJson(element.data() as Map<String, dynamic>);
      logger.d(element.data());
      if (item.isDeleted == false) {
        itemList.add(item);
      }
    }
    return itemList;
  }

  @override
  Future<void> deleteItem(String uid) async {
    await firebaseFirestoreInstance
        .collection("notes")
        .doc(uid)
        .update({"isDeleted": true});
    return;
  }
}
