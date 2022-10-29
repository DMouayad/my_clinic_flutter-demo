import 'package:clinic_v2/app/features/user_preferences/domain/base_user_preferences.dart';
import 'package:clinic_v2/app/features/user_preferences/domain/base_user_preferences_repository.dart';
import 'package:flutter/material.dart';
//
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/services/logger_service.dart';
part 'preferences_state.dart';

/// Manages user's preferences of app locale and themeMode.
/// The purpose of this cubit is to provide the preferences
/// based on user choices.
class PreferencesCubit extends Cubit<PreferencesState> {
  PreferencesCubit(this._repository) : super(const PreferencesInitial());
  final BaseUserPreferencesRepository _repository;

  void updateAppTheme(ThemeMode themeMode) {
    if (state is DefaultPreferencesState) {
      emit((state as DefaultPreferencesState).copyWith(themeMode: themeMode));
    } else if (state is UserPreferencesState) {
      emit((state as UserPreferencesState).copyWith(themeMode: themeMode));
      _repository.updateUserThemePreference(themeMode);
    }
  }

  void updateAppLocale(Locale locale) {
    if (state is DefaultPreferencesState) {
      emit((state as DefaultPreferencesState).copyWith(locale: locale));
    } else if (state is UserPreferencesState) {
      emit((state as UserPreferencesState).copyWith(locale: locale));
      _repository.updateUserLocalePreference(locale);
    }
  }

  void setUserPreferences(ThemeMode theme, Locale locale) {
    _repository.setUserPreferences(theme, locale);
  }

  void provideUserPreferences(BaseUserPreferences? preferences) {
    if (preferences != null) {
      emit(UserPreferencesState(
          preferences.themePreference, preferences.localePreference));
    }
  }

  void provideDefaultPreferences(ThemeMode theme, Locale locale) {
    emit(DefaultPreferencesState(theme, locale));
  }

  @override
  void onChange(Change<PreferencesState> change) {
    Log.logCubitChange(this, change);
    super.onChange(change);
  }
}
