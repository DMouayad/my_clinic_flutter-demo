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

  Future<Result<U, E>> mapSuccessAsync<U extends Object>(
      Future<U> Function(V value) transform);

  Result<U, E> mapSuccess<U extends Object>(U Function(V value) transform);
  Result<VoidValue, E> mapSuccessToVoid([void Function(V value) onSuccess]);

  Result<V, T> mapFailure<T extends BasicError>(T Function(E error) transform);
  Future<Result<V, T>> mapFailureAsync<T extends BasicError>(
    Future<T> Function(E error) transform,
  );

  Future<Result<U, E>> flatMapSuccessAsync<U extends Object>(
    Future<Result<U, E>> Function(V value) transform,
  );

  Result<U, E> flatMapSuccess<U extends Object>(
      Result<U, E> Function(V value) transform);

  Future<Result<V, F>> flatMapFailureAsync<F extends BasicError>(
      Future<Result<V, F>> Function(E error) transform);

  Result<V, F> flatFailureSuccess<F extends BasicError>(
      Result<V, F> Function(E error) transform);

  ///
  Result<T, F> flatMap<T extends Object, F extends BasicError>({
    required Result<T, F> Function(V value) onSuccess,
    required Result<T, F> Function(E error) onFailure,
  });

  Future<Result<T, F>> flatMapAsync<T extends Object, F extends BasicError>({
    required Future<Result<T, F>> Function(V value) onSuccess,
    required Future<Result<T, F>> Function(E error) onFailure,
  });

  ///
  Result<T, F> map<T extends Object, F extends BasicError>({
    required T Function(V value) onSuccess,
    required F Function(E error) onFailure,
  });

  Future<Result<T, F>> mapAsync<T extends Object, F extends BasicError>({
    required Future<T> Function(V value) onSuccess,
    required Future<F> Function(E error) onFailure,
  });

  T mapTo<T>({
    required T Function(V value) onSuccess,
    required T Function(E error) onFailure,
  });
  Future<T> mapToAsync<T>({
    required Future<T> Function(V value) onSuccess,
    required Future<T> Function(E error) onFailure,
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
