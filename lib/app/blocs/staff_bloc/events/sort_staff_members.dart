part of '../staff_bloc.dart';

/// An event to load staff members from the remote datasource
class SortStaffMembers extends StaffBlocEvent {
  const SortStaffMembers({this.metadata});

  final ApiRequestMetadata? metadata;

  factory SortStaffMembers.withMeta({
    int? page,
    List<String>? sortedBy,
    int? perPage,
  }) {
    return SortStaffMembers(
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
    if (repository.staffMembersResource?.paginationInfo.total ==
        repository.staffMembersResource?.data.length) {
      final staffMembers = repository.staffMembersResource?.data;
      // staffMembers?.sort((s1, s2) {});
      emit(
        StaffMembersWereLoaded(
            repository.staffMembersResource?.copyWith(data: staffMembers)),
      );
    } else {
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
}
