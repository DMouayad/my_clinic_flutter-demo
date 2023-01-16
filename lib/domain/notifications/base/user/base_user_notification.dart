import '../base_notification.dart';

abstract class BaseUserNotification extends BaseNotification {
  const BaseUserNotification({required this.userId});
  final int userId;
}
