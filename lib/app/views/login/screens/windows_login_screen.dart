import 'package:clinic_v2/app/core/entities/result/error_exception.dart';
import 'package:flutter/material.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/shared_widgets//windows_components/two_sides_screen.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/app_settings_bar.dart';
import '../components/bloc_login_form.dart';
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
          topOptionsBar: const BlocAppSettingsBar(),
          leftSide: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.horizontalMargins,
                    vertical: context.screenHeight * .1,
                  ),
                  child: const LoginMessage(),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          context.isTablet ? 0 : context.horizontalMargins,
                    ),
                    child: const BlocLoginForm(),
                  ),
                ),
              ),
            ],
          ),
          errorText: () {
            //TODO: SHOW ERROR
            if (state is AuthHasNoLoggedInUser) {
              if (state.error != null &&
                  state.error?.exception
                      is FailedToRefreshAuthTokensException) {
                return context.localizations!.failedToAuthenticateUser;
              }
            }

            if (state is LoginErrorState) {
              return state.error.exception?.getMessage(context) ??
                  state.error.message;
            }
          }(),
        );
      },
    );
  }
}
