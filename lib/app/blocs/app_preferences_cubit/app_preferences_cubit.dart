import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences.dart';
import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences_repository.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:flutter/material.dart';

//
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/shared/services/logger_service.dart';

part 'app_preferences_state.dart';

/// Manages user userPreferences of the app's locale and themeMode.
/// The purpose of this cubit is to provide the userPreferences
/// based on user choices.
class AppPreferencesCubit extends Cubit<AppPreferencesState> {
  AppPreferencesCubit(this._repository, {this.shouldLogCubitChange = true})
      : super(const AppPreferencesInitial());

  final BaseUserPreferencesRepository _repository;
  final bool shouldLogCubitChange;

  /// Updates the app's [ThemeMode]
  ///
  /// If there's a logged-in user, it'll also update his prefs
  Future<void> setAppThemeMode(
    ThemeMode themeMode, {
    required Locale currentLocale,
  }) async {
    // if a user is logged in then the repository has the prefs of this user
    if (_repository.getUserPreferences() != null) {
      _processUpdatingUserPrefs(
        await _repository.updateUserThemePreference(themeMode),
        AppPreferences(
            themeMode, _repository.getUserPreferences()!.localePreference),
      );
    } else {
      emit(AppPreferences(themeMode, currentLocale));
    }
  }

  /// Updates the app's [Locale]
  ///
  /// If there's a logged-in user, it'll also update his prefs
  Future<void> setAppLocale(
    Locale locale, {
    required ThemeMode currentTheme,
  }) async {
    // if a user is logged in then the repository has the prefs of this user
    if (_repository.getUserPreferences() != null) {
      _processUpdatingUserPrefs(
        await _repository.updateUserLocalePreference(locale),
        AppPreferences(
            _repository.getUserPreferences()!.themePreference, locale),
      );
    } else {
      emit(AppPreferences(currentTheme, locale));
    }
  }

  Future<void> _processUpdatingUserPrefs(
    Result<VoidValue, AppError> result,
    AppPreferences newState,
  ) async {
    emit(const UpdatingUserPreferencesInProgress());
    // await Future.delayed(const Duration(seconds: 2));
    (result).fold(
      ifFailure: (error) {
        emit(UpdatingUserPreferencesFailed(error));
      },
      ifSuccess: (_) {
        emit(const UserPreferencesUpdatedSuccessfully());
        Future.delayed(
          const Duration(seconds: 1),
          () => emit(newState),
        );
      },
    );
  }

  void resetUserPreferences() {
    _repository.setUserPreferences(null);
  }

  void processUserPreferences(
    BaseUserPreferences? userPreferences, {
    required ThemeMode appThemeMode,
    required Locale appLocale,
  }) {
    if (userPreferences != null) {
      _repository.setUserPreferences(userPreferences);
      emit(AppPreferences(
        userPreferences.themePreference,
        userPreferences.localePreference,
      ));
    } else {
      _repository.createUserPreferences(appThemeMode, appLocale);
      emit(AppPreferences(
        appThemeMode,
        appLocale,
      ));
    }
  }

  @override
  void onChange(Change<AppPreferencesState> change) {
    if (shouldLogCubitChange) {
      Log.logCubitChange(this, change);
    }
    super.onChange(change);
  }
}
