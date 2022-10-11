import 'package:equatable/equatable.dart';

class ResourcePaginationLinks extends Equatable {
  final String first, last;
  final String? next, previous;

  const ResourcePaginationLinks({
    required this.first,
    required this.last,
    this.next,
    this.previous,
  });

  factory ResourcePaginationLinks.fromMap(Map<String, dynamic> data) {
    return ResourcePaginationLinks(
      first: data['first'],
      last: data['last'],
      previous: data['prev'],
      next: data['next'],
    );
  }

  @override
  List<Object?> get props => [first, last, previous, next];

  ResourcePaginationLinks copyWith({
    String? first,
    String? last,
    String? next,
    String? previous,
  }) {
    return ResourcePaginationLinks(
      first: first ?? this.first,
      last: last ?? this.last,
      next: next ?? this.next,
      previous: previous ?? this.previous,
    );
  }
}
