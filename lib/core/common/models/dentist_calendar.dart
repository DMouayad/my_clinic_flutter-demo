import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'work_shift.dart';

class DentistCalendar {
  final List<WorkShift> workShifts;
  DentistCalendar({required this.workShifts});

  bool get allDaysHaveSameWorkShift => workShifts.length == 1;

  WorkShift getDayWorkShift(int day) {
    return workShifts.firstWhere((workShift) => workShift.days.contains(day));
  }

  List<int> get holidays {
    final _workDays =
        workShifts.map((shift) => shift.days).expand((e) => e).toList();
    return _weekDays
        .takeWhile((element) => !_workDays.contains(element))
        .toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'workShifts': workShifts.map((x) => x.toMap()).toList(),
    };
  }

  @override
  String toString() => 'DentistCalendar(workShifts: $workShifts)';

  @override
  int get hashCode => workShifts.hashCode;

  factory DentistCalendar.fromMap(Map<String, dynamic> map) {
    return DentistCalendar(
      workShifts: List<WorkShift>.from(
        map['workShifts']?.map((x) => WorkShift.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DentistCalendar.fromJson(String source) =>
      DentistCalendar.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DentistCalendar && listEquals(other.workShifts, workShifts);
  }

  DentistCalendar copyWith({
    List<WorkShift>? workShifts,
  }) {
    return DentistCalendar(
      workShifts: workShifts ?? this.workShifts,
    );
  }
}

const _weekDays = [
  DateTime.sunday,
  DateTime.monday,
  DateTime.thursday,
  DateTime.wednesday,
  DateTime.thursday,
  DateTime.friday,
  DateTime.saturday
];
