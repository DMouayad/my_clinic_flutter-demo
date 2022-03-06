import 'package:clinic_v2/core/common/models/custom_response.dart';
import 'package:flutter/material.dart';
import 'package:clinic_v2/core/features/users/domain/src/entities/base_app_user.dart';

abstract class BaseAppUserRepository<T extends BaseAppUser> {
  Future onInit();
  Future<T?> getStoredAppUser();

  Future<CustomResponse<NoResult>> deleteLocalData();
  Future<CustomResponse<NoResult>> saveLocally();
  Future<CustomResponse<NoResult>> saveRemotely();
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
