import 'package:clean_arch/core/data/dto/note_request_model.dart';
import 'package:clean_arch/core/domain/repositories/note_repository_contract.dart';
import 'package:clean_arch/core/domain/usecases/usecase_contracts.dart';
import 'package:clean_arch/network/entities/base_response.dart';

class DeleteNote implements UseCase<BaseResponse, NoteRequestModel> {
  final NoteRepositoryContract noteRepository;

  DeleteNote({required this.noteRepository});

  @override
  Future<BaseResponse> call(
      NoteRequestModel noteRequestModel) {
    return noteRepository.deleteNote(noteRequestModel);
  }
}
