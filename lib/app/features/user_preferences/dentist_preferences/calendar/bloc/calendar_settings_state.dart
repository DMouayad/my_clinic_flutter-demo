part of 'calendar_settings_bloc.dart';

class CalendarSettingsState extends Equatable {
  final DentistCalendar calendar;
  final List<int> holidays;
  const CalendarSettingsState({
    required this.calendar,
    required this.holidays,
  });
  @override
  List<Object> get props => [calendar, holidays];

  CalendarSettingsState copyWith({
    DentistCalendar? calendar,
    List<int>? holidays,
  }) {
    return CalendarSettingsState(
      calendar: calendar ?? this.calendar,
      holidays: holidays ?? this.holidays,
    );
  }
}

class CalendarSettingsStateChanged extends CalendarSettingsState {
  const CalendarSettingsStateChanged(
      {required DentistCalendar calendar, required List<int> holidays})
      : super(calendar: calendar, holidays: holidays);
}
