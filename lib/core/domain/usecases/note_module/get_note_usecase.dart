import 'package:clean_arch/core/domain/repositories/note_repository_contract.dart';
import 'package:clean_arch/core/domain/usecases/usecase_contracts.dart';
import 'package:clean_arch/network/entities/base_response.dart';

class GetNotes implements UseCase<BaseResponse, NoParams> {
  final NoteRepositoryContract noteRepository;

  GetNotes({required this.noteRepository});

  @override
  Future<BaseResponse> call(NoParams params) async {
    return await noteRepository.getNotes();
  }
}
