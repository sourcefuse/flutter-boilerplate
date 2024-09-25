import 'package:clean_arch/core/domain/entities/task_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../network/client/home_client.dart';
import 'package:dio/dio.dart';

abstract class HomeRemoteDataSource {
  Future<List<Task>> getTasks();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({
    required this.homeClient,
  });

  HomeClient homeClient;

  @override
  Future<List<Task>> getTasks() async {
    try {
      return await homeClient.getTasks();
    } on DioException catch (_) {
      throw ServerException();
    }
  }
}
