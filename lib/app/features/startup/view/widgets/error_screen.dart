import 'package:app_settings/app_settings.dart';
import 'package:clinic_v2/app/common/widgets/components/appearance_settings_bar.dart';
import 'package:clinic_v2/app/common/widgets/custom_buttons/custom_text_button.dart';
import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
//
import 'package:clinic_v2/app/common/widgets/components/scaffold_with_appbar.dart';
import 'package:clinic_v2/app/common/widgets/components/app_name_text.dart';
import 'package:clinic_v2/app/features/auth/sign_up/view/components/sign_up_components.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import '../../../../base/responsive/responsive.dart';

class ErrorStartingAppScreen extends ResponsiveScreen {
  final CustomError error;
  const ErrorStartingAppScreen(this.error, {Key? key}) : super(key: key);

  @override
  Widget desktopBuilder(context, ContextInfo contextInfo) {
    return const _LargeStartupErrorScreen();
  }

  @override
  Widget? tabletBuilder(context, ContextInfo contextInfo) {
    if (contextInfo.isLandScapeTablet) {
      return const _LargeStartupErrorScreen();
    }
    return null;
  }

  @override
  Widget mobileBuilder(BuildContext context, ContextInfo contextInfo) {
    return ScaffoldWithAppBar(
      appBarBackgroundColor: Colors.transparent,
      bodyWithSafeArea: false,
      centerTitle: true,
      // scaffoldBackgroundColor: context.colorScheme.errorColor,
      title: AppNameText(
        fontColor: context.colorScheme.secondary,
        fontSize: 36,
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/ErrorBrokenRobot.png',
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ErrorCard(
                  errorText:
                      (context.read<StartupCubit>().state as StartupFailure)
                          .error
                          .message,
                ),
                if (context.isMobilePlatform)
                  CustomTextButton(
                    label: 'open wifi settings',
                    labelColor: context.colorScheme.onBackground,
                    onPressed: () {
                      AppSettings.openWIFISettings();
                    },
                    iconWidget: const Icon(Icons.settings_applications),
                  ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LargeStartupErrorScreen extends Component {
  const _LargeStartupErrorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(BuildContext context, contextInfo) {
    final error = (context.read<StartupCubit>().state as StartupFailure).error;
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: contextInfo.isLandScapeTablet ? 1 : 0,
          child: Image.asset(
            'assets/ErrorBrokenRobot.png',
            fit: BoxFit.cover,
            height: contextInfo.screenHeight,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            color: context.colorScheme.backgroundColor,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: contextInfo.isDesktopPlatform
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: AppNameText(
                          fontSize: contextInfo.isTablet
                              ? context.textTheme.headlineSmall?.fontSize
                              : context.textTheme.headlineMedium?.fontSize,
                        ),
                      ),
                      if (contextInfo.isDesktopPlatform)
                        const AppearanceSettingsBar(),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        error.code == ErrorCode.connectionNotFound.name
                            ? Icons.signal_wifi_bad_sharp
                            : Icons.error_outline,
                        size: 50,
                        color: context.colorScheme.errorColor,
                      ),
                      ErrorCard(
                        color: context.colorScheme.errorColor,
                        errorText: error.message,
                      ),
                    ],
                  ),
                ),
                BlocBuilder<StartupCubit, StartupState>(
                  builder: (context, state) {
                    return (state is StartupRetryInProgress)
                        ? const Align(
                            alignment: Alignment.bottomRight,
                            child: fluent_ui.InfoBar(
                              // severity: fluent_ui.InfoBarSeverity.
                              // style: fluent_ui.InfoBarThemeData(
                              //   // icon:(_)=> fluent_ui.ProgressRing(),
                              // ),
                              title: fluent_ui.ProgressRing(),
                              content: Text('Retrying....'),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                )
                // BlocBuilder(builder: builder)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
