import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_request_model.g.dart';

// Data Transmit Object
@JsonSerializable()
class ItemRequestModel extends Equatable {
  final String? uid;

  const ItemRequestModel(this.uid);

  factory ItemRequestModel.fromJson(Map<String, dynamic> data) =>
      _$ItemRequestModelFromJson(data);

  Map<String, dynamic> toJson() => _$ItemRequestModelToJson(this);

  @override
  List<Object?> get props => [uid];
}
