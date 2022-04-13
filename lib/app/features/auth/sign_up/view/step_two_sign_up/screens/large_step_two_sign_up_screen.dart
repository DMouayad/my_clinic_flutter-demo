import 'package:animate_do/animate_do.dart';
import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/scaffold_with_appbar.dart';
import 'package:clinic_v2/app/common/widgets/components/section_card.dart';
import 'package:clinic_v2/app/common/widgets/components/simple_card.dart';
import 'package:clinic_v2/app/features/auth/common/components/submit_button.dart';
import 'package:clinic_v2/app/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/components/sign_up_components.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/step_two_sign_up/components/user_preferences_list.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/view/components/appearance_settings.dart';
import 'package:clinic_v2/core/common/utilities/enums.dart';
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
        return ScaffoldWithAppBar(
          actions: [
            SignUpStepIndicator(
              title: AppLocalizations.of(context)!.stepTwo,
            ),
          ],
          titleText: AppLocalizations.of(context)!.signUpScreenMessage,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: FadeInLeft(
                  from: 40,
                  duration: const Duration(milliseconds: 350),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.horizontalMargins,
                      0,
                      context.horizontalMargins,
                      10,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SimpleCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const ListTile(
                                  title: Text(
                                    "Configure your CLINIC preferences & settings.",
                                  ),
                                ),
                                const Divider(),
                                Expanded(
                                  child: UserPreferencesList(
                                    showDentalServicesTile: (context
                                                .read<SignUpCubit>()
                                                .state as SignUpStepTwo)
                                            .serverUser
                                            .role ==
                                        UserRole.dentist,
                                    onAppearanceTileTapped: () {
                                      setState(() {
                                        rightSide = FadeIn(
                                          duration:
                                              const Duration(milliseconds: 350),
                                          child:
                                              const AppearanceSettingsScreen(),
                                        );
                                      });
                                    },
                                    onCalendarTileTapped: () {
                                      setState(() =>
                                          rightSide = SectionCard(title: ''));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SubmitButton(
                            expandInWidth: true,
                            onPressed: () {},
                            text: 'Finish sign up',
                            iconData: Icons.done_all,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: context.horizontalMargins,
                      bottom: 10,
                    ),
                    child: FadeInRight(
                      from: 40,
                      duration: const Duration(milliseconds: 350),
                      child: SimpleCard(
                        child: rightSide,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
