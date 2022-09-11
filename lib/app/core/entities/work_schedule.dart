import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'work_shift.dart';

class WorkSchedule extends Equatable {
  final List<WorkShift> workShifts;
  const WorkSchedule({required this.workShifts});

  bool get allDaysHaveSameWorkShift => workShifts.length == 1;

  WorkShift getDayWorkShift(int day) {
    return workShifts.firstWhere((workShift) => workShift.days.contains(day));
  }

  List<int> get workDays {
    return workShifts
        .map((shift) => shift.days)
        .expand((e) => e)
        .toSet()
        .toList();
  }

  List<int> get holidays {
    final _workDays = workDays;
    return kWeekDays
        .takeWhile((element) => !_workDays.contains(element))
        .toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'workShifts': workShifts.map((x) => x.toMap()).toList(),
    };
  }

  @override
  String toString() => 'WorkSchedule(workShifts: $workShifts)';

  factory WorkSchedule.fromMap(Map<String, dynamic> map) {
    return WorkSchedule(
      workShifts: List<WorkShift>.from(
        map['workShifts']?.map((x) => WorkShift.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkSchedule.fromJson(String source) =>
      WorkSchedule.fromMap(json.decode(source));

  WorkSchedule copyWith({List<WorkShift>? workShifts}) {
    return WorkSchedule(workShifts: workShifts ?? this.workShifts);
  }

  @override
  List<Object?> get props => [workShifts];
}

const kWeekDays = [
  DateTime.sunday,
  DateTime.monday,
  DateTime.thursday,
  DateTime.wednesday,
  DateTime.thursday,
  DateTime.friday,
  DateTime.saturday
];
