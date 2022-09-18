import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/shared_widgets//windows_components/two_sides_screen.dart';

import '../components/login_form.dart';
import '../components/login_message.dart';

class WindowsLoginScreen extends StatelessWidget {
  const WindowsLoginScreen({required this.animation, Key? key})
      : super(key: key);
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return WindowsTwoSidesScreen(
          leftSideAnimation: animation,
          showInProgressIndicator: state is LoginInProgress,
          leftSide: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.horizontalMargins,
                  vertical: context.screenHeight * .1,
                ),
                child: const LoginMessage(),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        context.isTablet ? 0 : context.horizontalMargins,
                  ),
                  child: LoginForm(
                    onSubmit: (String email, String password) {
                      context
                          .read<AuthBloc>()
                          .add(LoginRequested(email, password));
                    },
                  ),
                ),
              ),
            ],
          ),
          errorText: () {
            if (state is AuthError) return state.error.message;
          }(),
        );
      },
    );
  }
}
