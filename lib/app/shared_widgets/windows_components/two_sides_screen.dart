import 'package:fluent_ui/fluent_ui.dart';
//
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/shared_widgets/error_card.dart';
import 'package:clinic_v2/app/shared_widgets/loading_indicator.dart';
import '../app_name_text.dart';
import '../screens/two_sides_screen_layout.dart';

class WindowsTwoSidesScreen extends StatelessWidget {
  const WindowsTwoSidesScreen({
    required this.showInProgressIndicator,
    required this.leftSide,
    this.leftSideAnimation,
    this.errorText,
    this.leftSideBlurred,
    this.topOptionsBar,
    Key? key,
  }) : super(key: key);

  final Animation<double>? leftSideAnimation;
  final bool showInProgressIndicator;
  final bool? leftSideBlurred;
  final String? errorText;
  final Widget leftSide;
  final Widget? topOptionsBar;

  @override
  Widget build(BuildContext context) {
    return TwoSidesScreenLayout(
      leftSideAnimation: leftSideAnimation,
      leftSideBlurred: leftSideBlurred ?? showInProgressIndicator,
      leftSide: leftSide,
      rightSide: Hero(
        tag: 'appName',
        child: SizedBox(
          width: context.screenWidth / 2,
          height: context.screenHeight,
          child: Acrylic(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    color: context.colorScheme.primaryContainer,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppNameText(
                          fontSize: 44,
                          fontColor: context.isDarkMode
                              ? context.colorScheme.primary
                              : context.colorScheme.primary,
                        ),
                        if (errorText != null)
                          ErrorCard(
                            errorText: errorText!,
                          ),
                        if (showInProgressIndicator) ...[
                          const SizedBox(height: 20),
                          const LoadingIndicator(),
                        ],
                      ],
                    ),
                  ),
                ),
                if (topOptionsBar != null)
                  Align(
                    alignment: context.isArabicLocale
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: topOptionsBar,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
