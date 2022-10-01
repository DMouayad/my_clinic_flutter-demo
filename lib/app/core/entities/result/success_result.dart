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
  Future<Result<U, F>> mapSuccessAsync<U extends Object, F extends BasicError>(
    Future<U> Function(V value) transform,
  ) async {
    return SuccessResult(await transform(value));
  }

  @override
  Result<U, F> mapSuccess<U extends Object, F extends BasicError>(
      U Function(V value) transform) {
    return SuccessResult(transform(value));
  }

  @override
  Result<U, F> mapFailure<U extends Object, F extends BasicError>(
      F Function(E error) transform) {
    return SuccessResult(value as U);
  }

  @override
  Future<Result<U, F>> mapFailureAsync<U extends Object, F extends BasicError>(
      Future<F> Function(E error) transform) async {
    return SuccessResult(value as U);
  }

  @override
  Result<U, F> flatMapSuccess<U extends Object, F extends BasicError>(
      Result<U, F> Function(V value) transform) {
    return transform(value);
  }

  @override
  Future<Result<U, F>>
      flatMapSuccessAsync<U extends Object, F extends BasicError>(
    Future<Result<U, F>> Function(V value) transform,
  ) async {
    return await transform(value);
  }

  @override
  Result<U, F> flatMapFailure<U extends Object, F extends BasicError>(
      Result<U, F> Function(E error) transform) {
    return SuccessResult(value as U);
  }

  @override
  Future<Result<U, F>>
      flatMapFailureAsync<U extends Object, F extends BasicError>(
          Future<Result<U, F>> Function(E error) transform) async {
    return SuccessResult(value as U);
  }

  @override
  Result<VoidValue, E> mapSuccessToVoid([void Function(V value)? onSuccess]) {
    if (onSuccess != null) {
      onSuccess(value);
    }
    return SuccessResult.voidResult();
  }

  @override
  Future<Result<VoidValue, E>> mapSuccessToVoidAsync(
      [Future<void> Function(V value)? onSuccess]) async {
    if (onSuccess != null) {
      await onSuccess(value);
    }
    return SuccessResult.voidResult();
  }

  @override
  Result<U, F> flatMap<U extends Object, F extends BasicError>({
    required Result<U, F> Function(V value) onSuccess,
    required Result<U, F> Function(E error) onFailure,
  }) {
    return onSuccess(value);
  }

  @override
  Future<Result<U, F>> flatMapAsync<U extends Object, F extends BasicError>({
    required Future<Result<U, F>> Function(V value) onSuccess,
    required Future<Result<U, F>> Function(E error) onFailure,
  }) async {
    return await onSuccess(value);
  }

  @override
  Result<U, F> map<U extends Object, F extends BasicError>({
    required U Function(V value) onSuccess,
    required F Function(E error) onFailure,
  }) {
    return SuccessResult(onSuccess(value));
  }

  @override
  Future<Result<U, F>> mapAsync<U extends Object, F extends BasicError>({
    required Future<U> Function(V value) onSuccess,
    required Future<F> Function(E error) onFailure,
  }) async {
    return SuccessResult(await onSuccess(value));
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
  U mapTo<U>({
    required U Function(V value) onSuccess,
    required U Function(E error) onFailure,
  }) {
    return onSuccess(value);
  }

  @override
  Future<U> mapToAsync<U>({
    required Future<U> Function(V value) onSuccess,
    required Future<U> Function(E error) onFailure,
  }) async {
    return await onSuccess(value);
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
}
