import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'preferences_state.dart';

/// Manages user's preferences of app locale and themeMode.
/// The purpose of this cubit is to set then provide the preferences
/// based on user choices.
class AppearancePreferencesCubit
    extends HydratedCubit<AppearancePreferencesState> {
  AppearancePreferencesCubit() : super(const AppearancePreferencesInitial()) {
    hydrate();
  }
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

  @override
  AppearancePreferencesState? fromJson(Map<String, dynamic> json) {
    return UserPreferencesState(
      locale: json['language_code'] != null
          ? Locale.fromSubtags(languageCode: json['language_code'])
          : null,
      themeMode: json['theme_mode_index'] != null
          ? ThemeMode.values.elementAt(json['theme_mode_index'])
          : null,
    );
  }

  @override
  Map<String, dynamic>? toJson(AppearancePreferencesState state) {
    if (state is UserPreferencesState) {
      return {
        'language_code': state.locale?.languageCode,
        'theme_mode_index': state.themeMode?.index,
      };
    }
  }
}
