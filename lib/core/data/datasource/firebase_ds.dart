import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clean_arch/common/constants.dart';
import 'package:clean_arch/core/data/dto/note_model.dart';
import 'package:clean_arch/network/entities/base_response.dart';

import '../../../utils/logger.dart';

abstract class FirebaseHelperContract {

  Future<BaseResponse> addNote(NoteModel noteModel);

  Future<BaseResponse> getNotes();

  Future<BaseResponse> deleteNote(String uid);
}


class FirebaseHelperImpl implements FirebaseHelperContract {

  FirebaseHelperImpl({required this.firebaseFirestoreInstance});
  FirebaseFirestore firebaseFirestoreInstance;

  CollectionReference getNotesCollection() {
    return firebaseFirestoreInstance.collection(kCollectionNotes);
  }

  @override
  Future<BaseResponse> addNote(NoteModel noteModel) async {
    await getNotesCollection().doc(noteModel.uid).set(noteModel.toJson());
    return const BaseResponse(success: true);
  }

  @override
  Future<BaseResponse> getNotes() async {
    List<NoteModel> noteList = [];
    QuerySnapshot ds = await getNotesCollection().get();
    for (var element in ds.docs) {
      NoteModel note =
          NoteModel.fromJson(element.data() as Map<String, dynamic>);
      logger.d(element.data());
      if (note.isDeleted == false) {
        noteList.add(note);
      }
    }
    return BaseResponse(data: noteList, success: true);
  }

  @override
  Future<BaseResponse> deleteNote(String uid) async {
    await firebaseFirestoreInstance.collection("notes").doc(uid).update({"isDeleted": true});
    return const BaseResponse(success: true);
  }
}
