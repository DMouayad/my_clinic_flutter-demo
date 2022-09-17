import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'preferences_state.dart';

/// Manages user's preferences of app locale and themeMode.
/// The purpose of this cubit is to provide the preferences
/// based on user choices.
class PreferencesCubit extends Cubit<PreferencesState> {
  PreferencesCubit() : super(const AppearancePreferencesInitial());
  void provideLocale(Locale locale) {
    if (state is UserPreferencesState) {
      emit(
        (state as UserPreferencesState).copyWith(locale: locale),
      );
    } else {
      emit(UserPreferencesState(locale: locale));
    }
  }

  void provideThemeMode(ThemeMode themeMode) {
    if (state is UserPreferencesState) {
      emit(
        (state as UserPreferencesState).copyWith(themeMode: themeMode),
      );
    } else {
      emit(UserPreferencesState(themeMode: themeMode));
    }
  }
}
