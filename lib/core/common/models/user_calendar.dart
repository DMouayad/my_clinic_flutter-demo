import 'dart:convert';

import 'package:clinic_v2/core/common/helpers/time_of_day_json_helper.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
part 'calendar_work_day.dart';

class UserCalendar {
  final List<CalendarWorkDay> calendarWorkDays;

  UserCalendar({required this.calendarWorkDays});
  List<TimeOfDay> getWorkHoursOfDay(int day) {
    return calendarWorkDays
        .firstWhere((calendarDay) => calendarDay.day == day)
        .workHours;
  }

  List<int> get holidays {
    final _workDaysNumbers = calendarWorkDays.map((workDay) => workDay.day);
    return _dateTimeWeekDays
        .takeWhile(
          (element) => !_workDaysNumbers.contains(element),
        )
        .toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'calendarWorkDays': calendarWorkDays
          .map((calendarWorkDay) => calendarWorkDay.toMap())
          .toList(),
    };
  }

  factory UserCalendar.fromMap(Map<String, dynamic> map) {
    return UserCalendar(
      calendarWorkDays: List<CalendarWorkDay>.from(
        map['calendarWorkDays']?.map(
          (calendarWorkDayJson) => CalendarWorkDay.fromMap(calendarWorkDayJson),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCalendar.fromJson(String source) =>
      UserCalendar.fromMap(json.decode(source));

  UserCalendar copyWith({List<CalendarWorkDay>? calendarWorkDays}) {
    return UserCalendar(
        calendarWorkDays: calendarWorkDays ?? this.calendarWorkDays);
  }

  @override
  String toString() => 'UserCalendar(calendarWorkDays: $calendarWorkDays)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserCalendar &&
        listEquals(other.calendarWorkDays, calendarWorkDays);
  }

  @override
  int get hashCode => calendarWorkDays.hashCode;
}

const _dateTimeWeekDays = [
  DateTime.sunday,
  DateTime.monday,
  DateTime.thursday,
  DateTime.wednesday,
  DateTime.thursday,
  DateTime.friday,
  DateTime.saturday
];
