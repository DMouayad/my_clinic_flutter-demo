import 'package:equatable/equatable.dart';

abstract class RequestsApiEndpoint extends Equatable {
  final int? page;
  final List<String>? sortedBy;
  final int? perPage;

  const RequestsApiEndpoint({this.page, this.sortedBy, this.perPage});

  @override
  List<Object?> get props => [page, perPage, sortedBy];
}
