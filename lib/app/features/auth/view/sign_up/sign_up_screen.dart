import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/src/app_name_text.dart';
import 'package:clinic_v2/app/features/auth/view/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/features/auth/view/sign_up/widgets/account_info_form.dart';
import 'package:clinic_v2/app/features/startup/view/widgets/loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends ResponsiveScreen {
  const SignUpScreen({Key? key, required this.animation}) : super(key: key);
  final Animation<double> animation;

  @override
  Widget mobileBuilder(BuildContext context, ContextInfo contextInfo) {
    print(contextInfo);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: context.horizontalMargins,
          vertical: 25,
        ),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 45.0, bottom: 70),
              child: AppNameText(
                fontSize: 26,
                fontColor: AppColorScheme.secondary(context),
              ),
            ),
          ),
          _signUpMessageText(context),
          _signUpStepIndicator(
            AppLocalizations.of(context)!.stepOne,
            context,
          ),
          const SignUpAccountInfoForm(),
        ],
      ),
    );
  }

  Widget _signUpStepIndicator(String title, BuildContext context) {
    return Center(
      child: RawChip(
        backgroundColor: AppColorScheme.primaryContainer(context),
        label: Text(
          title,
          style: context.textTheme.subtitle1,
        ),
      ),
    );
  }

  Widget _signUpMessageText(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.signUpScreenMessage,
      textAlign: TextAlign.start,
      style: context.textTheme.headline5?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  @override
  Widget desktopBuilder(BuildContext context, ContextInfo contextInfo) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1, 0),
                  end: const Offset(0, 0),
                ).chain(CurveTween(curve: Curves.easeInCubic)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.horizontalMargins,
                  vertical: 26,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Row(
                        children: [
                          const BackButton(),
                          const SizedBox(width: 12),
                          _signUpMessageText(context),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        // shrinkWrap: true,
                        children: [
                          _signUpStepIndicator(
                            AppLocalizations.of(context)!.stepOne,
                            context,
                          ),
                          const SizedBox(height: 20),
                          const Center(
                            child: SignUpAccountInfoForm(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<SignUpCubit, SignUpState>(
            builder: (BuildContext context, state) {
              return Expanded(
                child: Hero(
                  tag: 'appName',
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    color:
                        state is! SignUpError && state is! SignUpEmailIsNotValid
                            ? AppColorScheme.primary(context)
                            : AppColorScheme.errorColor(context),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppNameText(
                          fontSize: 44,
                          fontColor: AppColorScheme.onPrimary(context),
                        ),
                        if (state is SignUpError)
                          Container(
                            decoration: BoxDecoration(),
                            child: Text(state.error.message),
                          ),
                        if (state is SignUpEmailIsNotValid)
                          Container(
                            decoration: BoxDecoration(),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .emailAddressNotValid,
                            ),
                          ),
                        if (state is SignUpInProgress) ...[
                          const SizedBox(height: 20),
                          LoadingIndicator(
                            currentDotColor: AppColorScheme.secondary(context)!,
                            defaultDotColor:
                                AppColorScheme.primaryContainer(context)!,
                            size: 60,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
