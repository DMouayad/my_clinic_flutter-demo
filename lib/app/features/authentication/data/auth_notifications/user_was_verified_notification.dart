import 'package:clinic_v2/app/features/authentication/domain/base_user_notification.dart';

class UserWasVerifiedNotification extends BaseUserNotification {
  final int userId;
  final DateTime verifiedAt;

  const UserWasVerifiedNotification({
    required this.userId,
    required this.verifiedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'verifiedAt': verifiedAt,
    };
  }

  factory UserWasVerifiedNotification.fromMap(Map<String, dynamic> map) {
    return UserWasVerifiedNotification(
      userId: map['user_id'] as int,
      verifiedAt: DateTime.parse(map['email_verified_at']),
    );
  }
}
