import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/authentication/data/auth_data.dart';
import 'package:clinic_v2/app/features/staff_email/domain/src/base_staff_email.dart';

class MyClinicApiStaffEmail extends BaseStaffEmail<MyClinicApiUser> {
  const MyClinicApiStaffEmail({
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

  factory MyClinicApiStaffEmail.fromApiResponse(Map<String, dynamic> map) {
    final roleSlug = (map['role']['slug']) as String;
    return MyClinicApiStaffEmail(
      id: map['id'],
      email: map['email'],
      userRole: UserRole.values.byName(roleSlug),
      user: MyClinicApiUser.fromStaffEmailMap(map['user'], roleSlug),
    );
  }
}
