import 'package:bloc/bloc.dart';
import 'package:clinic_v2/core/common/models/dentist_calendar.dart';
import 'package:clinic_v2/core/common/models/work_shift.dart';
import 'package:equatable/equatable.dart';

part 'calendar_settings_event.dart';
part 'calendar_settings_state.dart';

class CalendarSettingsBloc
    extends Bloc<CalendarSettingsEvent, CalendarSettingsState> {
  CalendarSettingsBloc(DentistCalendar calendar)
      : super(CalendarSettingsState(
          calendar: calendar,
          holidays: calendar.holidays,
        )) {
    on<CalendarSettingsEvent>((event, emit) {
      final newState = event.map<CalendarSettingsState>(
        shiftUpdated: getStateWhenShiftUpdated,
        shiftAdded: getStateWhenShiftAdded,
        shiftDeleted: getStateWhenShiftDeleted,
        holidaysChanged: getStateWhenHolidaysChanged,
      );

      emit(newState);
    });
  }
}

extension _CalendarSettingsBlocEventsHandler on CalendarSettingsBloc {
  CalendarSettingsStateChanged getStateWhenShiftUpdated(
    _WorkShiftUpdated event,
  ) {
    final workShifts = List<WorkShift>.from(state.calendar.workShifts);

    workShifts[event.shiftIndex] = event.newWorkShift;
    return CalendarSettingsStateChanged(
      calendar: state.calendar.copyWith(workShifts: workShifts),
      holidays: state.holidays,
    );
  }

  CalendarSettingsStateChanged getStateWhenHolidaysChanged(
      _HolidaysChanged event) {
    final calendar = state.calendar;
    // remove all holidays from work days
    for (var shift in calendar.workShifts) {
      shift.days.removeWhere((day) => event.newHolidaysList.contains(day));
    }
    return CalendarSettingsStateChanged(
      calendar: calendar,
      holidays: event.newHolidaysList,
    );
  }

  CalendarSettingsStateChanged getStateWhenShiftAdded(_WorkShiftAdded event) {
    final workShifts = List<WorkShift>.from(state.calendar.workShifts);
    workShifts.add(event.workShift);
    return CalendarSettingsStateChanged(
      calendar: state.calendar.copyWith(workShifts: workShifts),
      holidays: state.holidays,
    );
  }

  CalendarSettingsStateChanged getStateWhenShiftDeleted(
      _WorkShiftDeleted event) {
    final workShifts = List<WorkShift>.from(state.calendar.workShifts);

    workShifts.removeAt(event.shiftIndex);
    return CalendarSettingsStateChanged(
      calendar: state.calendar.copyWith(workShifts: workShifts),
      holidays: state.holidays,
    );
  }
}
