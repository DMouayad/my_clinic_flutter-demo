import 'package:clinic_v2/app/core/entities/paginated_data/src/paginated_resource.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/staff_email/domain/src/base_staff_email.dart';

abstract class BaseStaffEmailDataSource<T extends BaseStaffEmail> {
  const BaseStaffEmailDataSource();
  Future<Result<T, BasicError>> addStaffEmail(
    String email,
    UserRole userRole,
  );
  Future<Result<PaginatedResource<T>, BasicError>> fetchStaffEmails(
      [int? page]);
  Future<Result<VoidValue, BasicError>> updateStaffEmail(
    int id, [
    String? email,
    UserRole? userRole,
  ]);
  Future<Result<VoidValue, BasicError>> deleteStaffEmail(int id);
}
