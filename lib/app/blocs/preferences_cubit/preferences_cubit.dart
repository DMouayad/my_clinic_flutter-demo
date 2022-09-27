import 'package:flutter/material.dart';
//
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/services/logger_service.dart';
import 'package:clinic_v2/app/features/user_preferences/domain/src/base_user_preferences.dart';
part 'preferences_state.dart';

/// Manages user's preferences of app locale and themeMode.
/// The purpose of this cubit is to provide the preferences
/// based on user choices.
class PreferencesCubit extends Cubit<PreferencesState> {
  PreferencesCubit() : super(const PreferencesInitial());

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
