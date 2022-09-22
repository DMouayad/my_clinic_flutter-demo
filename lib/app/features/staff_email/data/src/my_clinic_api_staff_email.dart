import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/authentication/data/auth_data.dart';
import 'package:clinic_v2/app/features/staff_email/domain/src/base_staff_email.dart';

class MyClinicApiStaffEmail extends BaseStaffEmail<MyClinicApiUser> {
  MyClinicApiStaffEmail({
    required super.id,
    required super.email,
    required super.userRole,
    super.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'role': userRole.name,
      'user': user?.toMap(),
    };
  }

  factory MyClinicApiStaffEmail.fromMap(Map<String, dynamic> map) {
    return MyClinicApiStaffEmail(
      id: map['id'],
      email: map['email'],
      userRole: UserRole.values.byName(map['role']),
      user: MyClinicApiUser.fromStaffEmailMap(map['user'], map['role']),
    );
  }
}
