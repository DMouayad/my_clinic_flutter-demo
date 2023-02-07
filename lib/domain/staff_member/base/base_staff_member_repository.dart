import 'dart:async';

import 'package:clinic_v2/shared/models/paginated_api_resource/paginated_api_resource.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/utils/enums.dart';
import '../../../domain/staff_member/base/base_staff_member.dart';

abstract class BaseStaffMemberRepository {
  BaseStaffMemberRepository() {
    _staffMembersStreamController = StreamController.broadcast()
      ..stream.listen((data) {
        _staffMembersResource = data;
      });
  }

  StreamController<PaginatedResource<BaseStaffMember>?>
      get staffMembersStreamController => _staffMembersStreamController;
  late final StreamController<PaginatedResource<BaseStaffMember>?>
      _staffMembersStreamController;

  Stream<PaginatedResource<BaseStaffMember>?> get staffMembersStream =>
      _staffMembersStreamController.stream;

  PaginatedResource<BaseStaffMember>? _staffMembersResource;

  PaginatedResource<BaseStaffMember>? get staffMembersResource =>
      _staffMembersResource;

  Future<Result<VoidValue, AppError>> addStaffMember(
      String email, UserRole userRole);

  Future<Result<VoidValue, AppError>> fetchStaffMembers({
    int? page,
    int? perPage,
    List<String>? sortedBy,
  });

  Future<Result<VoidValue, AppError>> updateStaffMember(
    int id, [
    String? email,
    UserRole? userRole,
  ]);

  Future<Result<VoidValue, AppError>> deleteStaffMember(int id);
}
