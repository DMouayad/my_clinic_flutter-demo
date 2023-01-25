import 'package:equatable/equatable.dart';

class ApiRequestMetadata extends Equatable {
  final List<String>? sortedBy;
  final int? page;
  final int? perPage;

  const ApiRequestMetadata({this.page, this.sortedBy, this.perPage});

  @override
  List<Object?> get props => [page, perPage, sortedBy];
}
