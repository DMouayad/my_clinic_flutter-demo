import 'dart:convert';

import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/authentication/domain/auth_domain.dart';

class MyClinicApiUser extends BaseServerUser {
  MyClinicApiUser({
    required String name,
    required String email,
    required UserRole role,
  }) : super(name: name, email: email, role: role);

  String toJson() {
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role.name,
    };
  }

  factory MyClinicApiUser.fromJson(String json) {
    return fromMap(jsonDecode(json));
  }

  static MyClinicApiUser fromMap(Map<String, dynamic> map) {
    return MyClinicApiUser(
      name: map['name'],
      email: map['email'],
      role: UserRole.values.byName(map['role']),
    );
  }
}
