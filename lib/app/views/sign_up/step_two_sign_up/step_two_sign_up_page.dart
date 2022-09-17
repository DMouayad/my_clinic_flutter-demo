import 'package:clinic_v2/app/base/entities/app_page/app_page.dart';
import 'package:clinic_v2/app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_settings_setup/screens/step_two_sign_up_screen.dart';

class StepTwoSignUpPage extends AppPage {
  StepTwoSignUpPage({
    required AuthCubit authCubit,
    required SignUpCubit signUpCubit,
  }) : super(
          routeSettings:
              const RouteSettings(name: Routes.stepTwoSignUpScreenRoute),
          pageScreensInfo: RouteTransitionBuilder(
            tabletScreenTransitionType: RouteTransitionType.slideFromTop,
            desktopScreenTransitionType: RouteTransitionType.slideFromTop,
            screensBuilder: (context, animation, secondaryAnimation) {
              return PageScreensBuilder(
                defaultScreen: _buildScreenWithBloc(
                  context: context,
                  authCubit: authCubit,
                  signUpCubit: signUpCubit,
                  screen: const StepTwoSignUpScreen(),
                ),
              );
            },
          ),
        );

  static Widget _buildScreenWithBloc({
    required BuildContext context,
    required Widget screen,
    required AuthCubit authCubit,
    required SignUpCubit signUpCubit,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authCubit),
        BlocProvider<SignUpCubit>.value(value: signUpCubit),
      ],
      child: WillPopScope(
        onWillPop: () async {
          bool leaveCurrentPage = false;
          await showDialog(
            context: context,
            builder: (buildContext) {
              return AlertDialog(
                backgroundColor: buildContext.colorScheme.backgroundColor,
                title: Text(
                  AppLocalizations.of(context)!.exitSignUpDialogTitle,
                ),
                content: Text(
                  AppLocalizations.of(context)!.exitSignUpDialogMessage,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      leaveCurrentPage = true;
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          buildContext.colorScheme.errorColor),
                    ),
                    child: Text(
                      'Exit',
                      style: buildContext.textTheme.bodyText1?.copyWith(
                        color: buildContext.colorScheme.onError,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      leaveCurrentPage = false;
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                    ),
                  )
                ],
              );
            },
          );
          return leaveCurrentPage;
        },
        child: screen,
      ),
    );
  }
}
