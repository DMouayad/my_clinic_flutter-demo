part of 'user_calendar.dart';

class CalendarWorkDay {
  final int day;
  final List<TimeOfDay> workHours;

  CalendarWorkDay({
    required this.day,
    required this.workHours,
  });

  CalendarWorkDay copyWith({
    int? day,
    List<TimeOfDay>? workHours,
  }) {
    return CalendarWorkDay(
      day: day ?? this.day,
      workHours: workHours ?? this.workHours,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'workHours': workHours
          .map((timeOfDay) => TimeOfDayJsonHelper.toJson(timeOfDay))
          .toList(),
    };
  }

  factory CalendarWorkDay.fromMap(Map<String, dynamic> map) {
    return CalendarWorkDay(
      day: map['day'].toInt(),
      workHours: List<TimeOfDay>.from(
        map['workHours'].map(
          (timeOfDayJson) => TimeOfDayJsonHelper.fromJson(timeOfDayJson),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarWorkDay.fromJson(String source) =>
      CalendarWorkDay.fromMap(json.decode(source));

  @override
  String toString() => 'CalendarWorkDay(day: $day, workHours: $workHours)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarWorkDay &&
        other.day == day &&
        listEquals(other.workHours, workHours);
  }

  @override
  int get hashCode => day.hashCode ^ workHours.hashCode;
}
