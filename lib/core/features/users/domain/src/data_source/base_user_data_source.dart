
import 'package:clinic_v2/core/common/models/custom_response.dart';
import 'package:flutter/material.dart';

/// All basic and common features of an app user must be declared here before it's implemented.
abstract class BaseUserDataSource {
  Future init();

  Future<CustomResponse<NoResult>> saveLocally();
  Future<CustomResponse<NoResult>> saveRemotely();
  Future<CustomResponse<NoResult>> deleteLocalData();
  CustomResponse<ThemeMode?> getSelectedTheme();
  CustomResponse<Locale?> getSelectedLocale();
  Future<CustomResponse<NoResult>> updateSelectedTheme(ThemeMode mode);
  Future<CustomResponse<NoResult>> updateSelectedLocal(Locale locale);
  Future<CustomResponse<List<TimeOfDay>>> getWorkHours(int day);
  Future<CustomResponse<List<int>>> getNonWorkingDays();
  Future<CustomResponse<NoResult>> updateDayWorkHours({
    required int day,
    required List<TimeOfDay> workHours,
  });
  Future<CustomResponse<NoResult>> updateNonWorkingDays({
    required List<int> days,
  });
}
