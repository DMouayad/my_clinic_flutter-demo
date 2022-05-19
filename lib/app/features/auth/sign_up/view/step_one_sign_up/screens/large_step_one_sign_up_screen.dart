import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/scaffold_with_appbar.dart';
import 'package:clinic_v2/app/common/widgets/components/windows_components/custom_nav_view.dart';
import 'package:clinic_v2/app/common/widgets/components/windows_components/two_sides_screen.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/components/sign_up_components.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_one_sign_up/components/account_info_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LargeStepOneSignUpScreen extends ResponsiveScreen {
  const LargeStepOneSignUpScreen({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return
        // TextButton.icon
        BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return WindowsTwoSidesScreen(
          showInProgressIndicator: state is SignUpInProgress,
          leftSideAnimation: animation,
          leftSide: const _StepOneLeftSide(),
          errorText: () {
            if (state is SignUpError) {
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

class _StepOneLeftSide extends ResponsiveScreen {
  const _StepOneLeftSide({Key? key}) : super(key: key);
  @override
  Widget? windowsDesktopBuilder(BuildContext context, ContextInfo contextInfo) {
    return WindowsNavView.onlyAppBar(
      appBarColor: context.colorScheme.backgroundColor,
      backgroundColor: context.colorScheme.backgroundColor,
      appBarActions: SignUpStepIndicator(
        title: AppLocalizations.of(context)!.stepOne,
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
  Widget builder(BuildContext context, contextInfo) {
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
