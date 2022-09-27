import 'package:flutter/material.dart';
//
import 'package:animate_do/animate_do.dart';
//
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/app/shared_widgets/error_card.dart';
import 'package:clinic_v2/app/shared_widgets/scaffold_with_appbar.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/two_sides_screen.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';

class ErrorStartingAppScreen extends StatelessWidget {
  final BasicError error;
  const ErrorStartingAppScreen(this.error, {Key? key}) : super(key: key);

  Widget desktopScreenBuilder(BuildContext context) {
    return _largeErrorScreen(context);
  }

  Widget defaultBuilder(BuildContext context) {
    return ScaffoldWithAppBar(
      appBarBackgroundColor: Colors.transparent,
      bodyWithSafeArea: false,
      centerTitle: true,
      title: AppNameText(
        fontColor: context.colorScheme.secondary,
        fontSize: 36,
      ),
      body: _screenContent(error, context),
    );
  }

  Widget _largeErrorScreen(BuildContext context) {
    return WindowsTwoSidesScreen(
      showInProgressIndicator: false,
      leftSide: _screenContent(error, context),
    );
  }

  Widget _screenContent(
    BasicError error,
    BuildContext context,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Expanded(
            child: Flash(
              infinite: true,
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
          ErrorCard(
            color: context.colorScheme.errorColor,
            errorText: _getErrorTextFromException(
                  error.exception,
                  context,
                ) ??
                error.description,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  String? _getErrorTextFromException(
      ErrorException? errorException, BuildContext context) {
    if (errorException is NoConnectionFoundException) {
      return context.localizations?.noInternetConnection ??
          "No Internet connection";
    }
    if (errorException == const ErrorException.cannotConnectToServer()) {
      return context.localizations?.cannotConnectToServer ??
          "Cannot connect to the server, please try again";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (context.isLandScapeTablet) {
      return _largeErrorScreen(context);
    }
    if (context.isDesktop) {
      return _largeErrorScreen(context);
    }
    return defaultBuilder(context);
  }
}
