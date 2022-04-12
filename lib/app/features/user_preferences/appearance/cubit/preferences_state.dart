part of 'preferences_cubit.dart';

abstract class AppearancePreferencesState extends Equatable {
  const AppearancePreferencesState();

  @override
  List<Object> get props => [];
}

class AppearancePreferencesInitial extends AppearancePreferencesState {
  const AppearancePreferencesInitial();
}

class UserPreferencesState extends AppearancePreferencesState {
  final Locale? locale;
  final ThemeMode? themeMode;
  const UserPreferencesState({this.locale, this.themeMode});

  @override
  List<Object> get props => [
        [locale, themeMode]
      ];

  UserPreferencesState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
  }) {
    return UserPreferencesState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  String toString() =>
      'UserPreferencesState(locale: $locale, themeMode: $themeMode)';
}
