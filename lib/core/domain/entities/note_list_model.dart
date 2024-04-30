import 'package:json_annotation/json_annotation.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';

part 'note_list_model.g.dart';

@JsonSerializable()
class NoteListModel {
  late final List<NoteModel>? noteList;

  NoteListModel({this.noteList});

  factory NoteListModel.fromJson(Map<String, dynamic> data) =>
      _$NoteListModelFromJson(data);

  Map<String, dynamic> toJson() => _$NoteListModelToJson(this);
}
