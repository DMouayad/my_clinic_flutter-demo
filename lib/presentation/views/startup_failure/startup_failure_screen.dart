import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/filled_buttons.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/text_buttons.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:animate_do/animate_do.dart';

//
import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/adaptive_text_icon_button.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/presentation/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/presentation/shared_widgets/error_card.dart';
import 'package:clinic_v2/presentation/shared_widgets/scaffold_with_appbar.dart';
import 'package:clinic_v2/presentation/shared_widgets/windows_components/two_sides_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStartupFailureScreen extends StatelessWidget {
  final BasicError error;
  final void Function()? onRetry;

  const AppStartupFailureScreen(
    this.error,
    this.onRetry, {
    Key? key,
  }) : super(key: key);

  Widget defaultBuilder(BuildContext context) {
    return ScaffoldWithAppBar(
      appBarBackgroundColor: Colors.transparent,
      bodyWithSafeArea: false,
      centerTitle: true,
      title: AppNameText(
        fontColor: context.colorScheme.primary,
        fontSize: 36,
      ),
      body: _ScreenContent(error, onRetry),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (context.isLandScapeTablet || context.isDesktop) {
      return BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (prev, next) =>
            prev is! AuthInitInProgress && next is! AuthHasLoggedInUser,
        builder: (context, state) {
          return WindowsTwoSidesScreen(
            rightSideBlurred: state is AuthInitInProgress,
            showInProgressIndicator: state is AuthInitInProgress,
            rightSide: state is! AuthInitInProgress
                ? _ScreenContent(error, onRetry)
                : const SizedBox(),
          );
        },
      );
    }
    return defaultBuilder(context);
  }
}

class _ScreenContent extends StatelessWidget {
  const _ScreenContent(this.error, this.onRetry, {Key? key}) : super(key: key);
  final void Function()? onRetry;
  final BasicError error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Expanded(
            child: Flash(
              // infinite: true,
              duration: const Duration(seconds: 4),
              child: Icon(
                error.exception == const ErrorException.noConnectionFound()
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
            errorText: error.exception?.getMessage(context) ??
                context.localizations!.failedToAuthenticateUser,
          ),
          if (error.exception is InvalidRefreshTokenException) ...[
            const SizedBox(height: 30),
            AdaptiveFilledButton(
              label: context.localizations!.reLogin,
              iconData: Icons.login,
              width: 180,
              onPressed: () => _resetAuth(context),
            ),
            const Spacer(flex: 2),
          ] else ...[
            AdaptiveTextIconButton(
              margins: const EdgeInsets.symmetric(vertical: 20),
              label: context.localizations!.retry,
              iconWidget: const Icon(Icons.refresh),
              tooltipMessage: context.localizations!.retry,
              onPressed: () {
                if (onRetry != null) onRetry!();
              },
            ),
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
                      Expanded(
                        child: Text(
                          context.localizations!.gettingSameError,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AdaptiveTextButton(
                          labelColor: context.colorScheme.secondary,
                          label: context.localizations!.reLogin,
                          onPressed: () => _resetAuth(context),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          const SizedBox(height: 20),
          // const Spacer(flex: 2),
        ],
      ),
    );
  }

  void _resetAuth(BuildContext context) {
    context.read<AuthBloc>().add(const ResetAuthState());
  }
}
