import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note_request_model.g.dart';

// Data Transmit Object
@JsonSerializable()
class NoteRequestModel extends Equatable{
  final String? uid;

  const NoteRequestModel(this.uid);

  factory NoteRequestModel.fromJson(Map<String, dynamic> data) =>
      _$NoteRequestModelFromJson(data);

  Map<String, dynamic> toJson() => _$NoteRequestModelToJson(this);

  @override
  List<Object?> get props => [uid];
}
