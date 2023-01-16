import 'package:clinic_v2/shared/models/paginated_api_resource/paginated_api_resource.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/utils/enums.dart';

import '../../../domain/staff_member/base/base_staff_member.dart';

abstract class BaseStaffMemberDataSource<T extends BaseStaffMember> {
  const BaseStaffMemberDataSource();
  Future<Result<T, BasicError>> addStaffMember(
    String email,
    UserRole userRole,
  );
  Future<Result<PaginatedResource<T>, BasicError>> fetchStaffMembers({
    int? page,
    int? perPage,
    List<String>? sortedBy,
  });
  Future<Result<VoidValue, BasicError>> updateStaffMember(
    int id, [
    String? email,
    UserRole? userRole,
  ]);
  Future<Result<VoidValue, BasicError>> deleteStaffMember(int id);
}
