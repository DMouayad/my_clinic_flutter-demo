import 'package:clinic_v2/app/common/widgets/components/appearance_settings_bar.dart';
import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        fontColor: context.colorScheme.primary,
        fontSize: 26,
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
            child: ErrorCard(
              // color: Colors.black26,
              errorText: (context.read<StartupCubit>().state as StartupFailure)
                  .error
                  .message,
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
            color: context.colorScheme.errorColor,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppNameText(
                      fontColor: context.colorScheme.onError,
                      fontSize: 32,
                    ),
                    ErrorCard(
                      color: Colors.black12,
                      errorText:
                          (context.read<StartupCubit>().state as StartupFailure)
                              .error
                              .message,
                    ),
                  ],
                ),
                if (contextInfo.isDesktopPlatform)
                  const Align(
                    alignment: Alignment.topRight,
                    child: AppearanceSettingsBar(),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
    // return TwoSidesScreenLayout(
    //   leftSide: Image.asset(
    //     'assets/ErrorBrokenRobot.png',
    //     fit: BoxFit.fill,
    //   ),
    //   rightSide: Container(
    //     alignment: Alignment.center,
    //     color: context.colorScheme.errorColor,
    //     child: AppNameText(
    //       fontColor: context.colorScheme.onError,
    //     ),
    //   ),
    //   // backgroundColor: Colors.red,
    //   // body: Column(),
    // );
  }
}
