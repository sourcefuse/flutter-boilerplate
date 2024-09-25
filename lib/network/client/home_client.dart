// ignore_for_file: unused_import

import 'package:clean_arch/core/domain/entities/task_model.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'home_client.g.dart';

@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class HomeClient {
  factory HomeClient(Dio dio) = _HomeClient;

  @GET('tasks')
  Future<List<Task>> getTasks();
}
