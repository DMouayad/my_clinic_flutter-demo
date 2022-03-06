part of 'preferences_cubit.dart';

abstract class PreferencesState extends Equatable {
  const PreferencesState();

  @override
  List<Object> get props => [];
}

class PreferencesInitial extends PreferencesState {
  const PreferencesInitial();
}

class LocalePreferenceProvided extends PreferencesState {
  final Locale locale;

  const LocalePreferenceProvided(this.locale);
  @override
  List<Object> get props => [locale];
}

class ThemeModePreferenceProvided extends PreferencesState {
  final ThemeMode themeMode;

  const ThemeModePreferenceProvided(this.themeMode);
  @override
  List<Object> get props => [themeMode];
}
