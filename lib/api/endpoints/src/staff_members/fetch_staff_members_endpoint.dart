part of staff_member_api_endpoints;

/// Get a list of staff emails including their roles and users(if exists).
///
/// Requires an access token
class FetchStaffMembersApiEndpoint
    extends ApiEndpoint<FetchStaffMembersEndpointResult> {
  FetchStaffMembersApiEndpoint({
    int? page,
    int? perPage,
    List<String>? sortedBy,
  }) : super(
          method: RequestMethod.GET,
          url: _getUrl(page, perPage, sortedBy),
          includeDeviceId: true,
          includeAccessToken: true,
        );

  static String _getUrl([int? page, int? perPage, List<String>? sortedBy]) {
    Map<String, String> params = {};
    if (page != null) {
      params["page"] = page.toString();
    }
    if (sortedBy != null) {
      params["sort"] = sortedBy.join(',');
    }
    if (perPage != null) {
      params["per_page"] = perPage.toString();
    }
    final paramsString =
        params.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '/staff-members-all-data?$paramsString';
  }

  @override
  FetchStaffMembersEndpointResult resultFromMap(Map<String, dynamic> map) {
    return FetchStaffMembersEndpointResult.fromMap(map);
  }
}
