import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/error_card.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/presentation/shared_widgets/screens/two_sides_screen_layout.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/app_settings_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/bloc_login_form.dart';
import '../components/login_message.dart';

class WideLoginScreen extends StatelessWidget {
  const WideLoginScreen({super.key, required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return TwoSidesScreenLayout.withAppLogo(
          rightSideAnimation: animation,
          rightSideBlurred: state is LoginInProgress,
          autoShowBackButton: false,
          rightSideScrollable: true,
          optionsBar: const BlocAppSettingsBar(),
          rightSide: const _RightSide(),
          leftSideContent: () {
            String? errorText;

            if (state is LoginErrorState) {
              errorText = state.error.appException?.getMessage(context) ??
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

class _RightSide extends StatelessWidget {
  const _RightSide();

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              context.horizontalMargins,
              context.screenHeight * .1,
              context.horizontalMargins,
              0,
            ),
            child: const LoginMessage(),
          ),
        ),
        const Expanded(flex: 2, child: BlocLoginForm()),
      ],
    );
  }
}
