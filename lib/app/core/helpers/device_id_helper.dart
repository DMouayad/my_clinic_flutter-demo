import 'package:platform_device_id/platform_device_id.dart';

mixin DeviceIdHelper {
  static Future<String> get get async {
    return (await PlatformDeviceId.getDeviceId)!;
  }
}
