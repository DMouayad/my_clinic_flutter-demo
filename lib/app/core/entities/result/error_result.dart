part of result;

/// Used as a return type for an unsuccessful execution of a function.
///
///  contains the `error` which have occurred. The variable `error` must be of the type [BasicError].

class ErrorResult<ErrorType extends BasicError,
    NoResult extends ResultNotObtained> extends Result<NoResult, ErrorType> {
  final ErrorType error;
  ErrorResult(this.error) : super._();

  @override
  T when<T>({
    required T Function(NoResult result) onSuccess,
    required T Function(ErrorType error) onError,
  }) {
    return onError(error);
  }

  @override
  Future<T> whenAsync<T>({
    required Future<T> Function(NoResult result) onSuccess,
    required Future<T> Function(ErrorType error) onError,
  }) async {
    return await onError(error);
  }

  @override
  T fold<T>({
    T Function(NoResult result)? ifSuccess,
    T Function(ErrorType error)? ifError,
  }) {
    return (ifError != null ? ifError(error) : ErrorResult(error)) as T;
  }

  @override
  Future<T> foldAsync<T>({
    Future<T> Function(NoResult result)? ifSuccess,
    Future<T> Function(ErrorType error)? ifError,
  }) async {
    return (ifError != null ? await ifError(error) : ErrorResult(error)) as T;
  }

  factory ErrorResult.fromException(Object e) {
    return ErrorResult(BasicError(
      message: e.toString(),
      exception: ErrorException(e.runtimeType.toString()),
    ) as ErrorType);
  }
  factory ErrorResult.withMessage(String message) {
    return ErrorResult(
      BasicError(message: message) as ErrorType,
    );
  }
  factory ErrorResult.fromDioError(DioError e) {
    return ErrorResult(
      BasicError(
        message: e.message,
        // exception: ErrorException(e.type.name),
        // description: {'request options': e.requestOptions}.toString(),
      ) as ErrorType,
    );
  }
  factory ErrorResult.fromErrorException(ErrorException errorException) {
    return ErrorResult(BasicError(exception: errorException) as ErrorType);
  }
  @override
  String toString() {
    return 'ErrorResult: $error';
  }
}
