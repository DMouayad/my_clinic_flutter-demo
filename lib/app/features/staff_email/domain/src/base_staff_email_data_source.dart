import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/staff_email/domain/src/base_staff_email.dart';

abstract class BaseStaffEmailDataSource<T extends BaseStaffEmail> {
  const BaseStaffEmailDataSource();
  Future<Result<VoidValue, BasicError>> addStaffEmail(
    String email,
    UserRole userRole,
  );
  Future<Result<List<T>, BasicError>> fetchStaffEmails();
  Future<Result<VoidValue, BasicError>> updateStaffEmail({
    required int id,
    String? email,
    UserRole? userRole,
  });
  Future<Result<VoidValue, BasicError>> deleteStaffEmail(int id);
}
