import 'pagination_info.dart';
import 'resource_pagination_links.dart';

class PaginatedResource<T extends Object> {
  final List<T> data;
  final PaginationInfo paginationInfo;
  final ResourcePaginationLinks paginationLinks;

  const PaginatedResource({
    required this.data,
    required this.paginationInfo,
    required this.paginationLinks,
  });

  PaginatedResource<T> copyWith({
    List<T>? data,
    PaginationInfo? paginationInfo,
    ResourcePaginationLinks? paginationLinks,
  }) {
    return PaginatedResource(
      data: data ?? this.data,
      paginationInfo: paginationInfo ?? this.paginationInfo,
      paginationLinks: paginationLinks ?? this.paginationLinks,
    );
  }
}
