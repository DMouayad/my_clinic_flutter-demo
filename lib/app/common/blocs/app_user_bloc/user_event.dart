part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  Future<UserState> when({
    required Future<UserState> Function(UserLocaleRequested)
        userLocaleRequested,
    required Future<UserState> Function(UserThemeRequested) userThemeRequested,
    required Future<UserState> Function(UserLocaleUpdateRequested)
        userLocaleUpdateRequested,
    required Future<UserState> Function(UserThemeUpdateRequested)
        userThemeUpdateRequested,
  }) async {
    if (this is UserLocaleRequested) {
      return await userLocaleRequested.call(this as UserLocaleRequested);
    }

    if (this is UserThemeRequested) {
      return await userThemeRequested.call(this as UserThemeRequested);
    }

    if (this is UserLocaleUpdateRequested) {
      return await userLocaleUpdateRequested
          .call(this as UserLocaleUpdateRequested);
    }

    if (this is UserThemeUpdateRequested) {
      return await userThemeUpdateRequested
          .call(this as UserThemeUpdateRequested);
    }

    throw UnimplementedError('UserEvent not handled');
  }

  @override
  List<Object?> get props => [];
}

class UserLocaleRequested extends UserEvent {}

class UserThemeRequested extends UserEvent {}

class UserLogoutRequested extends UserEvent {}

class UserLocaleUpdateRequested extends UserEvent {
  final Locale newLocale;

  const UserLocaleUpdateRequested(this.newLocale);
  @override
  List<Object> get props => [newLocale];
}

class UserThemeUpdateRequested extends UserEvent {
  final ThemeMode newThemeMode;
  @override
  List<Object> get props => [newThemeMode];

  const UserThemeUpdateRequested(this.newThemeMode);
}
