import 'package:clinic_v2/api/models/api_endpoint_result.dart';
import 'package:clinic_v2/api/models/api_response_staff_member_data.dart';

class AddStaffMemberEndpointResult extends ApiEndpointResult {
  final ApiResponseStaffMemberData staffMemberData;

  const AddStaffMemberEndpointResult(this.staffMemberData);
  factory AddStaffMemberEndpointResult.fromMap(Map<String, dynamic> map) {
    return AddStaffMemberEndpointResult(
      ApiResponseStaffMemberData(
        id: map['id'] as int,
        roleSlug: map['role']['slug'],
        email: map['email'],
      ),
    );
  }
}
