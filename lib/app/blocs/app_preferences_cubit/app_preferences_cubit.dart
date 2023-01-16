import 'package:clinic_v2/domain/user_preferences/base/base_user_preferences_repository.dart';
import 'package:flutter/material.dart';
//
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/shared/services/logger_service.dart';
part 'app_preferences_state.dart';

/// Manages user preferences of the app's locale and themeMode.
/// The purpose of this cubit is to provide the preferences
/// based on user choices.
class AppPreferencesCubit extends Cubit<AppPreferencesState> {
  AppPreferencesCubit(this._repository, {this.shouldLogCubitChange = true})
      : super(const AppPreferencesInitial());

  final BaseUserPreferencesRepository _repository;
  final bool shouldLogCubitChange;

  void updateAppTheme(ThemeMode themeMode) {
    assert(state is AppPreferences);
    emit((state as AppPreferences).copyWith(themeMode: themeMode));
  }

  void updateAppLocale(Locale locale) {
    assert(state is AppPreferences);
    emit((state as AppPreferences).copyWith(locale: locale));
  }

  void setAppPreferences(ThemeMode themeMode, Locale locale) {
    emit(AppPreferences(themeMode, locale));
  }

  void setUserPreferences(ThemeMode themeMode, Locale locale) {
    _repository.setUserPreferences(themeMode, locale);
  }

  @override
  void onChange(Change<AppPreferencesState> change) {
    if (shouldLogCubitChange) {
      Log.logCubitChange(this, change);
    }
    super.onChange(change);
  }
}
