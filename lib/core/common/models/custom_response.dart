import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'custom_error.dart';

//TODO: WRITE DOCS
class CustomResponse<T> {
  final bool success;
  final T? result;
  final CustomError? error;

  const CustomResponse({
    required this.success,
    this.result,
    this.error,
  });
  // : assert((success && error == null) || (!success && error != null));

  factory CustomResponse.success({T? result}) {
    return CustomResponse(success: true, result: result);
  }

  factory CustomResponse.failure({
    required String errorMessage,
    String? errorCode,
  }) {
    return CustomResponse(
      success: false,
      error: CustomError(
        message: errorMessage,
        code: errorCode,
      ),
    );
  }

  factory CustomResponse.internetConnectionError({String? errorMessage}) {
    return CustomResponse(
      success: false,
      error: CustomError(
        message: errorMessage ?? 'No internet connection found!',
        code: ErrorCodes.noConnection.name,
      ),
    );
  }
  factory CustomResponse.withNoResult(
      {required bool success, CustomError? error}) {
    assert((success && error == null) || (!success && error != null));
    return CustomResponse(success: success, error: error);
  }

  factory CustomResponse.fromParseResponse(ParseResponse parseResponse,
      {bool withResults = true}) {
    return CustomResponse(
      success: parseResponse.success,
      result: withResults ? parseResponse.results?.first : NoResult(),
      error: parseResponse.error != null
          ? CustomError.fromParseError(parseResponse.error!)
          : null,
    );
  }
}

enum ErrorCodes {
  noConnection,
}

/// - indicates that a [CustomResponse] has no returned result (no return type)
class NoResult {}
