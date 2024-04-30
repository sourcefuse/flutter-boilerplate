import 'package:equatable/equatable.dart';

abstract class UseCase<BaseResponse, Params> {
  Future<BaseResponse> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final noParams = NoParams();
