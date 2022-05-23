import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:clinic_v2/core/common/helpers/time_of_day_json_helper.dart';

class WorkShift {
  final TimeOfDay start;
  final TimeOfDay end;
  final List<int> days;

  WorkShift({
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

  Map<String, dynamic> toMap() {
    return {
      'start': TimeOfDayJsonHelper.toJson(start),
      'end': TimeOfDayJsonHelper.toJson(end),
      'days': days,
    };
  }

  factory WorkShift.fromMap(Map<String, dynamic> map) {
    return WorkShift(
      start: TimeOfDayJsonHelper.fromJson(map['start']),
      end: TimeOfDayJsonHelper.fromJson(map['end']),
      days: List<int>.from(map['days']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkShift.fromJson(String source) =>
      WorkShift.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkShift &&
        other.start == start &&
        other.end == end &&
        listEquals(other.days, days);
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ days.hashCode;

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
}
