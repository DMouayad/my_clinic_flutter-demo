part of auth_data;

class CustomParseUser extends ParseUser
    implements ParseCloneable, BaseServerUser {
  CustomParseUser({
    required this.appUserId,
    required this.role,
    required String username,
    required String emailAddress,
    String? password,
  }) : super(
          username,
          password,
          emailAddress,
        );

  @override
  String appUserId;

  @override
  UserRole role;
  @override
  CustomParseUser clone(map) => CustomParseUser.fromJson(map);
  @override
  Map<String, dynamic> toJson({
    bool full = false,
    bool forApiRQ = false,
    bool allowCustomObjectId = false,
  }) {
    final userJson = super.toJson(
      full: full,
      forApiRQ: forApiRQ,
      allowCustomObjectId: allowCustomObjectId,
    );
    userJson.addAll({
      'role': role.name,
      'app_user_id': appUserId,
      'objectId': objectId,
    });
    return userJson;
  }

  factory CustomParseUser.clone() {
    return CustomParseUser(
      role: UserRole.dentist,
      appUserId: '',
      username: '',
      emailAddress: '',
    );
  }
  factory CustomParseUser.fromJson(Map<String, dynamic> objectData) {
    return CustomParseUser(
      role: UserRole.values.byName(objectData['role']),
      appUserId: objectData['app_user_id'],
      username: objectData['username'],
      emailAddress: objectData['email'],
    )..objectId = objectData['objectId'];
  }

  @override
  String get email => emailAddress!;

  @override
  String get name => username!;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CustomParseUser &&
        objectId == other.objectId &&
        other.appUserId == appUserId &&
        other.name == name &&
        other.email == email &&
        other.role == role;
  }

  @override
  int get hashCode {
    return appUserId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        role.hashCode ^
        objectId.hashCode;
  }
}
