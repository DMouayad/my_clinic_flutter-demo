part of api_endpoint;

class EditStaffEmailApiEndpoint extends ApiEndpoint {
  EditStaffEmailApiEndpoint._({
    required int id,
    required String token,
    String? newEmail,
    UserRole? newRole,
  })  : assert(newEmail != null || newRole != null),
        super._(
          RequestMethod.PUT,
          urlWithoutBaseUrl: '/staff-emails/$id',
          token: token,
          data: () {
            Map<String, dynamic> data = {};
            if (newEmail != null) {
              data['email'] = newEmail;
            }
            if (newRole != null) {
              data['role'] = newRole.name;
            }
            return data;
          }(),
        );
}
