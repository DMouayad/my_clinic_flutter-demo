import 'dart:convert';

import 'package:clinic_v2/core/common/models/user_calendar.dart';
import 'package:clinic_v2/core/common/utilities/enums.dart';
import 'package:clinic_v2/core/features/users/data/dentist_data.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';


final Map<String, dynamic> parseDentistTestJson = {
  keyVarClassName: 'Dentist',
  keyVarObjectId: 'dentist_test_id',
  'dental_services': jsonEncode([
    {
      'id': 'CU',
      'name': 'Dental check ups',
      'type': 'checkUp',
      'prices': jsonEncode([0.0]),
    }
  ]),
  'medications_list': jsonEncode([
    'Amoxicillin 500 mg',
    'Vitamin D 50000 IU',
  ]),
  'is_logged_in': true,
  'selected_locale': 'en',
  'selected_theme': 0,
  'user_calendar':
      '{"calendarWorkDays":[{"day":7,"workHours":[{"hour":10,"minute":0}]}]}'
};

/// A [ParseDentist] for tests which matches the json fixture [parseDentistTestJson]
ParseDentist get tDentistInstance {
  final tParseDentist = ParseDentist(
    dentalServices: [
      DentalService(
        'CU',
        'Dental check ups',
        type: DentalServiceType.checkUp,
        prices: [0],
      ),
    ],
    medicationsList: [
      'Amoxicillin 500 mg',
      'Vitamin D 50000 IU',
    ],
    selectedLocale: const Locale('en'),
    selectedThemeMode: ThemeMode.system,
    isLoggedIn: true,
    userCalendar: UserCalendar(
      calendarWorkDays: [
        CalendarWorkDay(
          day: DateTime.sunday,
          workHours: [const TimeOfDay(hour: 10, minute: 0)],
        ),
      ],
    ),
  )..objectId = 'dentist_test_id';

  return tParseDentist;
}
