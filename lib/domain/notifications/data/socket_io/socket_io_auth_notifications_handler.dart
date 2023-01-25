import '../user/user_was_deleted.dart';
import '../user/user_was_verified_notification.dart';
import 'socket_io_notification_handler.dart';

class SocketIoAuthNotificationHandler extends BaseSocketIoNotificationHandler {
  SocketIoAuthNotificationHandler({required super.channel});

  @override
  void call(notificationsController) {
    socket.on('$channel:email-was-verified', (data) {
      notificationsController.add(UserWasVerifiedNotification.fromMap(data));
    });
    socket.on('$channel:user-was-deleted', (data) {
      notificationsController
          .add(CurrentUserWasDeletedNotification.fromMap(data));
    });
  }

  @override
  void dispose() {
    socket.on('$channel:email-was-verified', (data) {});
    socket.on('$channel:user-was-deleted', (data) {});
  }
}
