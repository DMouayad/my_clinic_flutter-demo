part of 'calendar_settings_bloc.dart';

abstract class CalendarSettingsEvent {
  const CalendarSettingsEvent();

  factory CalendarSettingsEvent.shiftUpdated({
    required WorkShift newWorkShift,
    required int shiftIndex,
  }) = _WorkShiftUpdated;
  factory CalendarSettingsEvent.shiftAdded(WorkShift newWorkShift) =
      _WorkShiftAdded;
  factory CalendarSettingsEvent.shiftDeleted({required int shiftIndex}) =
      _WorkShiftDeleted;
  factory CalendarSettingsEvent.holidaysChanged(
      {required List<int> newHolidaysList}) = _HolidaysChanged;

  void when({
    required void Function(_WorkShiftUpdated) shiftUpdated,
    required void Function(_WorkShiftAdded) shiftAdded,
    required void Function(_WorkShiftDeleted) shiftDeleted,
    required void Function(_HolidaysChanged) holidaysChanged,
  }) {
    if (this is _WorkShiftUpdated) {
      shiftUpdated.call(this as _WorkShiftUpdated);
    }

    if (this is _WorkShiftAdded) {
      shiftAdded.call(this as _WorkShiftAdded);
    }

    if (this is _WorkShiftDeleted) {
      shiftDeleted.call(this as _WorkShiftDeleted);
    }

    if (this is _HolidaysChanged) {
      holidaysChanged.call(this as _HolidaysChanged);
    }
  }

  R map<R>({
    required R Function(_WorkShiftUpdated) shiftUpdated,
    required R Function(_WorkShiftAdded) shiftAdded,
    required R Function(_WorkShiftDeleted) shiftDeleted,
    required R Function(_HolidaysChanged) holidaysChanged,
  }) {
    if (this is _WorkShiftUpdated) {
      return shiftUpdated.call(this as _WorkShiftUpdated);
    }

    if (this is _WorkShiftAdded) {
      return shiftAdded.call(this as _WorkShiftAdded);
    }

    if (this is _WorkShiftDeleted) {
      return shiftDeleted.call(this as _WorkShiftDeleted);
    } else {
      return holidaysChanged.call(this as _HolidaysChanged);
    }
  }

  void maybeWhen({
    void Function(_WorkShiftUpdated)? shiftUpdated,
    void Function(_WorkShiftAdded)? shiftAdded,
    void Function(_WorkShiftDeleted)? shiftDeleted,
    void Function(_HolidaysChanged)? holidaysChanged,
    required void Function() orElse,
  }) {
    if (this is _WorkShiftUpdated && shiftUpdated != null) {
      shiftUpdated.call(this as _WorkShiftUpdated);
    }

    if (this is _WorkShiftAdded && shiftAdded != null) {
      shiftAdded.call(this as _WorkShiftAdded);
    }

    if (this is _WorkShiftDeleted && shiftDeleted != null) {
      shiftDeleted.call(this as _WorkShiftDeleted);
    }

    if (this is _HolidaysChanged && holidaysChanged != null) {
      holidaysChanged.call(this as _HolidaysChanged);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(_WorkShiftUpdated)? shiftUpdated,
    R Function(_WorkShiftAdded)? shiftAdded,
    R Function(_WorkShiftDeleted)? shiftDeleted,
    R Function(_HolidaysChanged)? holidaysChanged,
    required R Function() orElse,
  }) {
    if (this is _WorkShiftUpdated && shiftUpdated != null) {
      return shiftUpdated.call(this as _WorkShiftUpdated);
    }

    if (this is _WorkShiftAdded && shiftAdded != null) {
      return shiftAdded.call(this as _WorkShiftAdded);
    }

    if (this is _WorkShiftDeleted && shiftDeleted != null) {
      return shiftDeleted.call(this as _WorkShiftDeleted);
    }

    if (this is _HolidaysChanged && holidaysChanged != null) {
      return holidaysChanged.call(this as _HolidaysChanged);
    }

    return orElse.call();
  }
}

class _WorkShiftUpdated extends CalendarSettingsEvent {
  final int shiftIndex;
  final WorkShift newWorkShift;
  _WorkShiftUpdated({required this.shiftIndex, required this.newWorkShift});
}

class _WorkShiftAdded extends CalendarSettingsEvent {
  final WorkShift workShift;

  _WorkShiftAdded(this.workShift);
}

class _WorkShiftDeleted extends CalendarSettingsEvent {
  final int shiftIndex;

  _WorkShiftDeleted({required this.shiftIndex});
}

class _HolidaysChanged extends CalendarSettingsEvent {
  final List<int> newHolidaysList;

  _HolidaysChanged({required this.newHolidaysList});
}
