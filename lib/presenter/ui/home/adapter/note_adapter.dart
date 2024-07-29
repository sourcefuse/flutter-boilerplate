import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/presenter/ui/home/data_model/note_view_model.dart';

abstract class NoteAdapter {
  static NoteViewModel getNoteModelData(NoteModel noteModel) {
    return NoteViewModel(
      id: noteModel.id,
      uid: noteModel.uid,
      title: noteModel.title,
      description: noteModel.description,
    );
  }
}
