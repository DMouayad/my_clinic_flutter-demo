import 'package:clinic_v2/core/features/users/domain/src/repositories/base_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'user_bloc.dart';

class AppUserBlocEventsHandler {
  final BaseAppUserRepository _userRepository;

  AppUserBlocEventsHandler(this._userRepository);

  UserState getSelectedLocaleState() => _getState(_getSelectedLocale());
  UserState getSelectedThemeState() => _getState(_getSelectedThemeMode());
  Future<UserState> getLoggingOutState() async => _getState(await _logout());
  Future<UserState> getUpdatingSelectedLocaleState(Locale locale) async {
    return _getState(await _updateSelectedLocale(locale));
  }

  Future<UserState> getUpdatingSelectedThemeState(ThemeMode themeMode) async {
    return _getState(await _updateSelectedThemeMode(themeMode));
  }

  Either<FetchingUserDataError, LocalePreferenceProvided> _getSelectedLocale() {
    final response = _userRepository.getSelectedLocale();
    if (response.success) {
      return Right(
        LocalePreferenceProvided(response.result ?? const Locale('en')),
      );
    } else {
      return Left(FetchingUserDataError(response.error!));
    }
  }

  Either<FetchingUserDataError, ThemeModeProvided> _getSelectedThemeMode() {
    final response = _userRepository.getSelectedTheme();
    if (response.success) {
      return Right(
        ThemeModeProvided(response.result ?? ThemeMode.system),
      );
    } else {
      return Left(FetchingUserDataError(response.error!));
    }
  }

  Future<Either<UpdatingUserDataError, UserWasLoggedOut>> _logout() async {
    final response = await _userRepository.deleteLocalData();
    if (response.success) {
      return Right(UserWasLoggedOut());
    } else {
      return Left(UpdatingUserDataError(response.error!));
    }
  }

  Future<Either<UpdatingUserDataError, UserLocaleUpdated>>
      _updateSelectedLocale(Locale locale) async {
    final response = await _userRepository.updateSelectedLocal(locale);
    if (response.success) {
      return Right(UserLocaleUpdated());
    } else {
      return Left(UpdatingUserDataError(response.error!));
    }
  }

  Future<Either<UpdatingUserDataError, UserThemeModeUpdated>>
      _updateSelectedThemeMode(ThemeMode themeMode) async {
    final response = await _userRepository.updateSelectedTheme(themeMode);
    if (response.success) {
      return Right(UserThemeModeUpdated());
    } else {
      return Left(UpdatingUserDataError(response.error!));
    }
  }

  UserState _getState(Either<UserState, UserState> eitherResult) {
    return eitherResult.fold((l) => l, (r) => r);
  }
}
