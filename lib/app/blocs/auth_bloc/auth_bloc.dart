import 'dart:async';

import 'package:clinic_v2/app/core/entities/error/basic_error.dart';
import 'package:clinic_v2/app/features/authentication/domain/base_auth_repository.dart';
import 'package:clinic_v2/app/features/authentication/domain/base_server_user.dart';
import 'package:clinic_v2/app/services/logger_service.dart';
//
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/core/entities/result/result.dart';

part 'auth_state.dart';
part 'sign_up_state.dart';
part 'auth_event.dart';
part 'login_state.dart';
part 'auth_events_helper.dart';

/// Manages
class AuthBloc extends Bloc<AuthEvent, AuthState> with AuthEventsHelper {
  final BaseAuthRepository authRepository;
  late final StreamSubscription<BaseServerUser?> _usersStreamSub;

  AuthBloc(this.authRepository) : super(const AuthInitial()) {
    _usersStreamSub = authRepository.usersStream.listen((user) {
      if (state is! AuthInitFailed) {
        add(AuthStatusCheckRequested(user));
      }
    });
    on<AuthStatusCheckRequested>(
      (event, emit) => emit(getAuthHasUserState(event.user, state)),
    );
    on<AuthInitRequested>((event, emit) async {
      await authInit(emit, authRepository);
    });
    on<LoginRequested>((event, emit) async {
      if (state != const LoginInProgress()) emit(const LoginInProgress());
      emit(await login(
        authRepository,
        email: event.email,
        password: event.password,
      ));
    });

    on<SignUpRequested>((event, emit) async {
      if (state != const SignUpInProgress()) emit(const SignUpInProgress());

      emit(await signUp(
        authRepository,
        email: event.email,
        username: event.username,
        phoneNumber: event.phoneNumber,
        password: event.password,
      ));
    });
    on<LogoutRequested>((event, emit) async {
      if (state is! LogoutInProgress) emit(const LogoutInProgress());
      emit(await logoutUser(authRepository));
    });
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    Log.logBlocTransition(this, transition);

    super.onTransition(transition);
  }

  @override
  Future<void> close() async {
    await _usersStreamSub.cancel();
    return super.close();
  }
}
