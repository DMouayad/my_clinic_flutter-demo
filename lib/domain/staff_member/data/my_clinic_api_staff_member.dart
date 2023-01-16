import 'package:clinic_v2/api/models/api_response_staff_member_data.dart';
import 'package:clinic_v2/utils/enums.dart';
import 'package:clinic_v2/domain/authentication/data/my_clinic_api_user.dart';

import '../../../domain/staff_member/base/base_staff_member.dart';

class MyClinicApiStaffMember extends BaseStaffMember<MyClinicApiUser> {
  const MyClinicApiStaffMember({
    required super.id,
    required super.email,
    required super.userRole,
    required super.createdAt,
    super.user,
  });

  factory MyClinicApiStaffMember.fromApiResponse(
    ApiResponseStaffMemberData staffMemberData,
  ) {
    return MyClinicApiStaffMember(
      id: staffMemberData.id,
      email: staffMemberData.email,
      createdAt: staffMemberData.createdAt,
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
    DateTime? createdAt,
    MyClinicApiUser? user,
  }) {
    return MyClinicApiStaffMember(
      id: id ?? this.id,
      email: email ?? this.email,
      userRole: userRole ?? this.userRole,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }
}
