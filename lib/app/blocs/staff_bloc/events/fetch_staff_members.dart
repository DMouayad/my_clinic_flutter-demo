part of '../staff_bloc.dart';

/// An event to load staff members from the remote datasource
class FetchStaffMembers extends StaffBlocEvent {
  const FetchStaffMembers({this.metadata});
  final ApiRequestMetadata? metadata;
  factory FetchStaffMembers.withMeta({
    int? page,
    List<String>? sortedBy,
    int? perPage,
  }) {
    return FetchStaffMembers(
      metadata:
          ApiRequestMetadata(page: page, sortedBy: sortedBy, perPage: perPage),
    );
  }

  @override
  Future<void> handle(
    BaseStaffMemberRepository repository,
    StaffBlocState state,
    Emitter<StaffBlocState> emit,
  ) async {
    if (state is! LoadingStaffMembers) {
      emit(LoadingStaffMembers());
    }
    (await repository.fetchStaffMembers(
      page: metadata?.page,
      sortedBy: metadata?.sortedBy,
      perPage: metadata?.perPage,
    ))
        .fold(
      ifFailure: (error) => emit(StaffBlocErrorState(error)),
    );
  }
}
