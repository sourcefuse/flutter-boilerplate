import 'package:clean_arch/core/data/datasource/api_remote_data_source.dart';
import 'package:clean_arch/core/data/repositories/api_repository_impl.dart';
import 'package:clean_arch/core/domain/repositories/api_repository_contract.dart';
import 'package:clean_arch/core/domain/usecases/get_tasks_usescase.dart';
import 'package:clean_arch/network/client/api_client.dart';
import 'package:clean_arch/network/client/rest_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_arch/core/data/datasource/firebase_ds.dart';
import 'package:clean_arch/core/data/repositories/firebase_repository_impl.dart';
import 'package:clean_arch/core/domain/repositories/firebase_repository_contract.dart';
import 'package:clean_arch/core/domain/usecases/add_item_usescase.dart';
import 'package:clean_arch/core/domain/usecases/delete_item_usecase.dart';
import 'package:clean_arch/core/domain/usecases/get_item_usecase.dart';

GetIt sl = GetIt.instance;

Future setUpLocator() async {
  // sl.registerSingleton(FirebaseHelper());
  final fs = FirebaseFirestore.instance;
  sl.registerLazySingleton<FirebaseHelperContract>(
      () => FirebaseHelperImpl(firebaseFirestoreInstance: fs));

  SharedPreferences preferences = await SharedPreferences.getInstance();
  sl.registerSingleton(preferences);

  //API Client
  sl.registerSingleton(ApiClient().dio());
  sl.registerSingleton(RestClient(sl()));
  //DataSource
  sl.registerLazySingleton<APIRemoteDataSource>(
      () => APIRemoteDataSourceImpl(homeClient: sl()));
  //Repositories
  sl.registerLazySingleton<FirebaseRepositoryContract>(
      () => FirebaseRepositoryImpl(firebaseHelper: sl()));
  sl.registerLazySingleton<APIRepositoryContract>(
      () => APIRepositoryImpl(homeRemoteDataSource: sl()));

  //UseCases
  sl.registerLazySingleton(() => GetItemsUseCase(firebaseRepository: sl()));
  sl.registerLazySingleton(() => AddItemUseCase(firebaseRepository: sl()));
  sl.registerLazySingleton(() => DeleteItemUseCase(firebaseRepository: sl()));
  sl.registerLazySingleton(() => GetTasksUsescase(apiRepository: sl()));
}
