import 'package:clean_arch/core/domain/entities/task_model.dart';

// Repository Contracts
abstract class APIRepositoryContract {

  Future<List<Task>> getTasks();
}
