import 'package:animate_do/animate_do.dart';

//
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/presentation/shared_widgets/screens/two_sides_screen_layout.dart';
import 'package:clinic_v2/shared/models/error/basic_error.dart';

import '../../shared_widgets/error_card.dart';
import 'components/auth_reset_button.dart';
import 'components/startup_retry_button.dart';

class AppStartupFailureWideScreen extends StatelessWidget {
  const AppStartupFailureWideScreen(this.error, {super.key});

  final AppError error;

  @override
  Widget build(BuildContext context) {
    return TwoSidesScreenLayout.withAppLogo(
      rightSideBlurred: false,
      rightSide: _ScreenContent(error),
    );
  }
}

class _ScreenContent extends StatelessWidget {
  const _ScreenContent(this.error, {Key? key}) : super(key: key);
  final AppError error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(flex: 1),
        Expanded(
          child: Flash(
            duration: const Duration(seconds: 4),
            child: Icon(
              error.appException == AppException.noConnectionFound
                  ? Icons.signal_wifi_bad_sharp
                  : Icons.error_outline,
              size: 50,
              color: context.colorScheme.errorColor,
            ),
          ),
        ),
        const Spacer(flex: 1),
        ErrorCard(
          color: context.colorScheme.errorColor,
          errorText: error.appException?.getMessage(context) ??
              context.localizations!.failedToAuthenticateUser,
        ),
        if (error.appException == AppException.invalidRefreshToken) ...[
          const SizedBox(height: 30),
          const ResetAuthButton(),
          const Spacer(flex: 2),
        ] else ...[
          const StartupRetryButton(),
          const Spacer(),
          const Divider(),
          BuilderWithWidgetInfo(
            builder: (context, widgetInfo) {
              return ConstrainedBox(
                constraints: BoxConstraints.loose(
                    Size.fromWidth(widgetInfo.widgetSize.width * 0.6)),
                child: Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  direction:
                      context.isDesktop ? Axis.horizontal : Axis.vertical,
                  children: [
                    Text(
                      context.localizations!.gettingSameError,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const ResetAuthButton(),
                  ],
                ),
              );
            },
          ),
        ],
        const SizedBox(height: 20),
      ],
    );
  }
}
