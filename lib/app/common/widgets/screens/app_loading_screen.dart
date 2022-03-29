import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/src/app_name_text.dart';
import 'package:clinic_v2/app/features/startup/view/widgets/loading_indicator.dart';

class LoadingAppScreen extends ResponsiveScreen {
  const LoadingAppScreen({Key? key}) : super(key: key);

  @override
  Widget mobileBuilder(context, ContextInfo contextInfo) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LoadingIndicator(
              currentDotColor: context.colorScheme.primary!,
              defaultDotColor: AppColorScheme.of(context).primaryContainer!,
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

  @override
  Widget tabletBuilder(context, contextInfo) {
    return _largeLoadingScreen(context);
  }

  @override
  Widget desktopBuilder(context, contextInfo) {
    return _largeLoadingScreen(context);
  }

  Widget _largeLoadingScreen(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingIndicator(
                    currentDotColor: context.colorScheme.primary!,
                    defaultDotColor:
                        AppColorScheme.of(context).primaryContainer!,
                    numDots: 5,
                    size: 60,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppLocalizations.of(context)!.loading,
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
