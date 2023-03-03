import 'package:clinic_v2/domain/notifications/base/base_notification.dart';
import 'package:clinic_v2/domain/notifications/base/base_notification_handler.dart';
import 'package:clinic_v2/domain/notifications/base/base_notifications_listener.dart';
import 'package:clinic_v2/domain/notifications/data/user/user_was_deleted.dart';
import 'package:clinic_v2/domain/notifications/data/user/user_was_verified_notification.dart';
import 'package:clinic_v2/utils/constants/notifications_channels.dart';

import '../base/base_auth_repository.dart';
import 'api_auth_data_source.dart';
import 'my_clinic_api_user.dart';
import 'package:get_it/get_it.dart';

class ApiAuthRepository extends BaseAuthRepository<ApiAuthDataSource, ApiUser> {
  final List<BaseNotificationHandler> notificationsHandlers;

  String? _userAuthNotificationChannel;

  BaseNotificationsListener get userNotificationsListener =>
      GetIt.I.get<BaseNotificationsListener>();

  ApiAuthRepository(
    super.dataSource, {
    required this.notificationsHandlers,
  }) {
    userNotificationsListener.ensureInitialized();
    userNotificationsListener.notifications.listen(_onUserNotification);

    void unRegisterPreviousUserNotificationHandlers() {
      if (_userAuthNotificationChannel != null) {
        userNotificationsListener.unRegisterHandlers(
          notificationsHandlers,
          _userAuthNotificationChannel!,
        );
      }
      _userAuthNotificationChannel = null;
    }

    void onUserStreamData(ApiUser? user) {
      currentUser = user;
      if (user != null) {
        _userAuthNotificationChannel =
            NotificationsChannels.usersChannel + user.id.toString();

        print("Connecting to user channel $_userAuthNotificationChannel");
        userNotificationsListener
            .listenOnChannel(_userAuthNotificationChannel!);
        userNotificationsListener.registerHandlers(
          notificationsHandlers,
          _userAuthNotificationChannel!,
        );
      } else {
        unRegisterPreviousUserNotificationHandlers();
      }
    }

    usersStream.listen(onUserStreamData);
  }

  /// handles coming notifications(events) from server
  void _onUserNotification(BaseNotification notification) {
    if (notification is UserWasVerifiedNotification) {
      if (currentUser != null && currentUser!.id == notification.userId) {
        currentUser =
            currentUser!.copyWith(emailVerifiedAt: notification.verifiedAt);

        usersStreamController.add(currentUser);
      }
    } else if (notification is CurrentUserWasDeletedNotification) {
      usersStreamController.add(null);
    }
  }
}
