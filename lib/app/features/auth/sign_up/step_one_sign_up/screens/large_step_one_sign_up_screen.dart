import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets//scaffold_with_appbar.dart';
import 'package:clinic_v2/app/common/widgets//windows_components/custom_nav_view.dart';
import 'package:clinic_v2/app/common/widgets//windows_components/two_sides_screen.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/sign_up_components.dart';
import '../components/account_info_form.dart';

class LargeStepOneSignUpScreen extends ResponsiveStatelessWidget {
  const LargeStepOneSignUpScreen({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return WindowsTwoSidesScreen(
          showInProgressIndicator: state is SignUpInProgress,
          leftSideAnimation: animation,
          leftSide: const _StepOneLeftSide(),
          errorText: () {
            if (state is SignUpError) {
              if (state.error.code == ErrorCode.connectionNotFound.name) {
                return AppLocalizations.of(context)!.noInternetConnection;
              }
              return state.error.message;
            }
            if (state is SignUpEmailIsNotValid) {
              return AppLocalizations.of(context)!.emailAddressNotValid;
            }
          }(),
        );
      },
    );
  }
}

class _StepOneLeftSide extends ResponsiveStatelessWidget {
  const _StepOneLeftSide({Key? key}) : super(key: key);

  @override
  Widget computerScreenBuilder(BuildContext context, ContextInfo contextInfo) {
    return WindowsNavView.onlyAppBar(
      appBarColor: context.colorScheme.backgroundColor,
      backgroundColor: context.colorScheme.backgroundColor,
      appBarActions: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SignUpStepIndicator(
            title: AppLocalizations.of(context)!.stepOne,
          ),
        ],
      ),
      appBarTitle: const SignUpMessage(),
      content: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: contextInfo.isDesktop ? context.horizontalMargins : 0,
          ),
          child: const SignUpAccountInfoForm(),
        ),
      ),
    );
  }

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return ScaffoldWithAppBar(
      showBottomTitle: contextInfo.isTablet,
      title: const SignUpMessage(),
      actions: [
        SignUpStepIndicator(
          title: AppLocalizations.of(context)!.stepOne,
        ),
      ],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: contextInfo.isDesktop ? context.horizontalMargins : 0,
          ),
          child: const SignUpAccountInfoForm(),
        ),
      ),
    );
  }
}
