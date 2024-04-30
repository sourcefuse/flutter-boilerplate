import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/core/data/dto/note_request_model.dart';
import 'package:clean_arch/network/entities/base_response.dart';

// Repository Contracts
abstract class NoteRepositoryContract {
  Future<BaseResponse> getNotes();

  Future<BaseResponse> addNote(NoteModel noteModel);

  Future<BaseResponse> deleteNote(NoteRequestModel noteRequestModel);

  Future<BaseResponse> updateNote(NoteRequestModel noteRequestModel);
}
