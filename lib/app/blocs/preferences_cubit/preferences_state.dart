part of 'preferences_cubit.dart';

abstract class PreferencesState extends Equatable {
  const PreferencesState();

  @override
  List<Object> get props => [];
}

class PreferencesInitial extends PreferencesState {
  const PreferencesInitial();
}

abstract class PreferencesStateWithData extends PreferencesState {
  const PreferencesStateWithData(this.themeMode, this.locale);

  final ThemeMode themeMode;
  final Locale locale;

  @override
  List<Object> get props => [themeMode, locale];

  PreferencesStateWithData copyWith({ThemeMode? themeMode, Locale? locale});
}

class DefaultPreferencesState extends PreferencesStateWithData {
  const DefaultPreferencesState(super.themeMode, super.locale);

  @override
  DefaultPreferencesState copyWith({ThemeMode? themeMode, Locale? locale}) {
    return DefaultPreferencesState(
        themeMode ?? this.themeMode, locale ?? this.locale);
  }
}

class UserPreferencesState extends PreferencesStateWithData {
  const UserPreferencesState(super.themeMode, super.locale);

  @override
  UserPreferencesState copyWith({ThemeMode? themeMode, Locale? locale}) {
    return UserPreferencesState(
        themeMode ?? this.themeMode, locale ?? this.locale);
  }
}
