import 'package:clinic_v2/app/core/entities/paginated_data/src/paginated_resource.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/enums.dart';

import 'base_staff_member.dart';

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
