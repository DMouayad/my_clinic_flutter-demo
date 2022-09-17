import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/core/entities/result/result.dart';
import 'package:clinic_v2/app/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';
import 'package:clinic_v2/app/shared_widgets/error_card.dart';
import 'package:clinic_v2/app/shared_widgets/scaffold_with_appbar.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/two_sides_screen.dart';

class ErrorStartingAppScreen extends CustomStatelessWidget {
  final BasicError error;
  const ErrorStartingAppScreen(this.error, {Key? key}) : super(key: key);

  @override
  Widget desktopScreenBuilder(context, ContextInfo contextInfo) {
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
    return WindowsTwoSidesScreen(
      showInProgressIndicator: false,
      leftSide: _screenContent(error, context, contextInfo),
    );
  }

  Widget _screenContent(
    BasicError error,
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
                error.exception == ErrorException.noConnectionFound()
                    ? Icons.signal_wifi_bad_sharp
                    : Icons.error_outline,
                size: 50,
                color: context.colorScheme.errorColor,
              ),
            ),
          ),
          ErrorCard(
            color: context.colorScheme.errorColor,
            errorText: error.message ??
                _getErrorTextFromException(
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
    if (errorException == ErrorException.noConnectionFound()) {
      return context.localizations?.noInternetConnection ??
          "No Internet connection";
    }
    if (errorException == ErrorException.cannotConnectToServer()) {
      return context.localizations?.cannotConnectToServer ??
          "Cannot connect to the server, please try again";
    }
    return null;
  }
}
