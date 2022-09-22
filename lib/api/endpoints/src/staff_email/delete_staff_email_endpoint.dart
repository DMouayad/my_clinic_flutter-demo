part of api_endpoint;

/// Get all staff emails data including their roles.
/// Requires an access token
class DeleteStaffEmailApiEndpoint extends ApiEndpoint {
  DeleteStaffEmailApiEndpoint._({required int id, required String token})
      : super._(
          RequestMethod.DELETE,
          urlWithoutBaseUrl: '/staff-emails/$id',
          token: token,
        );
}
