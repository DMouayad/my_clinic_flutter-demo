import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences.dart';
import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences_repository.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
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
  Future<void> updateAppTheme(
    ThemeMode themeMode, {
    required Locale currentLocale,
  }) async {
    // if a user is logged in then the repository has the prefs of this user
    if (_repository.userPreferences != null) {
      _processUpdatingUserPrefs(
        await _repository.updateUserThemePreference(themeMode),
        AppPreferences(
            themeMode, _repository.userPreferences!.localePreference),
      );
    } else {
      emit(AppPreferences(themeMode, currentLocale));
    }
  }

  /// Updates the app's [Locale]
  ///
  /// If there's a logged-in user, it'll also update his prefs
  Future<void> updateAppLocale(
    Locale locale, {
    required ThemeMode currentTheme,
  }) async {
    // if a user is logged in then the repository has the prefs of this user
    if (_repository.userPreferences != null) {
      _processUpdatingUserPrefs(
        await _repository.updateUserLocalePreference(locale),
        AppPreferences(_repository.userPreferences!.themePreference, locale),
      );
    } else {
      emit(AppPreferences(currentTheme, locale));
    }
  }

  Future<void> _processUpdatingUserPrefs(
    Result<VoidValue, BasicError> result,
    AppPreferences newState,
  ) async {
    emit(const UpdatingUserPreferencesInProgress());
    await Future.delayed(const Duration(seconds: 3));
    (result).fold(
      ifFailure: (error) {
        emit(UpdatingUserPreferencesFailed(error));
      },
      ifSuccess: (_) {
        emit(UserPreferencesUpdatedSuccessfully());
        Future.delayed(
          const Duration(seconds: 1),
          () => emit(newState),
        );
      },
    );
  }

  void resetUserPreferences() {
    _repository.userPreferences = null;
  }

  void setUserPreferences(ThemeMode themeMode, Locale locale) {
    _repository.setUserPreferences(themeMode, locale);
  }

  void setInitialAppPreferences(ThemeMode themeMode, Locale locale) {
    emit(AppPreferences(themeMode, locale));
  }

  void processUserPreferences(
    BaseUserPreferences? userPreferences,
    BuildContext context,
  ) {
    if (userPreferences != null) {
      _repository.userPreferences = userPreferences;
      emit(AppPreferences(
        userPreferences.themePreference,
        userPreferences.localePreference,
      ));
    } else {
      setUserPreferences(context.themeMode, context.locale);
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
