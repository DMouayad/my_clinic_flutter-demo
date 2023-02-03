//
import 'package:clinic_v2/presentation/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/presentation/shared_widgets/loading_indicator.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/presentation/shared_widgets/scaffold_with_appbar.dart';
import 'package:clinic_v2/presentation/shared_widgets/screens/two_sides_screen_layout.dart';

class MobileAppStartupScreen extends StatelessWidget {
  const MobileAppStartupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppBar(
      centerTitle: true,
      showLeading: false,
      title: AppNameText(
        fontSize: 36,
        fontColor: context.colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingIndicator(
              currentDotColor: context.colorScheme.primary!,
              defaultDotColor: context.colorScheme.primaryContainer!,
            ),
            const SizedBox(height: 20),
            Text(
              "Getting things ready...",
              style: context.textTheme.bodyLarge,
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

class WideAppStartupScreen extends StatelessWidget {
  const WideAppStartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TwoSidesScreenLayout.withAppLogo(
      rightSideBlurred: false,
      rightSide: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoadingIndicator(),
            const SizedBox(height: 24),
            Text(
              context.localizations!.loading,
            ),
          ],
        ),
      ),
    );
  }
}
