part of result;

///
/// or in case of `void` return type:
///  ```
///  SuccessResult.voidResult()
///  ```
class SuccessResult<R extends Object, E extends NoError> extends Result<R, E> {
  final R result;
  SuccessResult(this.result) : super._();

  /// Indicates a successful execution of a function which has return type of `void`.
  factory SuccessResult.voidResult() => SuccessResult(VoidResult() as R);

  @override
  T fold<T>({
    T Function(R result)? ifSuccess,
    T Function(E error)? ifError,
  }) {
    return T is VoidResult
        ? SuccessResult.voidResult() as T
        : (ifSuccess != null ? ifSuccess(result) : SuccessResult(result)) as T;
  }

  @override
  Future<T> foldAsync<T>({
    Future<T> Function(R result)? ifSuccess,
    Future<T> Function(E error)? ifError,
  }) async {
    return T is VoidResult
        ? SuccessResult.voidResult() as T
        : (ifSuccess != null ? await ifSuccess(result) : SuccessResult(result))
            as T;
  }

  @override
  Future<T> whenAsync<T>({
    required Future<T> Function(R result) onSuccess,
    required Future<T> Function(E error) onError,
  }) async {
    return await onSuccess(result);
  }

  factory SuccessResult.withJson(String json) {
    return SuccessResult(JsonObjectResult(jsonDecode(json)) as R);
  }

  @override
  T when<T>({
    required T Function(R result) onSuccess,
    required T Function(E error) onError,
  }) {
    return onSuccess(result);
  }
}
