import 'package:clinic_v2/common/common/entities/custom_response.dart';
import 'package:flutter/material.dart';
import 'package:clinic_v2/common/features/users/domain/src/entities/base_app_user.dart';

abstract class BaseAppUserRepository<T extends BaseAppUser> {
  Future onInit();
  Future<T?> getStoredAppUser();

  Future<Result<None>> deleteLocalData();
  Future<Result<None>> saveLocally();
  Future<Result<None>> saveRemotely();
  Result<ThemeMode?> getSelectedTheme();
  Result<Locale?> getSelectedLocale();
  Future<Result<None>> updateSelectedTheme(ThemeMode mode);
  Future<Result<None>> updateSelectedLocal(Locale locale);
}
