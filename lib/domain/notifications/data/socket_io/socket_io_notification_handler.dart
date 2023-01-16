import 'package:clinic_v2/domain/notifications/base/base_notification_handler.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

abstract class BaseSocketIoNotificationHandler extends BaseNotificationHandler {
  final io.Socket socket;
  final String channel;

  const BaseSocketIoNotificationHandler({
    required this.socket,
    required this.channel,
  });
}
