import 'dart:async';
import 'dart:io';

import 'package:clinic_v2/core/common/models/custom_response.dart';
import 'package:clinic_v2/core/common/utilities/enums.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

/// A [Parse] server which connects to a 'Back4App' database.
class ParseServer {
  static const _appID = 'v4pEePO9kYDmIrY5eG5tZV4MvbvuBIjeXl4Ut577';
  static const _serverURL = 'https://parseapi.back4app.com';
  static const _liveQueryUrl = 'wss://clinic.b4a.io';
  static const _clientKey = 'bVQHLTM3Vrmxt8kIdp3vM3KxFsIytLpSP6oqSsOp';

  static bool _serverIsInitialized = false;
  static bool get isInitialized => _serverIsInitialized;

  static Future<CustomResponse<NoResult>> init() async {
    try {
      final hasInternetConnection =
          (await Parse().checkConnectivity()) != ParseConnectivityResult.none;
      if (hasInternetConnection) {
        // Timer(const Duration(seconds: 60), () {
        //   if (!_serverIsInitialized) {
        //     throw TimeoutException(
        //       'Cannot connect to the server, check your internet connection and try again',
        //     );
        //   }
        // });
        await Parse()
            .initialize(
              _appID,
              _serverURL,
              clientKey: _clientKey,
              liveQueryUrl: _liveQueryUrl,
              debug: true,
              autoSendSessionId: true,
            )
            .timeout(const Duration(seconds: 60));
        final parseHealthCheck = await Parse().healthCheck();
        _serverIsInitialized = parseHealthCheck.success;
        return CustomResponse(
          success: parseHealthCheck.success,
        );
      } else {
        throw const SocketException('No Internet Connection!');
      }
    } on SocketException catch (e) {
      return CustomResponse.internetConnectionError(
          errorMessage: 'No internet connection found!');
    } on ParseError catch (e) {
      return CustomResponse.failure(
        errorMessage: 'An error occurred \n ${e.message}',
      );
    } on TimeoutException catch (e) {
      print('dsds');
      return CustomResponse.failure(
        errorMessage:
            'Cannot connect to the server, check your internet connection and try again',
      );
    } catch (e) {
      print(e);
      return CustomResponse.failure(
        errorMessage: 'An error occurred \n $e',
      );
    }
  }

  static Future<CustomResponse<NoResult>> addUserEmailAddressByAdmin(
      {required String emailAddress, required UserRole role}) {
    throw UnimplementedError();
  }

  static Future<CustomResponse<UserRole>> getUserRole(
      {required String emailAddress}) async {
    final ParseCloudFunction function =
        ParseCloudFunction('getUserRoleByEmail');
    final Map<String, String> params = <String, String>{
      'email_address': emailAddress
    };

    final response = await function.execute(parameters: params);
    if (response.success) {
      return CustomResponse.success(
          result: UserRole.values.byName(response.result as String));
    } else {
      return CustomResponse.failure(errorMessage: response.error!.message);
    }
  }

  static Future<CustomResponse<bool>> checkIfValidEmailAddress(
      String emailAddress) async {
    final ParseCloudFunction function = ParseCloudFunction('isAUserEmail');
    final Map<String, String> params = <String, String>{
      'email_address': emailAddress
    };
    final response = await function.execute(parameters: params);
    return CustomResponse(
      success: response.success,
      result: response.result,
    );
  }
}
