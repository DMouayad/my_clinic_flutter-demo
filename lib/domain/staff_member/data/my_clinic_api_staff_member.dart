import 'package:clinic_v2/api/models/api_response_staff_member_data.dart';
import 'package:clinic_v2/utils/enums.dart';
import 'package:clinic_v2/domain/authentication/data/my_clinic_api_user.dart';

import '../../../domain/staff_member/base/base_staff_member.dart';

class ApiStaffMember extends BaseStaffMember<ApiUser> {
  const ApiStaffMember({
    required super.id,
    required super.email,
    required super.userRole,
    required super.createdAt,
    super.user,
  });

  factory ApiStaffMember.fromApiResponse(
    ApiResponseStaffMemberData staffMemberData,
  ) {
    return ApiStaffMember(
      id: staffMemberData.id,
      email: staffMemberData.email,
      createdAt: staffMemberData.createdAt,
      userRole: UserRole.values.byName(staffMemberData.roleSlug),
      user: staffMemberData.userData != null
          ? ApiUser.fromApiResponse(staffMemberData.userData!)
          : null,
    );
  }

  @override
  ApiStaffMember copyWith({
    int? id,
    String? email,
    UserRole? userRole,
    DateTime? createdAt,
    ApiUser? user,
  }) {
    return ApiStaffMember(
      id: id ?? this.id,
      email: email ?? this.email,
      userRole: userRole ?? this.userRole,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }
}
