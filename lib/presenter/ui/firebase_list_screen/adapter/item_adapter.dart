import 'package:clean_arch/core/data/dto/item_model.dart';
import 'package:clean_arch/presenter/ui/firebase_list_screen/data_model/item_view_model.dart';

abstract class ItemAdapter {
  static ItemViewModel getItemModelData(ItemModel itemModel) {
    return ItemViewModel(
      id: itemModel.id,
      uid: itemModel.uid,
      title: itemModel.title,
      description: itemModel.description,
    );
  }
}
