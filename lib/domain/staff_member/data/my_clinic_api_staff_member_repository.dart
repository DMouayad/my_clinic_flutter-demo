import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/utils/enums.dart';

import '../base/base_staff_member_repository.dart';
import 'my_clinic_api_staff_member_data_source.dart';
import 'my_clinic_api_staff_member.dart';

class MyClinicApiStaffMemberRepository extends BaseStaffMemberRepository {
  MyClinicApiStaffMemberRepository() {
    _dataSource = const MyClinicApiStaffMemberDataSource();
  }

  late final MyClinicApiStaffMemberDataSource _dataSource;

  @override
  Future<Result<VoidValue, AppError>> addStaffMember(
    String email,
    UserRole userRole,
  ) async {
    return await (await _dataSource.addStaffMember(email, userRole))
        .mapSuccessToVoidAsync(
      onSuccess: (newStaffMember) async {
        if (staffMembersResource != null) {
          List<MyClinicApiStaffMember> staffMemberList = List.from(
            [...staffMembersResource!.data, newStaffMember],
          );
          staffMembersStreamController.add(
            staffMembersResource!.copyWith(
              data: staffMemberList,
              paginationInfo: staffMembersResource!.paginationInfo.copyWith(
                total: staffMembersResource!.paginationInfo.total + 1,
              ),
            ),
          );
        } else {
          fetchStaffMembers(page: 1);
        }
      },
    );
  }

  @override
  Future<Result<VoidValue, AppError>> deleteStaffMember(int id) async {
    return (await _dataSource.deleteStaffMember(id)).mapSuccessToVoid(
        onSuccess: (_) {
      final List<MyClinicApiStaffMember> currentStaffMembers =
          List.from(staffMembersResource!.data);

      currentStaffMembers.removeWhere((element) => element.id == id);

      staffMembersStreamController.add(staffMembersResource?.copyWith(
        data: currentStaffMembers,
        paginationInfo: staffMembersResource!.paginationInfo.copyWith(
          total: staffMembersResource!.paginationInfo.total - 1,
          to: staffMembersResource!.paginationInfo.to - 1,
        ),
      ));
    });
  }

  @override
  Future<Result<VoidValue, AppError>> fetchStaffMembers({
    int? page,
    int? perPage,
    List<String>? sortedBy,
  }) async {
    return (await _dataSource.fetchStaffMembers(
      page: page,
      sortedBy: sortedBy,
      perPage: perPage,
    ))
        .mapSuccessToVoid(
      onSuccess: (result) => staffMembersStreamController.add(result),
    );
  }

  @override
  Future<Result<VoidValue, AppError>> updateStaffMember(
    int id, [
    String? email,
    UserRole? userRole,
  ]) async {
    return (await _dataSource.updateStaffMember(id, email, userRole))
        .mapSuccessToVoid(onSuccess: (_) {
      final List<MyClinicApiStaffMember> currentStaffMembers =
          List.from(staffMembersResource!.data);

      final staffMemberIndex =
          currentStaffMembers.indexWhere((element) => element.id == id);
      currentStaffMembers[staffMemberIndex] = currentStaffMembers
          .elementAt(staffMemberIndex)
          .copyWith(email: email, userRole: userRole);
      staffMembersStreamController
          .add(staffMembersResource?.copyWith(data: currentStaffMembers));
    });
  }
}
