import 'custom_response.dart';

abstract class UseCase<ResultType, Params> {
  UseCase(this.repository);
  final dynamic repository;

  Future<CustomResponse<ResultType>> call({required Params parameters});
}
