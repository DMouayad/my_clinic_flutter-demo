import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/blocs/email_verification_cubit/email_verification_cubit.dart';
import 'package:clinic_v2/presentation/shared_widgets/buttons/logout_button.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/adaptive_text_icon_button.dart';
import 'package:clinic_v2/presentation/shared_widgets/error_card.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/presentation/shared_widgets/simple_card.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/app_settings_bar.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/two_sides_screen.dart';

class WindowsVerificationNoticeScreen extends StatelessWidget {
  const WindowsVerificationNoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
      builder: (context, state) {
        return WindowsTwoSidesScreen(
          showInProgressIndicator: state is RequestingVerificationEmail,
          optionsBar: Row(
            children: const [BlocAppSettingsBar(), LogoutIconButton()],
          ),
          leftSideChild: () {
            if (state is VerificationEmailRequestFailed) {
              return ErrorCard(
                errorText: state.error.exception?.getMessage(context),
              );
            }
            if (state is VerificationEmailWasSent) {
              return ConstrainedBox(
                constraints: BoxConstraints.loose(
                  Size.fromWidth(context.screenWidth * .4),
                ),
                child: SimpleCard(
                  child: ListTile(
                    leading: Icon(Icons.check_circle_outline),
                    title: Text(
                      "Verification email was sent",
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                ),
              );
            }
          }(),
          rightSide: BuilderWithWidgetInfo(builder: (context, widgetInfo) {
            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  Icon(
                    Icons.verified_user_outlined,
                    color: context.colorScheme.errorColor,
                    size: 46,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Please Verify your email address",
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(flex: 2),
                  SimpleCard(
                    margin: EdgeInsets.symmetric(
                      horizontal: context.horizontalMargins,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'verify your email with the verification link sent by email to "${(context.read<AuthBloc>().state as AuthHasLoggedInUser).currentUser.email}"\n'
                          '\n\nif you did not receive an email click the button below to request a new verification link',
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.onPrimaryContainer,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 18),
                        AdaptiveTextIconButton(
                          label: 'Resend verification email',
                          onPressed: () {
                            context
                                .read<EmailVerificationCubit>()
                                .requestForCurrentUser();
                          },
                          iconWidget: const Icon(Icons.email_outlined),
                          tooltipMessage: 'Resend verification email',
                          foregroundColor: context.colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '"you will be directed once you have verified your email address"',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.black45,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
