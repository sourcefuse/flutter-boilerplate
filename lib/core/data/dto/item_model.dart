import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

// Data Transmit Object
@JsonSerializable()
class ItemModel extends Equatable {
  final String? id;
  final String? uid;
  final String? title;
  final String? description;
  final bool? isDeleted;
  final DateTime? date;
  final int? priority;

  const ItemModel(
      {this.id,
      this.uid,
      this.title,
      this.description,
      this.isDeleted = false,
      this.date,
      this.priority = 0});

  factory ItemModel.fromJson(Map<String, dynamic> data) =>
      _$ItemModelFromJson(data);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  List<Object?> get props =>
      [id, uid, title, description, isDeleted, date, priority];
}
