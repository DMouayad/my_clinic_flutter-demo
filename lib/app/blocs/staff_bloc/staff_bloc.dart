import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/shared/models/base_event.dart';
import 'package:clinic_v2/shared/services/logger_service.dart';
import 'package:clinic_v2/domain/staff_member/base/base_staff_member.dart';
import 'package:clinic_v2/domain/staff_member/base/base_staff_member_repository.dart';
import 'package:clinic_v2/shared/models/api_request_metadata.dart';
import 'package:clinic_v2/shared/models/paginated_api_resource/src/paginated_resource.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/utils/enums.dart';

part 'events/add_staff_member.dart';

part 'events/fetch_staff_members.dart';

part 'events/delete_staff_member.dart';

part 'events/update_staff_member.dart';

part 'events/staff_member_updated.dart';

part 'events/sort_staff_members.dart';

part 'staff_event.dart';

part 'staff_state.dart';

class StaffBloc extends Bloc<StaffBlocEvent, StaffBlocState> {
  final BaseStaffMemberRepository _repository;

  StaffBloc(this._repository) : super(StaffBlocInitialState()) {
    _repository.staffMembersStream
        .listen((resource) => add(UpdateStaffMembersRequested(resource)));

    on<StaffBlocEvent>((event, emit) async {
      await event.handle(_repository, state, emit);
    });
  }

  @override
  void onTransition(Transition<StaffBlocEvent, StaffBlocState> transition) {
    Log.logBlocTransition(this, transition);
    super.onTransition(transition);
  }
}
