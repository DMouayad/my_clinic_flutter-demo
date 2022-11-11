import 'package:clinic_v2/app/features/authentication/data/auth_notifications/user_was_deleted.dart';
import 'package:socket_io_client/socket_io_client.dart';
//
import 'package:clinic_v2/app/features/authentication/domain/base_user_notification.dart';
import 'package:clinic_v2/app/services/notifications/socket_io_listener.dart';
import 'package:clinic_v2/app/features/authentication/data/auth_notifications/user_was_verified_notification.dart';

class SocketIoUserNotificationsListener
    extends SocketIoListener<BaseUserNotification> {
  SocketIoUserNotificationsListener(Socket socket) : super(socket);

  @override
  void registerEventsHandlers(Socket socket, String channel) {
    socket.on('$channel:email-was-verified', (data) {
      notificationsController.add(UserWasVerifiedNotification.fromMap(data));
    });
    socket.on('$channel:user-was-deleted', (data) {
      notificationsController.add(CurrentUserWasDeleted.fromMap(data));
    });
  }
}
