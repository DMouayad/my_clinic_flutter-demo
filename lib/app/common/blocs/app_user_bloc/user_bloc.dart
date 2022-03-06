import 'package:clinic_v2/core/features/users/domain/src/repositories/base_user_repository.dart';
import 'package:flutter/material.dart';
//
import 'package:clinic_v2/core/common/models/custom_error.dart';
//
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'events_handler.dart';
//
part 'user_event.dart';
part 'user_state.dart';

class UserBloc<E extends UserEvent, S extends UserState>
    extends Bloc<UserEvent, UserState> {
  late final BaseAppUserRepository _userRepository;
  late final AppUserBlocEventsHandler _eventsHandler;

  UserBloc({
    required BaseAppUserRepository userRepository,
    required S initState,
  }) : super(initState) {
    _userRepository = userRepository;
    _eventsHandler = AppUserBlocEventsHandler(_userRepository);

    on<UserLocaleRequested>(
      (event, emit) => emit(_eventsHandler.getSelectedLocaleState()),
    );
    on<UserThemeRequested>(
      (event, emit) => emit(_eventsHandler.getSelectedThemeState()),
    );
    on<UserLogoutRequested>(
      (event, emit) async => emit(await _eventsHandler.getLoggingOutState()),
    );
    on<UserLocaleUpdateRequested>((event, emit) async {
      emit(
        (await _eventsHandler.getUpdatingSelectedLocaleState(event.newLocale)),
      );
    });
    on<UserThemeUpdateRequested>(
      (event, emit) async {
        emit(
          (await _eventsHandler
              .getUpdatingSelectedThemeState(event.newThemeMode)),
        );
      },
    );
  }
}
