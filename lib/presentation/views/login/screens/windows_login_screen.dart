import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/shared/models/error/error_exception.dart';
import 'package:clinic_v2/presentation/shared_widgets/error_card.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/two_sides_screen.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/app_settings_bar.dart';

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
          rightSideAnimation: animation,
          showInProgressIndicator: state is LoginInProgress,
          optionsBar: const BlocAppSettingsBar(),
          rightSide: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                // flex: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        context.isDesktop ? context.horizontalMargins : 16,
                    vertical: context.screenHeight * .1,
                  ),
                  child: const LoginMessage(),
                ),
              ),
              Expanded(
                flex: 2,
                child: BuilderWithWidgetInfo(builder: (context, widgetInfo) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal:
                            context.isDesktop ? context.horizontalMargins : 0,
                      ),
                      child: const BlocLoginForm(),
                    ),
                  );
                }),
              ),
            ],
          ),
          leftSideChild: () {
            //TODO: SHOW ERROR
            String? errorText;

            if (state is LoginErrorState) {
              errorText = state.error.exception?.getMessage(context) ??
                  state.error.message;
            }
            if (errorText != null) {
              return ErrorCard(errorText: errorText);
            }
          }(),
        );
      },
    );
  }
}
