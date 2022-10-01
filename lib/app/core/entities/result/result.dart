library result;

import 'dart:convert';

import 'package:dio/dio.dart';

import 'basic_error.dart';
import 'error_exception.dart';

export 'basic_error.dart';
export 'error_exception.dart';

part 'failure_result.dart';
part 'success_result.dart';

/// A class Represents the result of the execution of a function
/// either with a success or an error.
/// #### Simple constructors:
/// - Successful: ```
///   SuccessResult(result)
///   ```
/// - Unsuccessful: ```
///   BasicError error)
///   ```
///
/// #### For More Info refer to:
/// - [SuccessResult]
/// - [FailureResult]
///
///  **See also:**
/// * [ErrorCode] to represent a specific error type.
/// * [BasicError] to define a custom error.
abstract class Result<V extends Object, E extends BasicError> {
  const Result._();

  bool get isSuccess => this is SuccessResult;
  bool get isFailure => this is FailureResult;

  Result<V, E> fold({
    void Function(V value)? ifSuccess,
    void Function(E error)? ifFailure,
  });

  Future<Result<V, E>> foldAsync({
    Future<void> Function(V value)? ifSuccess,
    Future<void> Function(E error)? ifFailure,
  });

  Future<Result<U, F>> mapSuccessAsync<U extends Object, F extends BasicError>(
    Future<U> Function(V value) transform,
  );

  Result<U, F> mapSuccess<U extends Object, F extends BasicError>(
    U Function(V value) transform,
  );
  Result<VoidValue, E> mapSuccessToVoid([void Function(V value) onSuccess]);
  Future<Result<VoidValue, E>> mapSuccessToVoidAsync(
      [Future<void> Function(V value) onSuccess]);

  Result<U, F> mapFailure<U extends Object, F extends BasicError>(
      F Function(E error) transform);
  Future<Result<U, F>> mapFailureAsync<U extends Object, F extends BasicError>(
    Future<F> Function(E error) transform,
  );

  Future<Result<U, F>>
      flatMapSuccessAsync<U extends Object, F extends BasicError>(
    Future<Result<U, F>> Function(V value) transform,
  );

  Result<U, F> flatMapSuccess<U extends Object, F extends BasicError>(
      Result<U, F> Function(V value) transform);

  Future<Result<U, F>>
      flatMapFailureAsync<U extends Object, F extends BasicError>(
          Future<Result<U, F>> Function(E error) transform);

  Result<U, F> flatMapFailure<U extends Object, F extends BasicError>(
      Result<U, F> Function(E error) transform);

  ///
  Result<U, F> flatMap<U extends Object, F extends BasicError>({
    required Result<U, F> Function(V value) onSuccess,
    required Result<U, F> Function(E error) onFailure,
  });

  Future<Result<U, F>> flatMapAsync<U extends Object, F extends BasicError>({
    required Future<Result<U, F>> Function(V value) onSuccess,
    required Future<Result<U, F>> Function(E error) onFailure,
  });

  ///
  Result<U, F> map<U extends Object, F extends BasicError>({
    required U Function(V value) onSuccess,
    required F Function(E error) onFailure,
  });

  Future<Result<U, F>> mapAsync<U extends Object, F extends BasicError>({
    required Future<U> Function(V value) onSuccess,
    required Future<F> Function(E error) onFailure,
  });

  U mapTo<U>({
    required U Function(V value) onSuccess,
    required U Function(E error) onFailure,
  });
  Future<U> mapToAsync<U>({
    required Future<U> Function(V value) onSuccess,
    required Future<U> Function(E error) onFailure,
  });
}

class VoidValue extends Object {
  const VoidValue();
}

abstract class NoValueObtained extends Object {}

class JsonObjectResult extends Object {
  final Map<String, dynamic> jsonObj;

  const JsonObjectResult(this.jsonObj);
}
