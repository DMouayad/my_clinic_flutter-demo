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
          optionsBar: const BlocAppSettingsBar(),
          rightSide: context.isWindowsPlatform
              ? _WindowsRightSide()
              : _AndroidRightSide(),
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

class _WindowsRightSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              context.isDesktop ? context.horizontalMargins : 16,
              context.screenHeight * .1,
              context.isDesktop ? context.horizontalMargins : 16,
              0,
            ),
            child: const LoginMessage(),
          ),
        ),
        // SizedBox(height: context.screenHeight * .1),
        const Expanded(flex: 2, child: BlocLoginForm()),
      ],
    );
  }
}

class _AndroidRightSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context.isPortraitMode) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Spacer(),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: LoginMessage(),
          )),
          Expanded(flex: 3, child: BlocLoginForm()),
          Spacer(),
        ],
      );
    } else {
      return CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            backgroundColor: context.colorScheme.backgroundColor,
            expandedHeight: context.screenHeight * .2,
            title: const LoginMessage(),
          ),
          const SliverFillViewport(
            viewportFraction: .7,
            delegate: SliverChildListDelegate.fixed([
              BlocLoginForm(),
            ]),
          ),
        ],
      );
    }
  }
}
