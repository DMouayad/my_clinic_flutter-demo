import 'package:flutter/material.dart';

class TimeOfDayHelper {
  static Map<String, dynamic> toJson(TimeOfDay timeOfDay) {
    return {
      'hour': timeOfDay.hour,
      'minute': timeOfDay.minute,
    };
  }

  static TimeOfDay fromJson(Map<String, dynamic> json) {
    return TimeOfDay(
      hour: json['hour'],
      minute: json['minute'],
    );
  }
}
