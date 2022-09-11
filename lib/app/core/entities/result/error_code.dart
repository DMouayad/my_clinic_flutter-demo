abstract class ErrorCode {
  const ErrorCode();
  factory ErrorCode.noConnectionFound() = _NoConnectionFoundErrorCode;
  factory ErrorCode.cannotConnectToServer() = _CannotConnectToServerErrorCode;
}

class _NoConnectionFoundErrorCode extends ErrorCode {}

class _CannotConnectToServerErrorCode extends ErrorCode {}
