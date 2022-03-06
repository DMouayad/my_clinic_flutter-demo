import 'package:clinic_v2/app/common/blocs/app_user_bloc/user_bloc.dart';
import 'package:clinic_v2/app/common/blocs/dentist_bloc/events_handler.dart.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:clinic_v2/core/features/users/data/dentist_data.dart';
import 'package:clinic_v2/core/features/users/domain/dentist_contracts.dart';

part 'dentist_event.dart';

part 'dentist_state.dart';

class DentistBloc extends UserBloc<DentistEvent, DentistState> {
  final BaseDentistRepository dentistRepository;
  late final DentistBlocEventsHandler _eventsHandler;

  DentistBloc(this.dentistRepository)
      : super(
          userRepository: dentistRepository,
          initState: DentistInitial(),
        ) {
    _eventsHandler = DentistBlocEventsHandler(dentistRepository);

    on<DentistEvent>((event, emit) async {
      emit(await _eventsHandler.handleEvent(event));
    });
  }
}
