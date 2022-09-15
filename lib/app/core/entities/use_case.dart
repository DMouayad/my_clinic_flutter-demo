import 'result/result.dart';

abstract class UseCase<ResultType extends Object, Params> {
  const UseCase(this.repository);
  final Object repository;

  Future<Result<ResultType, BasicError>> call({required Params parameters});
}
