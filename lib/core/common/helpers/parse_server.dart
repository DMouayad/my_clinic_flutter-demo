import 'dart:async';
import 'dart:io';

import 'package:clinic_v2/core/common/models/custom_response.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:mockito/annotations.dart';

/// A [Parse] server which connects to a 'Back4App' database.
@GenerateMocks([ParseServer])
class ParseServer {
  static const _appID = 'v4pEePO9kYDmIrY5eG5tZV4MvbvuBIjeXl4Ut577';
  static const _serverURL = 'https://parseapi.back4app.com';
  static const _liveQueryUrl = 'wss://clinic.b4a.io';
  static const _clientKey = 'bVQHLTM3Vrmxt8kIdp3vM3KxFsIytLpSP6oqSsOp';

  static bool _serverIsInitialized = false;
  static bool get isInitialized => _serverIsInitialized;

  static Future<CustomResponse<ParseResponse>> init() async {
    try {
      if (await Parse().checkConnectivity() != ParseConnectivityResult.none) {
        Timer(const Duration(seconds: 70), () {
          if (!_serverIsInitialized) {
            throw ParseError(
              message:
                  'Cannot connect to the server, check your internet connection and try again',
            );
          }
        });
        await Parse().initialize(
          _appID,
          _serverURL,
          clientKey: _clientKey,
          liveQueryUrl: _liveQueryUrl,
          debug: true,
          autoSendSessionId: true,
        );
        final parseResponse = await Parse().healthCheck();
        _serverIsInitialized = parseResponse.success;
        return CustomResponse(
          success: parseResponse.success,
          result: parseResponse,
        );
      } else {
        throw const SocketException('No Internet Connection!');
      }
    } on SocketException catch (e) {
      return CustomResponse.internetConnectionError(
        errorMessage:
            'Can not connect to the server, check your internet connection and try again',
      );
    } on ParseError catch (e) {
      return CustomResponse.failure(
        errorMessage: 'An error occurred \n ${e.message}',
      );
    }
    // return false;
  }
}
