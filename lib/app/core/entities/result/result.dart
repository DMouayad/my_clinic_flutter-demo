library result;

import 'dart:convert';

import 'package:dio/dio.dart';

import 'basic_error.dart';
import 'error_exception.dart';

export 'basic_error.dart';
export 'error_exception.dart';

part 'error_result.dart';
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
/// - [ErrorResult]
///
///  **See also:**
/// * [ErrorCode] to represent a specific error type.
/// * [BasicError] to define a custom error.
abstract class Result<R extends Object, E extends BasicError> {
  const Result._();

  bool get isSuccess => this is SuccessResult;
  bool get isError => this is ErrorResult;

  T fold<T>({
    T Function(R result)? ifSuccess,
    T Function(E error)? ifError,
  });

  Future<T> foldAsync<T>({
    Future<T> Function(R result)? ifSuccess,
    Future<T> Function(E error)? ifError,
  });

  ///
  T when<T>({
    required T Function(R result) onSuccess,
    required T Function(E error) onError,
  });

  ///
  Future<T> whenAsync<T>({
    required Future<T> Function(R result) onSuccess,
    required Future<T> Function(E error) onError,
  });
}

/// Represents [Result] return type.
abstract class ResultType extends Object {
  const ResultType();
}

class VoidResult extends ResultType {}

abstract class ResultNotObtained extends ResultType {}

class JsonObjectResult extends ResultType {
  final Map<String, dynamic> jsonObj;

  const JsonObjectResult(this.jsonObj);
}
