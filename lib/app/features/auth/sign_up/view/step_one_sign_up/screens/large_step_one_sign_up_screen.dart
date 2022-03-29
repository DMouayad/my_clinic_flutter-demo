import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/src/app_name_text.dart';
import 'package:clinic_v2/app/common/widgets/screens/two_sides_screen_layout.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/components/sign_up_components.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_one_sign_up/components/account_info_form.dart';
import 'package:clinic_v2/app/features/startup/view/widgets/loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LargeStepOneSignUpScreen extends ResponsiveScreen {
  const LargeStepOneSignUpScreen({
    Key? key,
    required this.animation,
  }) : super(key: key);

  final Animation<double> animation;

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return TwoSidesScreenLayout(
          leftSideBlurred: state is SignUpInProgress,
          leftSideAnimation: animation,
          leftSide: const _StepOneLeftSide(),
          rightSide: const _StepOneRightSide(),
        );
      },
    );
  }
}

class _StepOneRightSide extends ResponsiveScreen {
  const _StepOneRightSide({Key? key}) : super(key: key);
  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Hero(
          tag: 'appName',
          child: Container(
            constraints: const BoxConstraints.expand(),
            color: state is! SignUpError && state is! SignUpEmailIsNotValid
                ? context.colorScheme.primary
                : context.colorScheme.errorColor,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppNameText(
                  fontSize: 44,
                  fontColor: context.colorScheme.onPrimary,
                ),
                if (state is SignUpError)
                  ErrorCard(
                    errorText: state.error.message,
                  ),
                if (state is SignUpEmailIsNotValid)
                  ErrorCard(
                    errorText:
                        AppLocalizations.of(context)!.emailAddressNotValid,
                  ),
                if (state is SignUpInProgress) ...[
                  const SizedBox(height: 20),
                  LoadingIndicator(
                    currentDotColor: context.colorScheme.secondary!,
                    defaultDotColor:
                        AppColorScheme.of(context).primaryContainer!,
                    size: 60,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StepOneLeftSide extends ResponsiveScreen {
  const _StepOneLeftSide({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, contextInfo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        if (contextInfo.isTablet)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: BackButton(),
          ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: context.horizontalMargins,
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SignUpMessage(),
                  SignUpStepIndicator(
                    title: AppLocalizations.of(context)!.stepOne,
                  ),
                ],
              ),
              const SignUpAccountInfoForm(),
            ],
          ),
        ),
      ],
    );
  }
}
