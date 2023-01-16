import 'dart:async';

import 'package:clinic_v2/shared/models/paginated_api_resource/paginated_api_resource.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/utils/enums.dart';
import '../../../domain/staff_member/base/base_staff_member.dart';

abstract class BaseStaffMemberRepository {
  StreamController<PaginatedResource<BaseStaffMember>?>
      get staffMembersStreamController => _staffMembersStreamController;
  final StreamController<PaginatedResource<BaseStaffMember>?>
      _staffMembersStreamController = StreamController();

  Stream<PaginatedResource<BaseStaffMember>?> get staffMembersResource =>
      _staffMembersStreamController.stream;

  Future<Result<VoidValue, BasicError>> addStaffMember(
      String email, UserRole userRole);
  Future<Result<VoidValue, BasicError>> fetchStaffMembers({
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
