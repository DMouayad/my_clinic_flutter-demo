import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/staff_email/domain/src/base_staff_email.dart';

abstract class BaseStaffEmailRepository {
  List<BaseStaffEmail>? get staffEmails;
  Future<Result<VoidValue, BasicError>> addStaffEmail(
      String email, UserRole userRole);
  Future<Result<VoidValue, BasicError>> getStaffEmails();
  Future<Result<VoidValue, BasicError>> updateStaffEmail(
      {required int id, String? email, UserRole? userRole});
  Future<Result<VoidValue, BasicError>> deleteStaffEmail(int id);
}
