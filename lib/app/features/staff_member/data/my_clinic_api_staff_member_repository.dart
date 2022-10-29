import 'package:clinic_v2/app/core/entities/paginated_data/src/paginated_resource.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/enums.dart';

import '../domain/base_staff_member_repository.dart';
import 'my_clinic_api_staff_member_data_source.dart';
import 'my_clinic_api_staff_member.dart';

class MyClinicApiStaffMemberRepository extends BaseStaffMemberRepository {
  MyClinicApiStaffMemberRepository() {
    _dataSource = const MyClinicApiStaffMemberDataSource();
  }

  late final MyClinicApiStaffMemberDataSource _dataSource;
  late PaginatedResource<MyClinicApiStaffMember>? _staffMemberResource;

  @override
  Future<Result<VoidValue, BasicError>> addStaffMember(
    String email,
    UserRole userRole,
  ) async {
    return await (await _dataSource.addStaffMember(email, userRole))
        .mapSuccessToVoidAsync(
      (newStaffMember) async {
        if (_staffMemberResource != null) {
          List<MyClinicApiStaffMember> staffMemberList = List.from(
            [..._staffMemberResource!.data, newStaffMember],
          );
          staffMembersStreamController.add(
            _staffMemberResource!.copyWith(
              data: staffMemberList,
              paginationInfo: _staffMemberResource!.paginationInfo.copyWith(
                total: _staffMemberResource!.paginationInfo.total + 1,
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
  Future<Result<VoidValue, BasicError>> deleteStaffMember(int id) async {
    return (await _dataSource.deleteStaffMember(id)).mapSuccessToVoid((_) {
      final List<MyClinicApiStaffMember> currentStaffMembers =
          List.from(_staffMemberResource!.data);

      currentStaffMembers.removeWhere((element) => element.id == id);

      staffMembersStreamController.add(_staffMemberResource?.copyWith(
        data: currentStaffMembers,
        paginationInfo: _staffMemberResource!.paginationInfo.copyWith(
          total: _staffMemberResource!.paginationInfo.total - 1,
          to: _staffMemberResource!.paginationInfo.to - 1,
        ),
      ));
    });
  }

  @override
  Future<Result<VoidValue, BasicError>> fetchStaffMembers({
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
      (result) {
        _staffMemberResource = result;
        staffMembersStreamController.add(_staffMemberResource);
      },
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> updateStaffMember(
    int id, [
    String? email,
    UserRole? userRole,
  ]) async {
    return (await _dataSource.updateStaffMember(id, email, userRole))
        .mapSuccessToVoid((_) {
      final List<MyClinicApiStaffMember> currentStaffMembers =
          List.from(_staffMemberResource!.data);

      final staffMemberIndex =
          currentStaffMembers.indexWhere((element) => element.id == id);
      currentStaffMembers[staffMemberIndex] = currentStaffMembers
          .elementAt(staffMemberIndex)
          .copyWith(email: email, userRole: userRole);
      staffMembersStreamController
          .add(_staffMemberResource?.copyWith(data: currentStaffMembers));
    });
  }
}
