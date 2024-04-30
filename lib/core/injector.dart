import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_arch/core/data/datasource/firebase_ds.dart';
import 'package:clean_arch/core/data/repositories/note_repository_impl.dart';
import 'package:clean_arch/core/domain/repositories/note_repository_contract.dart';
import 'package:clean_arch/core/domain/usecases/note_module/add_note_usescase.dart';
import 'package:clean_arch/core/domain/usecases/note_module/delete_note_usecase.dart';
import 'package:clean_arch/core/domain/usecases/note_module/get_note_usecase.dart';
import 'package:clean_arch/core/domain/usecases/note_module/update_note_usecase.dart';

GetIt sl = GetIt.instance;

Future setUpLocator() async {
  // sl.registerSingleton(FirebaseHelper());
  final fs = FirebaseFirestore.instance;
  sl.registerLazySingleton<FirebaseHelperContract>(() => FirebaseHelperImpl(firebaseFirestoreInstance: fs));


  SharedPreferences preferences = await SharedPreferences.getInstance();
  sl.registerSingleton(preferences);

  //Repositories
  sl.registerLazySingleton<NoteRepositoryContract>(() => NoteRepositoryImpl(firebaseHelper: sl()));

  //UseCases
  sl.registerLazySingleton(() => GetNotes(noteRepository: sl()));
  sl.registerLazySingleton(() => AddNote(noteRepository: sl()));
  sl.registerLazySingleton(() => DeleteNote(noteRepository: sl()));
  sl.registerLazySingleton(() => UpdateNote(noteRepository: sl()));
}
