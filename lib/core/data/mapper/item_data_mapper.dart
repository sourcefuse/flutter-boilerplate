import 'package:clean_arch/core/data/dto/item_model.dart';
import 'package:clean_arch/core/domain/entities/item_entity.dart';

class ItemDataMapper {
  static ItemEntity mapping(ItemModel data) {
    return ItemEntity(
      int.tryParse(data.id ?? ''),
      data.uid,
      data.title,
      data.description,
      data.priority,
      data.date,
      data.isDeleted,
    );
  }
}
