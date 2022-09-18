import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
//
import 'package:clinic_v2/app/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/app/shared_widgets/loading_indicator.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/two_sides_screen.dart';

class LoadingAppScreen extends StatelessWidget {
  const LoadingAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.isWindowsPlatform) return windowsBuilder(context);
    if (context.isMobile) return mobileScreenBuilder(context);
    if (context.isTablet) return tabletScreenBuilder(context);
    throw UnimplementedError();
  }

  Widget mobileScreenBuilder(context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LoadingIndicator(
              currentDotColor: context.colorScheme.primary!,
              defaultDotColor: context.colorScheme.primaryContainer!,
              size: 60,
            ),
            AppNameText(
              fontSize: 32,
              fontColor: context.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget windowsBuilder(BuildContext context) {
    return WindowsTwoSidesScreen(
      leftSideBlurred: false,
      showInProgressIndicator: false,
      leftSide: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingIndicator(
              currentDotColor: context.colorScheme.primary!,
              defaultDotColor: context.colorScheme.primaryContainer!,
              numDots: 5,
              size: 60,
            ),
            const SizedBox(height: 24),
            Text(
              context.localizations!.loading,
            ),
          ],
        ),
      ),
    );
  }

  Widget tabletScreenBuilder(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: context.isPortraitTablet ? Axis.vertical : Axis.horizontal,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingIndicator(
                    currentDotColor: context.colorScheme.primary!,
                    defaultDotColor: context.colorScheme.primaryContainer!,
                    numDots: 5,
                    size: 60,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    context.localizations!.loading,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              constraints: const BoxConstraints.expand(),
              alignment: Alignment.center,
              color: context.colorScheme.primary,
              child: AppNameText(
                fontSize: 44,
                fontColor: context.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
