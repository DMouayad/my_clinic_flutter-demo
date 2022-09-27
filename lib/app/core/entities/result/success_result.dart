part of result;

///
/// or in case of `void` return type:
///  ```
///  SuccessResult.voidResult()
///  ```
class SuccessResult<V extends Object, E extends NoError> extends Result<V, E> {
  final V value;
  SuccessResult(this.value) : super._();

  /// Indicates a successful execution of a function which has return type of `void`.
  factory SuccessResult.voidResult() => SuccessResult(const VoidValue() as V);

  factory SuccessResult.withJson(String json) {
    return SuccessResult(JsonObjectResult(jsonDecode(json)) as V);
  }

  @override
  Future<Result<U, E>> mapSuccessAsync<U extends Object>(
    Future<U> Function(V value) transform,
  ) async {
    return SuccessResult(await transform(value));
  }

  @override
  Result<U, E> mapSuccess<U extends Object>(U Function(V value) transform) {
    return SuccessResult(transform(value));
  }

  @override
  Result<V, T> mapFailure<T extends BasicError>(T Function(E error) transform) {
    return SuccessResult(value);
  }

  @override
  Future<Result<V, T>> mapFailureAsync<T extends BasicError>(
      Future<T> Function(E error) transform) async {
    return SuccessResult(value);
  }

  @override
  Result<U, E> flatMapSuccess<U extends Object>(
      Result<U, E> Function(V value) transform) {
    return transform(value);
  }

  @override
  Future<Result<U, E>> flatMapSuccessAsync<U extends Object>(
      Future<Result<U, E>> Function(V value) transform) async {
    return await transform(value);
  }

  @override
  Result<V, F> flatFailureSuccess<F extends BasicError>(
      Result<V, F> Function(E error) transform) {
    return SuccessResult(value);
  }

  @override
  Future<Result<V, F>> flatMapFailureAsync<F extends BasicError>(
      Future<Result<V, F>> Function(E error) transform) async {
    return SuccessResult(value);
  }

  @override
  Result<VoidValue, E> mapSuccessToVoid([void Function(V value)? onSuccess]) {
    if (onSuccess != null) {
      onSuccess(value);
    }
    return SuccessResult.voidResult();
  }

  @override
  Result<T, F> flatMap<T extends Object, F extends BasicError>({
    required Result<T, F> Function(V value) onSuccess,
    required Result<T, F> Function(E error) onFailure,
  }) {
    return onSuccess(value);
  }

  @override
  Future<Result<T, F>> flatMapAsync<T extends Object, F extends BasicError>({
    required Future<Result<T, F>> Function(V value) onSuccess,
    required Future<Result<T, F>> Function(E error) onFailure,
  }) async {
    return await onSuccess(value);
  }

  @override
  Result<T, F> map<T extends Object, F extends BasicError>({
    required T Function(V value) onSuccess,
    required F Function(E error) onFailure,
  }) {
    return SuccessResult(onSuccess(value));
  }

  @override
  Future<Result<T, F>> mapAsync<T extends Object, F extends BasicError>({
    required Future<T> Function(V value) onSuccess,
    required Future<F> Function(E error) onFailure,
  }) async {
    return SuccessResult(await onSuccess(value));
  }

  @override
  Result<V, E> fold({
    void Function(V value)? ifSuccess,
    void Function(E error)? ifFailure,
  }) {
    if (ifSuccess != null) {
      ifSuccess(value);
    }
    return SuccessResult(value);
  }

  @override
  Future<Result<V, E>> foldAsync({
    Future<void> Function(V value)? ifSuccess,
    Future<void> Function(E error)? ifFailure,
  }) async {
    if (ifSuccess != null) {
      await ifSuccess(value);
    }
    return SuccessResult(value);
  }

  @override
  T mapTo<T>({
    required T Function(V value) onSuccess,
    required T Function(E error) onFailure,
  }) {
    return onSuccess(value);
  }

  @override
  Future<T> mapToAsync<T>({
    required Future<T> Function(V value) onSuccess,
    required Future<T> Function(E error) onFailure,
  }) async {
    return await onSuccess(value);
  }
}
