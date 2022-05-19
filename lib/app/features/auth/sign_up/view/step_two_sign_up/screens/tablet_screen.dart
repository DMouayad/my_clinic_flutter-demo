part of 'large_step_two_sign_up_screen.dart';

class _TabletStepTwoSignUpScreen extends StatefulWidget {
  const _TabletStepTwoSignUpScreen({Key? key}) : super(key: key);
  @override
  State<_TabletStepTwoSignUpScreen> createState() =>
      __TabletStepTwoSignUpScreenState();
}

class __TabletStepTwoSignUpScreenState
    extends StateWithResponsiveBuilder<_TabletStepTwoSignUpScreen> {
  Widget rightSide = const SizedBox.expand();
  int selectedItemIndex = 0;

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return ScaffoldWithAppBar(
      actions: [
        SignUpStepIndicator(
          title: AppLocalizations.of(context)!.stepTwo,
        ),
      ],
      titleText: AppLocalizations.of(context)!.signUpScreenMessage,
      body: Row(
        children: [
          Expanded(
            flex: contextInfo.screenWidth <= 780 ? 2 : 1,
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
                        padding: EdgeInsets.all(contextInfo.isDesktop ? 8 : 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Center(
                                child: AutoSizeText(
                                  "Configure your CLINIC preferences & settings.",
                                  maxFontSize:
                                      context.textTheme.titleLarge!.fontSize!,
                                  style: context.textTheme.titleLarge?.copyWith(
                                    fontWeight: fluent_ui.FontWeight.w700,
                                    color:
                                        context.colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              child: UserPreferencesList(
                                selectedItemIndex: selectedItemIndex,
                                // onItemSelected:,
                                showDentalServicesTile: (context
                                            .read<SignUpCubit>()
                                            .state as SignUpStepTwo)
                                        .serverUser
                                        .role ==
                                    UserRole.dentist,
                                onAppearanceTileTapped: (index) {
                                  setState(() {
                                    selectedItemIndex = index;
                                    rightSide = FadeIn(
                                      duration:
                                          const Duration(milliseconds: 350),
                                      child: const AppearanceSettingsScreen(),
                                    );
                                  });
                                },
                                onCalendarTileTapped: (newIndex) {
                                  setState(() {
                                    selectedItemIndex = newIndex;

                                    rightSide = SectionCard(title: '');
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: SubmitButton(
                          expandInWidth: true,
                          onPressed: () {},
                          text: 'Finish sign up',
                          iconData: Icons.done_all,
                        ),
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
                padding: const EdgeInsets.only(
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
          SizedBox(
            width: context.horizontalMargins,
          ),
        ],
      ),
    );
  }
}
