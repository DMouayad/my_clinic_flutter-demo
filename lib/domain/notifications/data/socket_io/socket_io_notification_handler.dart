import 'package:clinic_v2/domain/notifications/base/base_notification_handler.dart';
import 'package:get_it/get_it.dart';
import 'package:clinic_v2/app/services/socketio/socketio_provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

abstract class BaseSocketIoNotificationHandler extends BaseNotificationHandler {
  Socket get socket => GetIt.I.get<SocketIoProvider>().socket;

  const BaseSocketIoNotificationHandler();
}
