import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CustomError {
  final String message;
  final String? code;

  CustomError({
    this.code,
    required this.message,
  });

  factory CustomError.fromParseError(ParseError parseError) {
    return CustomError(
      code: parseError.code.toString(),
      message: parseError.message,
    );
  }
}

mixin ErrorCodes {
  static String get success => '200';
}
