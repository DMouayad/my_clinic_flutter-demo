import 'package:clinic_v2/app/core/entities/paginated_data/src/paginated_resource.dart';
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/staff_member/domain/base_staff_member.dart';
import 'package:clinic_v2/app/features/staff_member/domain/base_staff_member_repository.dart';
import 'package:clinic_v2/app/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffBlocEvent, StaffBlocState> {
  final BaseStaffMemberRepository _repository;

  StaffBloc(this._repository) : super(StaffBlocInitialState()) {
    _repository.staffMembersResource
        .listen((list) => add(UpdateStaffMembersRequested(list)));

    on<UpdateStaffMembersRequested>((event, emit) {
      if (state is StaffBlocEventProcessing) {
        emit(_getRequestedEventSuccessState());
      }
      emit(StaffMembersWereLoaded(event.newStaffMembers));
    });

    on<AddStaffMember>((event, emit) async {
      if (state is! StaffBlocEventProcessing) {
        emit(const AddingStaffMember());
      }

      final result = await _repository.addStaffMember(event.email, event.role);

      if (result.isFailure) {
        emit(StaffBlocErrorState((result as FailureResult).error));
      }
    });

    on<FetchStaffMembers>((event, emit) async {
      if (state is! LoadingStaffMembers) {
        emit(LoadingStaffMembers());
      }
      (await _repository.fetchStaffMembers(event.page, event.sortedBy)).fold(
        ifFailure: (error) => emit(StaffBlocErrorState(error)),
      );
    });

    on<DeleteStaffMember>((event, emit) async {
      emit(const DeletingStaffMember());
      (await _repository.deleteStaffMember(event.id)).fold(ifFailure: (error) {
        emit(StaffBlocErrorState(error));
      });
    });
    on<UpdateStaffMember>((event, emit) async {
      emit(const UpdatingStaffMember());
      (await _repository.updateStaffMember(
        event.id,
        event.email,
        event.role,
      ))
          .fold(ifFailure: (error) {
        emit(StaffBlocErrorState(error));
      });
    });
  }
  StaffBlocState _getRequestedEventSuccessState() {
    switch (state.runtimeType) {
      case AddingStaffMember:
        return StaffMemberWasAdded();
      case UpdatingStaffMember:
        return StaffMemberWasUpdated();
      case DeletingStaffMember:
        return StaffMemberWasDeleted();
      default:
        throw UnimplementedError();
    }
  }

  @override
  void onTransition(Transition<StaffBlocEvent, StaffBlocState> transition) {
    Log.logBlocTransition(this, transition);
    super.onTransition(transition);
  }
}
