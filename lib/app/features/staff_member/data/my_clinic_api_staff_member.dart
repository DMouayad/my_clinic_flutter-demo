import 'package:clinic_v2/api/models/api_response_staff_member_data.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/authentication/data/auth_data.dart';

import '../domain/base_staff_member.dart';

class MyClinicApiStaffMember extends BaseStaffMember<MyClinicApiUser> {
  const MyClinicApiStaffMember({
    required super.id,
    required super.email,
    required super.userRole,
    super.user,
  });

  factory MyClinicApiStaffMember.fromApiResponse(
    ApiResponseStaffMemberData staffMemberData,
  ) {
    return MyClinicApiStaffMember(
      id: staffMemberData.id,
      email: staffMemberData.email,
      userRole: UserRole.values.byName(staffMemberData.roleSlug),
      user: staffMemberData.userData != null
          ? MyClinicApiUser.fromApiResponse(staffMemberData.userData!)
          : null,
    );
  }

  @override
  MyClinicApiStaffMember copyWith({
    int? id,
    String? email,
    UserRole? userRole,
    MyClinicApiUser? user,
  }) {
    return MyClinicApiStaffMember(
      id: id ?? this.id,
      email: email ?? this.email,
      userRole: userRole ?? this.userRole,
      user: user ?? this.user,
    );
  }
}
