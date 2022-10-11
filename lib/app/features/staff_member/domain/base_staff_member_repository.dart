import 'dart:async';

import 'package:clinic_v2/app/core/entities/paginated_data/src/paginated_resource.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'base_staff_member.dart';

abstract class BaseStaffMemberRepository {
  StreamController<PaginatedResource<BaseStaffMember>?>
      get staffMembersStreamController => _staffMembersStreamController;
  final StreamController<PaginatedResource<BaseStaffMember>?>
      _staffMembersStreamController = StreamController();

  Stream<PaginatedResource<BaseStaffMember>?> get staffMembersResource =>
      _staffMembersStreamController.stream;

  Future<Result<VoidValue, BasicError>> addStaffMember(
      String email, UserRole userRole);
  Future<Result<VoidValue, BasicError>> fetchStaffMembers([
    int? page,
    List<String>? sortedBy,
  ]);
  Future<Result<VoidValue, BasicError>> updateStaffMember(
    int id, [
    String? email,
    UserRole? userRole,
  ]);
  Future<Result<VoidValue, BasicError>> deleteStaffMember(int id);
}
