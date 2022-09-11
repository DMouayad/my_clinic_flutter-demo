library result;

import 'package:dio/dio.dart';

import 'base_error.dart';
import 'error_code.dart';

export 'base_error.dart';

part 'error_result.dart';
part 'success_result.dart';

/// A class Represents the result of the execution of a function
/// either with a success or an error.
/// #### Simple constructors:
/// - Successful: ```
///   SuccessResult(result)
///   ```
/// - Unsuccessful: ```
///   BaseError error)
///   ```
///
/// #### For More Info refer to:
/// - [SuccessResult]
/// - [ErrorResult]
///
///  **See also:**
/// * [ErrorCode] to represent a specific error type.
/// * [BaseError] to define a custom error.
abstract class Result<R extends Object, E extends BaseError> {
  const Result._();

  bool get isSuccess => this is SuccessResult;
  bool get isError => this is ErrorResult;

  T fold<T>({
    required T Function(R result) ifSuccess,
    required T Function(E error) ifError,
  });

  ///
  T when<T>({
    required T Function(R result) onSuccess,
    required T Function(BaseError error) onError,
  });

  ///
  Future<T> whenAsync<T>({
    required Future<T> Function(R result) onSuccess,
    required Future<T> Function(BaseError error) onError,
  });
}

/// Represents [Result] return type.
abstract class ResultType extends Object {
  const ResultType();
}

class VoidResult extends ResultType {}

abstract class ResultNotObtained extends ResultType {}

class JsonResult extends ResultType {
  final String json;

  const JsonResult(this.json);
}
