import 'package:animate_do/animate_do.dart';
import 'package:clinic_v2/app/common/widgets//app_name_text.dart';
//
import 'package:clinic_v2/app/common/widgets//error_card.dart';
import 'package:clinic_v2/app/common/widgets//scaffold_with_appbar.dart';
import 'package:clinic_v2/app/common/widgets//windows_components/two_sides_screen.dart';
import 'package:clinic_v2/app/features/startup/cubit/startup_cubit.dart';
import 'package:clinic_v2/core/common/models/custom_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../base/responsive/responsive.dart';

class ErrorStartingAppScreen extends ResponsiveStatelessWidget {
  final CustomError error;
  const ErrorStartingAppScreen(this.error, {Key? key}) : super(key: key);

  @override
  Widget computerScreenBuilder(context, ContextInfo contextInfo) {
    return _largeErrorScreen(context, contextInfo);
  }

  @override
  Widget? tabletScreenBuilder(context, ContextInfo contextInfo) {
    if (contextInfo.isLandScapeTablet) {
      return _largeErrorScreen(context, contextInfo);
    }
    return null;
  }

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    final error = (context.read<StartupCubit>().state as StartupFailure).error;
    return ScaffoldWithAppBar(
      appBarBackgroundColor: Colors.transparent,
      bodyWithSafeArea: false,
      centerTitle: true,
      title: AppNameText(
        fontColor: context.colorScheme.secondary,
        fontSize: 36,
      ),
      body: _screenContent(error, context, contextInfo),
    );
  }

  Widget _largeErrorScreen(BuildContext context, contextInfo) {
    final error = (context.read<StartupCubit>().state as StartupFailure).error;
    return WindowsTwoSidesScreen(
      showInProgressIndicator: false,
      leftSide: _screenContent(error, context, contextInfo),
    );
  }

  Widget _screenContent(
    CustomError error,
    BuildContext context,
    ContextInfo contextInfo,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // if (contextInfo.isMobile || contextInfo.isPortraitTablet)
          const Spacer(),
          Expanded(
            child: Flash(
              infinite: true,
              duration: const Duration(seconds: 4),
              child: Icon(
                error.code == ErrorCode.connectionNotFound.name
                    ? Icons.signal_wifi_bad_sharp
                    : Icons.error_outline,
                size: 50,
                color: context.colorScheme.errorColor,
              ),
            ),
          ),
          ErrorCard(
            color: context.colorScheme.errorColor,
            errorText: error.message,
          ),
          const Spacer(),
          ...error.code == ErrorCode.connectionNotFound.name
              ? [
                  Expanded(
                    child: Text(
                      'We will auto-retry when the connection is restored ',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onBackground,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                ]
              : [
                  TextButton.icon(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          context.colorScheme.primary),
                      textStyle: MaterialStateProperty.all(
                        context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    label: const Text('retry now'),
                    icon: const Icon(
                      Icons.refresh,
                      size: 24,
                    ),
                    onPressed: () {
                      context.read<StartupCubit>().initServerConnection();
                    },
                  ),
                  const Spacer(),
                ]
        ],
      ),
    );
  }
}
