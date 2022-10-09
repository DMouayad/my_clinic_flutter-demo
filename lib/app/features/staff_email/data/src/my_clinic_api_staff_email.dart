import 'package:clinic_v2/api/models/staff_email_response_data.dart';
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

  factory MyClinicApiStaffEmail.fromApiResponse(
    ApiResponseStaffEmailData staffEmailData,
  ) {
    return MyClinicApiStaffEmail(
      id: staffEmailData.id,
      email: staffEmailData.email,
      userRole: UserRole.values.byName(staffEmailData.roleSlug),
      user: staffEmailData.userData != null
          ? MyClinicApiUser.fromApiResponse(staffEmailData.userData!)
          : null,
    );
  }

  @override
  MyClinicApiStaffEmail copyWith(
      {int? id, String? email, UserRole? userRole, MyClinicApiUser? user}) {
    return MyClinicApiStaffEmail(
      id: id ?? this.id,
      email: email ?? this.email,
      userRole: userRole ?? this.userRole,
      user: user ?? this.user,
    );
  }
}
