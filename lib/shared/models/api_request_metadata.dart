import 'package:equatable/equatable.dart';

class ApiRequestMetadata extends Equatable {
  final int? page;
  final List<String>? sortedBy;
  final int? perPage;

  const ApiRequestMetadata({this.page, this.sortedBy, this.perPage});

  @override
  List<Object?> get props => [page, perPage, sortedBy];
}
