import 'package:clean_arch/core/data/datasource/home_remote_data_source.dart';
import 'package:clean_arch/core/domain/repositories/api_repository_contract.dart';

import '../../domain/entities/task_model.dart';

class APIRepositoryImpl implements APIRepositoryContract {

  HomeRemoteDataSource homeRemoteDataSource;

  APIRepositoryImpl(
      {required this.homeRemoteDataSource});

  @override
  Future<List<Task>> getTasks() {
    return homeRemoteDataSource.getTasks();
  }
}
