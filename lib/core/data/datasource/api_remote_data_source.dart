import 'package:clean_arch/core/domain/entities/task_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../network/client/rest_client.dart';
import 'package:dio/dio.dart';

abstract class APIRemoteDataSource {
  Future<List<Task>> getTasks();
}

class APIRemoteDataSourceImpl implements APIRemoteDataSource {
  APIRemoteDataSourceImpl({
    required this.homeClient,
  });

  RestClient homeClient;

  @override
  Future<List<Task>> getTasks() async {
    try {
      return await homeClient.getTasks();
    } on DioException catch (_) {
      throw ServerException();
    }
  }
}
