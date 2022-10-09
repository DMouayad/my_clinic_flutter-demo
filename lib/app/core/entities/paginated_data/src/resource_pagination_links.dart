class ResourcePaginationLinks {
  final String first, last;
  final String? next, previous;

  const ResourcePaginationLinks(
    this.first,
    this.last, {
    this.next,
    this.previous,
  });

  factory ResourcePaginationLinks.fromMap(Map<String, dynamic> data) {
    return ResourcePaginationLinks(
      data['first'],
      data['last'],
      previous: data['prev'],
      next: data['next'],
    );
  }
}
