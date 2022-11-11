import 'package:dio/dio.dart';

class DioErrorFactory {
  late final RequestOptions _requestOptions;
  late final DioErrorType _errorType;
  late final Response? _response;

  DioErrorFactory() {
    _requestOptions = RequestOptions(path: 'https://test');
    _errorType = DioErrorType.other;
    _response = null;
  }

  DioError create() {
    return DioError(
      requestOptions: _requestOptions,
      type: _errorType,
      response: _response,
    );
  }

  DioErrorFactory setupWith({
    RequestOptions? requestOptions,
    DioErrorType? errorType,
    Response? response,
  }) {
    return DioErrorFactory._(
      requestOptions: requestOptions ?? _requestOptions,
      errorType: errorType ?? _errorType,
      response: response ?? _response,
    );
  }

  DioErrorFactory._({
    required RequestOptions requestOptions,
    required DioErrorType errorType,
    required Response? response,
  })  : _requestOptions = requestOptions,
        _errorType = errorType,
        _response = response;
}
