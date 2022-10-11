part of staff_member_api_endpoints;

/// Get a list of staff emails including their roles and users(if exists).
///
/// Requires an access token
class FetchStaffMembersApiEndpoint
    extends ApiEndpoint<FetchStaffMembersEndpointResult> {
  FetchStaffMembersApiEndpoint([int? page, List<String>? sortedBy])
      : super(
          method: RequestMethod.GET,
          url: _getUrl(page, sortedBy),
          includeDeviceId: true,
          includeAccessToken: true,
        );

  static String _getUrl([int? page, List<String>? sortedBy]) {
    final sortQuery = sortedBy != null ? '&sort=' + sortedBy.join(',') : '';
    return '/staff-members-all-data${page != null ? '?page=$page' : ''}$sortQuery';
  }
}
