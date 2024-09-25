import 'package:json_annotation/json_annotation.dart';
import 'package:clean_arch/core/data/dto/item_model.dart';

part 'item_list_model.g.dart';

@JsonSerializable()
class ItemListModel {
  late final List<ItemModel>? itemList;

  ItemListModel({this.itemList});

  factory ItemListModel.fromJson(Map<String, dynamic> data) =>
      _$ItemListModelFromJson(data);

  Map<String, dynamic> toJson() => _$ItemListModelToJson(this);
}
