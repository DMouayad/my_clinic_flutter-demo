import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences_repository.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fake_user_preferences.dart';
@GenerateNiceMocks([MockSpec<BaseUserPreferencesRepository>()])
import 'user_preferences_repository_mock_factory.mocks.dart';

class UserPreferencesRepositoryMockFactory {
  final MockBaseUserPreferencesRepository _repository;
  late final Result<VoidValue, AppError> setUserPrefsResult;
  late final Result<VoidValue, AppError> loadUserPrefsResult;
  late final Result<VoidValue, AppError> updateUserLocalePreferenceResult;
  late final Result<VoidValue, AppError> updateUserThemePreferenceResult;

  late ThemeMode _themeMode;
  late Locale _locale;

  factory UserPreferencesRepositoryMockFactory() {
    return UserPreferencesRepositoryMockFactory._(
        MockBaseUserPreferencesRepository());
  }
  UserPreferencesRepositoryMockFactory._(
    this._repository, {
    ThemeMode? themeMode,
    Locale? locale,
    Result<VoidValue, AppError>? setUserPrefsResult,
    Result<VoidValue, AppError>? loadUserPrefsResult,
    Result<VoidValue, AppError>? updateUserLocalePreferenceResult,
    Result<VoidValue, AppError>? updateUserThemePreferenceResult,
  }) {
    _themeMode = themeMode ?? ThemeMode.dark;
    _locale = locale ?? const Locale('en');
    this.setUserPrefsResult = setUserPrefsResult ?? SuccessResult.voidResult();
    this.updateUserLocalePreferenceResult =
        updateUserLocalePreferenceResult ?? SuccessResult.voidResult();
    this.updateUserThemePreferenceResult =
        updateUserThemePreferenceResult ?? SuccessResult.voidResult();
    this.loadUserPrefsResult =
        loadUserPrefsResult ?? SuccessResult.voidResult();
  }

  UserPreferencesRepositoryMockFactory setupWith({
    ThemeMode? themeMode,
    Locale? locale,
    Result<VoidValue, AppError>? loadUserPrefsResult,
    Result<VoidValue, AppError>? setUserPrefsResult,
    Result<VoidValue, AppError>? updateUserLocalePreferenceResult,
    Result<VoidValue, AppError>? updateUserThemePreferenceResult,
  }) {
    return UserPreferencesRepositoryMockFactory._(
      _repository,
      themeMode: themeMode ?? _themeMode,
      locale: locale ?? _locale,
      setUserPrefsResult: setUserPrefsResult ?? this.setUserPrefsResult,
      updateUserLocalePreferenceResult: updateUserLocalePreferenceResult ??
          this.updateUserLocalePreferenceResult,
      updateUserThemePreferenceResult: updateUserThemePreferenceResult ??
          this.updateUserThemePreferenceResult,
      loadUserPrefsResult: loadUserPrefsResult ?? this.loadUserPrefsResult,
    );
  }

  MockBaseUserPreferencesRepository create() {
    when(_repository.preferences).thenReturn(FakeUserPreferences(
      localePreference: _locale,
      themePreference: _themeMode,
    ));
    when(_repository.setUserPreferences(any, any))
        .thenAnswer((realInvocation) async {
      _themeMode = realInvocation.positionalArguments[0];
      _locale = realInvocation.positionalArguments[1];
      return setUserPrefsResult;
    });
    when(_repository.updateUserLocalePreference(any))
        .thenAnswer((realInvocation) async {
      _locale = realInvocation.positionalArguments[0];
      return updateUserLocalePreferenceResult;
    });

    when(_repository.updateUserThemePreference(any))
        .thenAnswer((realInvocation) async {
      _themeMode = realInvocation.positionalArguments[0];
      return updateUserThemePreferenceResult;
    });
    when(_repository.loadUserPreferences()).thenAnswer((realInvocation) async {
      return loadUserPrefsResult;
    });
    return _repository;
  }
}
