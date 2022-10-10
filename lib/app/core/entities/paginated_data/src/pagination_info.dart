class PaginationInfo {
  final int currentPage, from, lastPage;
  final List<CurrentPageLinks> links;
  final String path;
  final int perPage, to, total;

  const PaginationInfo({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory PaginationInfo.fromMap(Map<String, dynamic> map) {
    return PaginationInfo(
      currentPage: map['current_page'] as int,
      from: map['from'] as int,
      lastPage: map['last_page'] as int,
      links: (map['links'] as List)
          .map((e) => CurrentPageLinks.fromMap(e))
          .toList(),
      path: map['path'] as String,
      perPage: map['per_page'] as int,
      to: map['to'] as int,
      total: map['total'] as int,
    );
  }

  @override
  String toString() {
    return 'PaginationInfo{currentPage: $currentPage, from: $from, lastPage: $lastPage, links: $links, path: $path, perPage: $perPage, to: $to, total: $total}';
  }
}

class CurrentPageLinks {
  final String? url;
  final String label;
  final bool active;

  const CurrentPageLinks({
    this.url,
    required this.label,
    required this.active,
  });

  factory CurrentPageLinks.fromMap(Map<String, dynamic> map) {
    return CurrentPageLinks(
      url: map['url'] as String?,
      label: map['label'] as String,
      active: map['active'] as bool,
    );
  }
}
