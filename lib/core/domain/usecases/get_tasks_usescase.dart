import 'package:clean_arch/core/domain/entities/task_model.dart';
import 'package:clean_arch/core/domain/repositories/api_repository_contract.dart';
import 'package:clean_arch/core/domain/usecases/usecase_contracts.dart';

class GetTasksUsescase implements UseCase<List<Task>, NoParams> {
  final APIRepositoryContract apiRepository;

  GetTasksUsescase({required this.apiRepository});

  @override
  Future<List<Task>> call(NoParams itemModel) {
    return apiRepository.getTasks();
  }
}
