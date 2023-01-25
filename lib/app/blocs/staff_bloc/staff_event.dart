part of 'staff_bloc.dart';

abstract class StaffBlocEvent
    extends BaseBlocEvent<BaseStaffMemberRepository, StaffBlocState>
    with EquatableMixin {
  const StaffBlocEvent();

  @override
  List<Object?> get props => [];
}
