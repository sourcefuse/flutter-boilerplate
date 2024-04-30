import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/core/domain/entities/note_entity.dart';

class NoteDataMapper {
  static NoteEntity mapping(NoteModel data) {
    return NoteEntity(
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
