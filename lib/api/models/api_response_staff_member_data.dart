import 'package:clinic_v2/api/models/response_user_data.dart';

class ApiResponseStaffMemberData {
  final int id;
  final String roleSlug;
  final String email;
  final ApiResponseUserData? userData;

  const ApiResponseStaffMemberData({
    required this.id,
    required this.roleSlug,
    required this.email,
    this.userData,
  });
}
