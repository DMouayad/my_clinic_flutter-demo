import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/reusable_scaffold_with_appbar.dart';
import 'package:clinic_v2/app/common/widgets/screens/two_sides_screen_layout.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/components/user_preferences_list.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/view/components/appearance_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LargeStepTwoSignUpScreen extends StatefulWidget {
  const LargeStepTwoSignUpScreen({Key? key}) : super(key: key);
  @override
  State<LargeStepTwoSignUpScreen> createState() =>
      _LargeStepTwoSignUpScreenState();
}

class _LargeStepTwoSignUpScreenState
    extends StateWithResponsiveBuilder<LargeStepTwoSignUpScreen> {
  Widget rightSide = const SizedBox.expand();
  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return TwoSidesScreenLayout(
          rightSideFlex: 2,
          leftSideBlurred: state is SignUpInProgress,
          leftSide: _stepTowLeftSide(),
          rightSide: rightSide,
        );
      },
    );
  }

  Widget _stepTowLeftSide() {
    return ScaffoldWithAppBar(
      titleText: AppLocalizations.of(context)!.createAccount,
      body: UserPreferencesList(
        onAppearanceTileTapped: () {
          setState(() => rightSide = AppearanceSettingsScreen());
        },
        onCalendarTileTapped: () {
          // setState(()=>rightSide=);
        },
        onDentalServicesTileTapped: () {
          // setState(()=>rightSide=);
        },
      ),
    );
  }
}
