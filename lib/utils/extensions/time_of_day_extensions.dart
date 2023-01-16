import 'package:flutter/material.dart';

extension TimeOfDayUtils on TimeOfDay {
  bool isAfter(TimeOfDay other) {
    return (other.hour == hour) ? minute > other.minute : hour > other.hour;
  }

  bool isBefore(TimeOfDay other) {
    return (other.hour == hour) ? minute < other.minute : hour < other.hour;
  }
}
