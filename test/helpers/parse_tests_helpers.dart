import 'package:flutter_test/flutter_test.dart';
//
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:mockito/mockito.dart';
//

class HTTPClientMock extends Mock implements ParseHTTPClient {}

class ParseConnectivityProviderMock implements ParseConnectivityProvider {
  @override
  Future<ParseConnectivityResult> checkConnectivity() async {
    return ParseConnectivityResult.wifi;
  }

  @override
  Stream<ParseConnectivityResult> get connectivityStream {
    return Stream.value(ParseConnectivityResult.wifi);
  }
}

Future<void> initializeParseForTest() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize(
    'appId',
    'serverUrl',
    debug: true,
    connectivityProvider: ParseConnectivityProviderMock(),
    // [appPackageName], [appName] and [appVersion] were specified here because of
    // a bug appeared in the [package_info_plus] library - version 1.3.0 -
    // and specifically in the [PackageInfoWindows] class.
    // - Note: [Parse] automatically uses [package_info_plus] to set these attributes.
    appPackageName: 'Clinic_v2',
    appName: 'CLINIC',
    appVersion: '1.0',
  );

  // return await Parse().healthCheck(client: HTTPClientMock());
}
