import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/core/domain/repositories/note_repository_contract.dart';
import 'package:clean_arch/core/domain/usecases/usecase_contracts.dart';
import 'package:clean_arch/network/entities/base_response.dart';

class AddNote implements UseCase<BaseResponse, NoteModel> {
  final NoteRepositoryContract noteRepository;

  AddNote({required this.noteRepository});

  @override
  Future<BaseResponse> call(NoteModel noteModel) {
    return noteRepository.addNote(noteModel);
  }
}
