import 'package:clinic_v2/app/core/extensions/map_extensions.dart';
import 'package:clinic_v2/app/features/authentication/domain/base_user_notification.dart';

class CurrentUserWasDeleted extends BaseUserNotification {
  final int userId;
  final DateTime? deletedAt;
  const CurrentUserWasDeleted({required this.userId, required this.deletedAt});

  factory CurrentUserWasDeleted.fromMap(Map<String, dynamic> map) {
    return CurrentUserWasDeleted(
      userId: map['user_id'] as int,
      deletedAt: DateTime.tryParse(map.get('deleted_at')),
    );
  }
}
