import 'package:clinic_v2/api/models/response_user_data.dart';

class ApiResponseStaffEmailData {
  final int id;
  final String roleSlug;
  final String email;
  final ApiResponseUserData? userData;

  const ApiResponseStaffEmailData({
    required this.id,
    required this.roleSlug,
    required this.email,
    this.userData,
  });
}
