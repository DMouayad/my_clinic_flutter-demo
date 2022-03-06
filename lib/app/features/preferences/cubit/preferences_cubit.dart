import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'preferences_state.dart';

/// Manages user's preferences of app locale and themeMode.
/// The purpose of this cubit is to set then provide the preferences
/// based on user choices.
class PreferencesCubit extends Cubit<PreferencesState> {
  PreferencesCubit() : super(const PreferencesInitial());
  void provideLocale(Locale locale) {
    emit(LocalePreferenceProvided(locale));
    // emit(PreferencesChanged());
  }

  void provideThemeMode(ThemeMode themeMode) {
    emit(ThemeModePreferenceProvided(themeMode));
    // emit(PreferencesChanged());
  }
}
