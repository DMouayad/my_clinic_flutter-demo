import 'dart:convert';

import 'package:clinic_v2/core/common/helpers/time_of_day_json_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class WorkShift extends Equatable {
  final TimeOfDay start;
  final TimeOfDay end;
  final List<int> days;

  const WorkShift({
    required this.start,
    required this.end,
    required this.days,
  });

  DateTime get startDateTime {
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day, start.hour, start.minute);
  }

  DateTime get endDateTime {
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day, end.hour, end.minute);
  }

  Duration get duration {
    return endDateTime.difference(startDateTime);
  }

  Map<String, dynamic> toMap() {
    return {
      'start': TimeOfDayHelper.toJson(start),
      'end': TimeOfDayHelper.toJson(end),
      'days': days,
    };
  }

  factory WorkShift.fromMap(Map<String, dynamic> map) {
    return WorkShift(
      start: TimeOfDayHelper.fromJson(map['start']),
      end: TimeOfDayHelper.fromJson(map['end']),
      days: List<int>.from(map['days']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkShift.fromJson(String source) =>
      WorkShift.fromMap(json.decode(source));

  WorkShift copyWith({
    TimeOfDay? start,
    TimeOfDay? end,
    List<int>? days,
  }) {
    return WorkShift(
      start: start ?? this.start,
      end: end ?? this.end,
      days: days ?? this.days,
    );
  }

  @override
  String toString() => 'WorkShift(start: $start, end: $end, days: $days)';

  @override
  List<Object?> get props => [start, end, days];
}
/*
mixin _WorkShiftHelperFunctions on WorkShift {

  List<WorkShift> splitIntoTwoShifts(){
    final int newShiftsWorkDays = (days.length /2).r;
    List<int> firstShiftDays=days.getRange(0, shiftWorkDaysNumber/2);
    List<int> secondShiftDays=[];


   return [
     WorkShift(start: start.hour, end: end, days: days.removeRange(0, end))
   ]
  }
}*/
