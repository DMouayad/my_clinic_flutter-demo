import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/presentation/shared_widgets/screens/two_sides_screen_layout.dart';

//
import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/presentation/shared_widgets/error_card.dart';
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/app_settings_bar.dart';

import '../../../presentation/views/sign_up/components/bloc_sign_up_form.dart';

class WideSignUpScreen extends StatelessWidget {
  const WideSignUpScreen({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return TwoSidesScreenLayout.withAppLogo(
          rightSideBlurred: state is SignUpInProgress,
          rightSideAnimation: animation,
          optionsBar: const BlocAppSettingsBar(),
          rightSide: Padding(
            padding: EdgeInsets.only(top: context.screenHeight * 0.1),
            child: const BlocSignUpForm(),
          ),
          rightSideScrollable: !context.isWindowsPlatform,
          autoShowBackButton: true,
          leftSideContent: () {
            if (state is SignUpErrorState) {
              return ErrorCard(
                  errorText: state.error.exception?.getMessage(context) ??
                      "Signing up failed, please try again");
            }
          }(),
        );
      },
    );
  }
}
