import 'dart:async';

import 'package:clinic_v2/domain/authentication/base/base_auth_repository.dart';
import 'package:clinic_v2/shared/models/error/basic_error.dart';
import 'package:clinic_v2/domain/authentication/base/base_server_user.dart';
import 'package:clinic_v2/shared/services/logger_service.dart';

//
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/shared/models/result/result.dart';

part 'states/auth_state.dart';

part 'states/sign_up_state.dart';

part 'auth_event.dart';

part 'states/login_state.dart';

part 'auth_events_helper.dart';

part 'states/auth_init_state.dart';

part 'states/logout_state.dart';

/// Manages
class AuthBloc extends Bloc<AuthEvent, AuthState> with AuthEventsHelper {
  final BaseAuthRepository authRepository;
  late final StreamSubscription<BaseServerUser?> _usersStreamSub;
  final bool shouldLogTransitions;

  AuthBloc(this.authRepository, {this.shouldLogTransitions = true})
      : super(const AuthInitial()) {
    _usersStreamSub = authRepository.usersStream.listen((user) {
      if (state is! AuthInitFailed) {
        add(AuthStatusCheckRequested(user));
      }
    });

    on<AuthStatusCheckRequested>(
      (event, emit) {
        if (event.user != null) {
          emit(AuthHasLoggedInUser(event.user!));
        } else if (state is! AuthHasNoLoggedInUser) {
          const AuthHasNoLoggedInUser();
        }
      },
    );
    on<AuthInitRequested>((event, emit) async {
      if (state != const AuthInitInProgress()) emit(const AuthInitInProgress());

      await getAuthInitState(authRepository).then((state) {
        if (state != null) {
          emit(state);
        }
      });
    });
    on<LoginRequested>((event, emit) async {
      if (state != const LoginInProgress()) emit(const LoginInProgress());
      await getLoginState(
        authRepository,
        email: event.email,
        password: event.password,
      ).then((state) => emit(state));
    });

    on<SignUpRequested>((event, emit) async {
      if (state != const SignUpInProgress()) emit(const SignUpInProgress());

      await getSignUpState(
        authRepository,
        email: event.email,
        username: event.username,
        phoneNumber: event.phoneNumber,
        password: event.password,
      ).then((state) => emit(state));
    });
    on<LogoutRequested>((event, emit) async {
      if (state is! LogoutInProgress) emit(const LogoutInProgress());
      await getLogoutState(authRepository).then((state) => emit(state));
    });
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    if (shouldLogTransitions) {
      Log.logBlocTransition(this, transition);
    }
    super.onTransition(transition);
  }

  @override
  Future<void> close() async {
    await _usersStreamSub.cancel();
    return super.close();
  }
}
