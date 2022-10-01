part of result;

/// Used as a return type for an unsuccessful execution of a function.
///
///  contains the `error` which have occurred. The variable `error` must be of the type [BasicError].

class FailureResult<NoValue extends NoValueObtained,
    ErrorType extends BasicError> extends Result<NoValue, ErrorType> {
  final ErrorType error;
  FailureResult(this.error) : super._();

  factory FailureResult.fromException(Exception e) {
    return FailureResult(BasicError(
      message: e.toString(),
      exception: ErrorException(e.runtimeType.toString()),
    ) as ErrorType);
  }
  factory FailureResult.withMessage(String message) {
    return FailureResult(
      BasicError(message: message) as ErrorType,
    );
  }
  factory FailureResult.fromDioError(DioError e) {
    return FailureResult(
      BasicError(
        message: e.message,
        // exception: ErrorException(e.type.name),
        // description: {'request options': e.requestOptions}.toString(),
      ) as ErrorType,
    );
  }
  factory FailureResult.fromErrorException(ErrorException errorException) {
    return FailureResult(BasicError(exception: errorException) as ErrorType);
  }
  @override
  String toString() {
    return 'FailureResult: $error';
  }

  @override
  Future<Result<U, F>> mapSuccessAsync<U extends Object, F extends BasicError>(
      Future<U> Function(NoValue value) transform) async {
    return FailureResult(error as F);
  }

  @override
  Result<U, F> mapSuccess<U extends Object, F extends BasicError>(
      U Function(NoValue value) transform) {
    return FailureResult(error as F);
  }

  @override
  Result<U, F> mapFailure<U extends Object, F extends BasicError>(
      F Function(ErrorType error) transform) {
    return FailureResult(transform(error));
  }

  @override
  Future<Result<U, F>> mapFailureAsync<U extends Object, F extends BasicError>(
      Future<F> Function(ErrorType error) transform) async {
    return FailureResult(await transform(error));
  }

  @override
  Result<U, F> flatMapSuccess<U extends Object, F extends BasicError>(
      Result<U, F> Function(NoValue value) transform) {
    return FailureResult(error as F);
  }

  @override
  Future<Result<U, F>>
      flatMapSuccessAsync<U extends Object, F extends BasicError>(
    Future<Result<U, F>> Function(NoValue value) transform,
  ) async {
    return FailureResult(error as F);
  }

  @override
  Result<U, F> flatMapFailure<U extends Object, F extends BasicError>(
    Result<U, F> Function(ErrorType error) transform,
  ) {
    return transform(error);
  }

  @override
  Future<Result<U, F>>
      flatMapFailureAsync<U extends Object, F extends BasicError>(
    Future<Result<U, F>> Function(ErrorType error) transform,
  ) async {
    return await transform(error);
  }

  @override
  Result<VoidValue, ErrorType> mapSuccessToVoid([
    void Function(NoValue value)? onSuccess,
  ]) {
    return FailureResult(error);
  }

  @override
  Future<Result<VoidValue, ErrorType>> mapSuccessToVoidAsync([
    Future<void> Function(NoValue value)? onSuccess,
  ]) async {
    return FailureResult(error);
  }

  @override
  Result<T, F> flatMap<T extends Object, F extends BasicError>({
    required Result<T, F> Function(NoValue value) onSuccess,
    required Result<T, F> Function(ErrorType error) onFailure,
  }) {
    return onFailure(error);
  }

  @override
  Future<Result<T, F>> flatMapAsync<T extends Object, F extends BasicError>({
    required Future<Result<T, F>> Function(NoValue value) onSuccess,
    required Future<Result<T, F>> Function(ErrorType error) onFailure,
  }) async {
    return await onFailure(error);
  }

  @override
  Result<T, F> map<T extends Object, F extends BasicError>({
    required T Function(NoValue value) onSuccess,
    required F Function(ErrorType error) onFailure,
  }) {
    return FailureResult(onFailure(error));
  }

  @override
  Future<Result<T, F>> mapAsync<T extends Object, F extends BasicError>({
    required Future<T> Function(NoValue value) onSuccess,
    required Future<F> Function(ErrorType error) onFailure,
  }) async {
    return FailureResult(await onFailure(error));
  }

  @override
  Result<NoValue, ErrorType> fold({
    void Function(NoValue value)? ifSuccess,
    void Function(ErrorType error)? ifFailure,
  }) {
    if (ifFailure != null) {
      ifFailure(error);
    }
    return FailureResult(error);
  }

  @override
  Future<Result<NoValue, ErrorType>> foldAsync({
    Future<void> Function(NoValue value)? ifSuccess,
    Future<void> Function(ErrorType error)? ifFailure,
  }) async {
    if (ifFailure != null) {
      await ifFailure(error);
    }
    return FailureResult(error);
  }

  @override
  T mapTo<T>({
    required T Function(NoValue value) onSuccess,
    required T Function(ErrorType error) onFailure,
  }) {
    return onFailure(error);
  }

  @override
  Future<T> mapToAsync<T>({
    required Future<T> Function(NoValue value) onSuccess,
    required Future<T> Function(ErrorType error) onFailure,
  }) async {
    return await onFailure(error);
  }
}
