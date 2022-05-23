import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets//scaffold_with_appbar.dart';
import 'package:clinic_v2/app/features/auth/sign_up/components/sign_up_components.dart';
import 'package:clinic_v2/app/features/auth/sign_up/step_two_sign_up/components/user_preferences_list.dart';

import 'tablet_screen.dart';
import 'windows_screen.dart';

class StepTwoSignUpScreen extends StatefulWidget {
  const StepTwoSignUpScreen({Key? key}) : super(key: key);
  @override
  State<StepTwoSignUpScreen> createState() => _StepTwoSignUpScreenState();
}

class _StepTwoSignUpScreenState
    extends StateWithResponsiveBuilder<StepTwoSignUpScreen> {
  // when on Windows we always use the WindowsStepTwoSignUpScreen
  @override
  Widget windowsDesktopBuilder(BuildContext context, ContextInfo contextInfo) {
    return const WindowsStepTwoSignUpScreen();
  }

  @override
  Widget? tabletBuilder(BuildContext context, ContextInfo contextInfo) {
    return const TabletStepTwoSignUpScreen();
  }

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return ScaffoldWithAppBar(
      titleText: AppLocalizations.of(context)!.signUpScreenMessage,
      actions: [
        SignUpStepIndicator(
          title: AppLocalizations.of(context)!.stepTwo,
        )
      ],
      body: Column(
        children: [
          Expanded(
            child: UserPreferencesList(
              onAppearanceTileTapped: (_) {
                //TODO:
                // IMPLEMENT BOTTOM SHEET APPEARANCE SETTINGS
              },
              onCalendarTileTapped: (_) {},
              showDentalServicesTile: false,
              // (context.read<SignUpCubit>().state as SignUpStepTwo)
              //         .serverUser
              //         .role ==
              //     UserRole.dentist,
            ),
          ),
        ],
      ),
    );
  }
}
