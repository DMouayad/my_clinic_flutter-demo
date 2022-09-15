import 'dart:async';

import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/utils/enums.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseCloudFunctionsHelper {
  static Future<Result<VoidResult, BasicError>> addUserEmailAddressByAdmin({
    required String emailAddress,
    required UserRole role,
  }) {
    throw UnimplementedError();
  }

  // static Future<Result<UserRole, BasicError>> getUserRole({
  //   required String emailAddress,
  // }) async {
  //   final ParseCloudFunction function =
  //       ParseCloudFunction('getUserRoleByEmail');
  //   final Map<String, String> params = <String, String>{
  //     'email_address': emailAddress
  //   };
  //   return (await _handleFunctionCall(function, params)).when(
  //     onSuccess: (parseResponse) {
  //       final result = parseResponse.results?.first;
  //       final resultIsARole = UserRole.values.asNameMap().keys.contains(result);
  //       if (resultIsARole) {
  //         return SuccessResult(UserRole.values.byName(result));
  //       } else {
  //         return ErrorResult(RetrievingUserRoleError(result));
  //       }
  //     },
  //     onError: (error) => ErrorResult(error),
  //   );
  // }

  static Future<Result<bool, BasicError>> checkIfEmailAddressIsValid(
      String emailAddress) async {
    final ParseCloudFunction function = ParseCloudFunction('isAUserEmail');
    final Map<String, String> params = <String, String>{
      'email_address': emailAddress
    };
    return (await _handleFunctionCall(function, params)).when(
      onSuccess: (parseResponse) {
        return SuccessResult(parseResponse.results?.first);
      },
      onError: (error) => ErrorResult(error),
    );
  }

  static Future<Result<ParseResponse, BasicError>> _handleFunctionCall(
    ParseCloudFunction function,
    Map<String, dynamic>? params,
  ) async {
    if ((await Parse().checkConnectivity()) != ParseConnectivityResult.none) {
      try {
        final response = await function
            .execute(parameters: params)
            .timeout(const Duration(seconds: 20));
        return SuccessResult(response);
      } on TimeoutException {
        return ErrorResult.cannotConnectToServer();
      } on ParseError catch (e) {
        return ErrorResult.withParseError(e);
      }
    } else {
      return ErrorResult.noInternetConnection();
    }
  }
}
