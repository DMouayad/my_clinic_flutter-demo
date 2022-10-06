import 'package:clinic_v2/api/models/api_endpoint_result.dart';
import 'package:clinic_v2/api/models/staff_email_response_data.dart';

class AddStaffEmailEndpointResult extends ApiEndpointResult {
  final ApiResponseStaffEmailData staffEmailData;

  const AddStaffEmailEndpointResult(this.staffEmailData);
  factory AddStaffEmailEndpointResult.fromMap(Map<String, dynamic> map) {
    return AddStaffEmailEndpointResult(
      ApiResponseStaffEmailData(
        id: map['id'] as int,
        roleSlug: map['role']['slug'],
        email: map['email'],
      ),
    );
  }
}
