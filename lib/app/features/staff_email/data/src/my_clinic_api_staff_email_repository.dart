import 'package:clinic_v2/app/core/entities/paginated_data/src/paginated_resource.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/staff_email/data/src/my_clinic_api_staff_email.dart';
import 'package:clinic_v2/app/features/staff_email/domain/staff_email_domain.dart';

import 'my_clinic_api_staff_email_data_source.dart';

class MyClinicApiStaffEmailRepository extends BaseStaffEmailRepository {
  MyClinicApiStaffEmailRepository() {
    _dataSource = const MyClinicApiStaffEmailDataSource();
  }

  late final MyClinicApiStaffEmailDataSource _dataSource;
  late PaginatedResource<MyClinicApiStaffEmail>? _staffEmailResource;

  @override
  Future<Result<VoidValue, BasicError>> addStaffEmail(
    String email,
    UserRole userRole,
  ) async {
    return await (await _dataSource.addStaffEmail(email, userRole))
        .mapSuccessToVoidAsync(
      (newStaffEmail) async {
        if (_staffEmailResource != null) {
          List<MyClinicApiStaffEmail> staffEmailList =
              List.from([..._staffEmailResource!.data, newStaffEmail]);
          staffEmailsStreamController
              .add(_staffEmailResource!.copyWith(data: staffEmailList));
        } else {
          getStaffEmails();
        }
      },
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> deleteStaffEmail(int id) async {
    return (await _dataSource.deleteStaffEmail(id)).mapSuccessToVoid((_) {
      final List<MyClinicApiStaffEmail> currentStaffEmails =
          List.from(_staffEmailResource!.data);

      currentStaffEmails.removeWhere((element) => element.id == id);

      staffEmailsStreamController
          .add(_staffEmailResource?.copyWith(data: currentStaffEmails));
    });
  }

  @override
  Future<Result<VoidValue, BasicError>> getStaffEmails() async {
    return (await _dataSource.fetchStaffEmails()).mapSuccessToVoid(
      (result) {
        _staffEmailResource = result;
        staffEmailsStreamController.add(_staffEmailResource);
      },
    );
  }

  @override
  Future<Result<VoidValue, BasicError>> updateStaffEmail(
    int id, [
    String? email,
    UserRole? userRole,
  ]) async {
    return (await _dataSource.updateStaffEmail(id, email, userRole))
        .mapSuccessToVoid((_) {
      final List<MyClinicApiStaffEmail> currentStaffEmails =
          List.from(_staffEmailResource!.data);

      final staffEmailIndex =
          currentStaffEmails.indexWhere((element) => element.id == id);
      currentStaffEmails[staffEmailIndex] = currentStaffEmails
          .elementAt(staffEmailIndex)
          .copyWith(email: email, userRole: userRole);
      staffEmailsStreamController
          .add(_staffEmailResource?.copyWith(data: currentStaffEmails));
    });
  }
}
