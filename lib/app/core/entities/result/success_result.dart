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
  T when<T>({
    required T Function(R result) onSuccess,
    required T Function(E error) onError,
  }) {
    return onSuccess(result);
  }

  @override
  Future<T> whenAsync<T>({
    required Future<T> Function(R result) onSuccess,
    required Future<T> Function(E error) onError,
  }) async {
    return await onSuccess(result);
  }

  @override
  T fold<T>({
    required T Function(R result) ifSuccess,
    required T Function(E error) ifError,
  }) {
    return ifSuccess(result);
  }

  factory SuccessResult.withJsonResult(String json) {
    return SuccessResult(json as R);
  }
}
