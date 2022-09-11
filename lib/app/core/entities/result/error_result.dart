part of result;

/// Used as a return type for an unsuccessful execution of a function.
///
///  contains the `error` which have occurred. The variable `error` must be of the type [BaseError].

class ErrorResult<ErrorType extends BaseError,
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
  T fold<T>(
      {required T Function(NoResult result) ifSuccess,
      required T Function(ErrorType error) ifError}) {
    return ifError(error);
  }

  factory ErrorResult.fromException(Object e) {
    return ErrorResult(BaseError(
      message: e.toString(),
      type: e.runtimeType.toString(),
    ) as ErrorType);
  }
  factory ErrorResult.withMessage(String message) {
    return ErrorResult(
      BaseError(
        message: message,
      ) as ErrorType,
    );
  }
  factory ErrorResult.fromDioError(DioError e) {
    return ErrorResult(
      BaseError(
        message: e.message,
        type: e.type.name,
        description: {'request options': e.requestOptions}.toString(),
      ) as ErrorType,
    );
  }

  factory ErrorResult.cannotConnectToServer() {
    return ErrorResult(
        BaseError(code: ErrorCode.cannotConnectToServer()) as ErrorType);
  }
  factory ErrorResult.noInternetConnection() {
    return ErrorResult(
        BaseError(code: ErrorCode.noConnectionFound()) as ErrorType);
  }
}
