import 'package:clinic_v2/common/common/entities/custom_response.dart';
import 'package:flutter/material.dart';

/// All basic and common features of an app user must be declared here before it's implemented.
abstract class BaseUserDataSource {
  Future init();

  Future<Result<None>> saveLocally();
  Future<Result<None>> saveRemotely();
  Future<Result<None>> deleteLocalData();
  Result<ThemeMode?> getSelectedTheme();
  Result<Locale?> getSelectedLocale();
  Future<Result<None>> updateSelectedTheme(ThemeMode mode);
  Future<Result<None>> updateSelectedLocal(Locale locale);
  Future<Result<List<TimeOfDay>>> getWorkHours(int day);
  Future<Result<List<int>>> getNonWorkingDays();
  Future<Result<None>> updateDayWorkHours({
    required int day,
    required List<TimeOfDay> workHours,
  });
  Future<Result<None>> updateNonWorkingDays({
    required List<int> days,
  });
}
