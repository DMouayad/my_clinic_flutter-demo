import 'dart:async';

import 'package:clinic_v2/domain/authentication/base/base_auth_repository.dart';
import 'package:clinic_v2/shared/models/base_event.dart';
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

part 'states/auth_init_state.dart';

part 'states/auth_reset_state.dart';

part 'states/logout_state.dart';

part 'events/login_requested.dart';

part 'events/signup_requested.dart';

part 'events/auth_init_requested.dart';

part 'events/logout_requested.dart';

part 'events/auth_status_check_requested.dart';

part 'events/reset_auth_state.dart';

/// Manages
class AuthBloc extends Bloc<AuthEvent, AuthState> {
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
    on<AuthEvent>(
        (event, emit) async => await event.handle(authRepository, state, emit));
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
