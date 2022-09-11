part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class FetchingUserDataError extends UserState {
  final BaseError error;

  const FetchingUserDataError(this.error);
  @override
  List<Object> get props => [error];
}

class UpdatingUserDataError extends UserState {
  final BaseError error;

  const UpdatingUserDataError(this.error);
  @override
  List<Object> get props => [error];
}

class UserInitial extends UserState {
  const UserInitial();
}

class LocalePreferenceProvided extends UserState {
  final Locale locale;

  const LocalePreferenceProvided(this.locale);
  @override
  List<Object> get props => [locale];
}

class ThemeModeProvided extends UserState {
  final ThemeMode themeMode;

  const ThemeModeProvided(this.themeMode);
  @override
  List<Object> get props => [themeMode];
}

class UserWasLoggedOut extends UserState {}

class UserThemeModeUpdated extends UserState {}

class UserLocaleUpdated extends UserState {}
