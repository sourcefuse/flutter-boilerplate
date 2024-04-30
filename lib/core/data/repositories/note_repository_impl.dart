import 'package:clean_arch/core/data/datasource/firebase_ds.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/core/data/dto/note_request_model.dart';
import 'package:clean_arch/core/domain/repositories/note_repository_contract.dart';
import 'package:clean_arch/network/entities/app_exception.dart';
import 'package:clean_arch/network/entities/base_response.dart';

class NoteRepositoryImpl implements NoteRepositoryContract {
  FirebaseHelperContract firebaseHelper;

  NoteRepositoryImpl({required this.firebaseHelper});

  /// The function `getNotes` retrieves notes from Firebase and returns a `BaseResponse` object,
  /// handling any exceptions with a `ServerConnectionException`.
  ///
  /// Returns:
  ///   The `getNotes` method is returning a `Future<BaseResponse>`. Inside a try-catch block, it is
  /// attempting to await the result of `firebaseHelper.getNotes()`. If successful, the result of
  /// `firebaseHelper.getNotes()` is returned. If an exception is caught during the execution, a
  /// `BaseResponse` object is returned with the exception details wrapped in a
  /// `ServerConnectionException
  @override
  Future<BaseResponse> getNotes() async {
    try {
      return await firebaseHelper.getNotes();
    } catch (e) {
      return BaseResponse(
        exception: ServerConnectionException(e.toString()),
        success: false,
      );
    }
  }

  /// The function `addNote` in Dart language adds a note using a `NoteModel` and handles exceptions by
  /// returning a `BaseResponse`.
  ///
  /// Args:
  ///   noteModel (NoteModel): The `noteModel` parameter in the `addNote` method represents a model that
  /// contains the data of a note to be added. It likely includes information such as the title,
  /// content, timestamp, and any other relevant details of the note. This parameter is used to pass the
  /// note data to the
  ///
  /// Returns:
  ///   A `Future<BaseResponse>` is being returned. The `addNote` method is attempting to add a
  /// `NoteModel` using the `firebaseHelper`, and if successful, it returns the result from
  /// `firebaseHelper.addNote`. If an exception occurs during the process, it catches the exception and
  /// returns a `BaseResponse` object with `success` set to `false` and an `exception`
  @override
  Future<BaseResponse> addNote(NoteModel noteModel) async {
    try {
      return await firebaseHelper.addNote(noteModel);
    } catch (e) {
      return BaseResponse(
        exception: ServerConnectionException(e.toString()),
        success: false,
      );
    }
  }

  /// This function deletes a note using the FirebaseHelper class and returns a BaseResponse indicating
  /// success or failure.
  ///
  /// Args:
  ///   noteRequestModel (NoteRequestModel): The `noteRequestModel` parameter in the `deleteNote` method
  /// is of type `NoteRequestModel`. It is used to provide the necessary information required to delete
  /// a note, such as the unique identifier (`uid`) of the note to be deleted.
  ///
  /// Returns:
  ///   A `Future<BaseResponse>` is being returned. This future will either contain the result of
  /// deleting a note using the `firebaseHelper.deleteNote` method, or a `BaseResponse` object with an
  /// exception if an error occurs during the deletion process.
  @override
  Future<BaseResponse> deleteNote(NoteRequestModel noteRequestModel) async {
    try {
      return await firebaseHelper.deleteNote(noteRequestModel.uid!);
    } catch (e) {
      return BaseResponse(
        exception: ServerConnectionException(e.toString()),
        success: false,
      );
    }
  }

  /// The function `updateNote` in Dart is currently throwing an `UnimplementedError`.
  ///
  /// Args:
  ///   noteRequestModel (NoteRequestModel): The `noteRequestModel` parameter in the `updateNote` method
  /// is of type `NoteRequestModel`. This parameter likely contains the data needed to update a note,
  /// such as the note content, title, or any other relevant information.
  @override
  Future<BaseResponse> updateNote(NoteRequestModel noteRequestModel) {
    throw UnimplementedError();
  }
}
