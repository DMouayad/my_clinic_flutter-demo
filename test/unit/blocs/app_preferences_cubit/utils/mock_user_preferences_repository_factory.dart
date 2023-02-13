import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences_repository.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../shared/base_repository_factory.dart';
import 'fake_user_preferences.dart';
@GenerateNiceMocks([MockSpec<BaseUserPreferencesRepository>()])
import 'user_preferences_repository_mock_factory.mocks.dart';

class UserPreferencesRepositoryFactory
    extends BaseRepositoryFactory<BaseUserPreferencesRepository> {
  final MockBaseUserPreferencesRepository _repository;
  late final Result<VoidValue, AppError> createUserPrefsResult;
  late final Result<VoidValue, AppError> loadUserPrefsResult;
  late final Result<VoidValue, AppError> updateUserLocalePreferenceResult;
  late final Result<VoidValue, AppError> updateUserThemePreferenceResult;

  ThemeMode? _userThemeMode;
  Locale? _userLocale;

  factory UserPreferencesRepositoryFactory() {
    return UserPreferencesRepositoryFactory._(
        MockBaseUserPreferencesRepository());
  }

  UserPreferencesRepositoryFactory._(
    this._repository, {
    ThemeMode? themeMode,
    Locale? locale,
    Result<VoidValue, AppError>? createUserPrefsResult,
    Result<VoidValue, AppError>? loadUserPrefsResult,
    Result<VoidValue, AppError>? updateUserLocalePreferenceResult,
    Result<VoidValue, AppError>? updateUserThemePreferenceResult,
  }) {
    _userThemeMode = themeMode;
    _userLocale = locale;
    this.createUserPrefsResult =
        createUserPrefsResult ?? SuccessResult.voidResult();
    this.updateUserLocalePreferenceResult =
        updateUserLocalePreferenceResult ?? SuccessResult.voidResult();
    this.updateUserThemePreferenceResult =
        updateUserThemePreferenceResult ?? SuccessResult.voidResult();
    this.loadUserPrefsResult =
        loadUserPrefsResult ?? SuccessResult.voidResult();
  }

  UserPreferencesRepositoryFactory setupWith({
    ThemeMode? currentUserThemeMode,
    Locale? currentUserLocale,
    Result<VoidValue, AppError>? loadUserPrefsResult,
    Result<VoidValue, AppError>? createUserPrefsResult,
    Result<VoidValue, AppError>? updateUserLocalePreferenceResult,
    Result<VoidValue, AppError>? updateUserThemePreferenceResult,
  }) {
    return UserPreferencesRepositoryFactory._(
      _repository,
      themeMode: currentUserThemeMode ?? _userThemeMode,
      locale: currentUserLocale ?? _userLocale,
      createUserPrefsResult:
          createUserPrefsResult ?? this.createUserPrefsResult,
      updateUserLocalePreferenceResult: updateUserLocalePreferenceResult ??
          this.updateUserLocalePreferenceResult,
      updateUserThemePreferenceResult: updateUserThemePreferenceResult ??
          this.updateUserThemePreferenceResult,
      loadUserPrefsResult: loadUserPrefsResult ?? this.loadUserPrefsResult,
    );
  }

  @override
  MockBaseUserPreferencesRepository create() {
    when(_repository.getUserPreferences()).thenReturn(() {
      return (_userLocale != null && _userThemeMode != null)
          ? FakeUserPreferences(
              localePreference: _userLocale!,
              themePreference: _userThemeMode!,
            )
          : null;
    }());

    when(_repository.createUserPreferences(any, any))
        .thenAnswer((realInvocation) async {
      _userThemeMode = realInvocation.positionalArguments[0];
      _userLocale = realInvocation.positionalArguments[1];
      return createUserPrefsResult;
    });
    when(_repository.setUserPreferences(any)).thenAnswer((realInvocation) {
      final value = realInvocation.positionalArguments[0];
      if (value is BaseUserPreferences?) {
        _userThemeMode = value?.themePreference;
        _userLocale = value?.localePreference;
      }
    });
    when(_repository.updateUserLocalePreference(any))
        .thenAnswer((realInvocation) async {
      _userLocale = realInvocation.positionalArguments[0];
      return updateUserLocalePreferenceResult;
    });

    when(_repository.updateUserThemePreference(any))
        .thenAnswer((realInvocation) async {
      _userThemeMode = realInvocation.positionalArguments[0];
      return updateUserThemePreferenceResult;
    });
    when(_repository.loadUserPreferences()).thenAnswer((_) async {
      return loadUserPrefsResult;
    });
    return _repository;
  }
}
