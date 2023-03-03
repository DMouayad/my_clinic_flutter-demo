import 'package:clinic_v2/domain/authentication/base/base_server_user.dart';
import 'package:clinic_v2/shared/models/result/result.dart';

class MockAsyncResult<T> {
  final Duration returnAfter;
  final Result<T, AppError> result;

  const MockAsyncResult({
    required this.result,
    this.returnAfter = Duration.zero,
  });
}

class AuthRepoMockAsyncResult<T> extends MockAsyncResult<T> {
  final BaseServerUser? userAfterExecution;

  AuthRepoMockAsyncResult({
    required super.result,
    super.returnAfter,
    this.userAfterExecution,
  });

  MockAsyncResult<H> toRegular<H extends BaseServerUser?>() {
    return MockAsyncResult(
      result: result.mapSuccess(
        (value) => userAfterExecution as H,
      ),
      returnAfter: returnAfter,
    );
  }
}
