part of api_endpoint;

/// Get all staff emails data including their roles.
/// Requires an access token
class GetStaffEmailsWithRolesApiEndpoint extends ApiEndpoint {
  GetStaffEmailsWithRolesApiEndpoint._(String token)
      : super._(
          RequestMethod.GET,
          urlWithoutBaseUrl: '/staff-emails-with-roles',
          token: token,
        );
}

class GetStaffEmailsWithRolesEndpointResult extends ApiEndpointResult {
  final List<StaffEmailApiResponseMap> staffEmailsData;

  const GetStaffEmailsWithRolesEndpointResult(this.staffEmailsData);
  factory GetStaffEmailsWithRolesEndpointResult.fromApiResponse(dynamic data) {
    final staffEmailsData =
        (data as List).map((e) => StaffEmailApiResponseMap.fromMap(e)).toList();

    return GetStaffEmailsWithRolesEndpointResult(staffEmailsData);
  }
}

class StaffEmailApiResponseMap {
  final int id;
  final String email;
  final UserRole role;

  const StaffEmailApiResponseMap(this.id, this.email, this.role);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'role': role,
    };
  }

  factory StaffEmailApiResponseMap.fromMap(Map<String, dynamic> map) {
    return StaffEmailApiResponseMap(
      map['id'] as int,
      map['email'] as String,
      UserRole.values.byName(map['role']['slug'] as String),
    );
  }
}
