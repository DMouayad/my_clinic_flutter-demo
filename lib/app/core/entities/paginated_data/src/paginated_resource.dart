import 'package:equatable/equatable.dart';

import 'pagination_info.dart';
import 'resource_pagination_links.dart';

class PaginatedResource<T extends Object> extends Equatable {
  final List<T> data;
  final PaginationInfo paginationInfo;
  final ResourcePaginationLinks paginationLinks;

  const PaginatedResource({
    required this.data,
    required this.paginationInfo,
    required this.paginationLinks,
  });

  PaginatedResource<Y> copyWith<Y extends Object>({
    List<Y>? data,
    PaginationInfo? paginationInfo,
    ResourcePaginationLinks? paginationLinks,
  }) {
    return PaginatedResource(
      data: data ?? this.data as List<Y>,
      paginationInfo: paginationInfo ?? this.paginationInfo,
      paginationLinks: paginationLinks ?? this.paginationLinks,
    );
  }

  @override
  List<Object?> get props => [data, paginationInfo, paginationLinks];
}
