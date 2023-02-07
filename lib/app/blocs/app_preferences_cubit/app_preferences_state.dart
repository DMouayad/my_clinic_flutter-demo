part of 'app_preferences_cubit.dart';

abstract class AppPreferencesState extends Equatable {
  const AppPreferencesState();

  @override
  List<Object> get props => [];
}

class AppPreferencesInitial extends AppPreferencesState {
  const AppPreferencesInitial();
}

class UpdatingUserPreferencesInProgress extends AppPreferencesState {
  const UpdatingUserPreferencesInProgress();
}

class UserPreferencesUpdatedSuccessfully extends AppPreferencesState {}

class UpdatingUserPreferencesFailed extends AppPreferencesState {
  final AppError error;

  const UpdatingUserPreferencesFailed(this.error);
}

abstract class AppPreferencesStateWithData extends AppPreferencesState {
  const AppPreferencesStateWithData(this.themeMode, this.locale);

  final ThemeMode themeMode;
  final Locale locale;

  @override
  List<Object> get props => [themeMode, locale];

  AppPreferencesStateWithData copyWith({ThemeMode? themeMode, Locale? locale});
}

class AppPreferences extends AppPreferencesStateWithData {
  const AppPreferences(super.themeMode, super.locale);

  @override
  AppPreferences copyWith({ThemeMode? themeMode, Locale? locale}) {
    return AppPreferences(themeMode ?? this.themeMode, locale ?? this.locale);
  }
}
