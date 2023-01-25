import 'package:fluent_ui/fluent_ui.dart';

//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:clinic_v2/presentation/shared_widgets/loading_indicator.dart';
import '../../../presentation/shared_widgets/app_name_text.dart';
import '../../../presentation/shared_widgets/screens/two_sides_screen_layout.dart';

class WindowsTwoSidesScreen extends StatelessWidget {
  const WindowsTwoSidesScreen({
    required this.showInProgressIndicator,
    required this.rightSide,
    this.rightSideAnimation,
    this.leftSideChild,
    this.rightSideBlurred,
    this.optionsBar,
    Key? key,
  }) : super(key: key);

  final Animation<double>? rightSideAnimation;
  final bool showInProgressIndicator;
  final bool? rightSideBlurred;
  final Widget? leftSideChild;
  final Widget rightSide;
  final Widget? optionsBar;

  @override
  Widget build(BuildContext context) {
    return TwoSidesScreenLayout(
      rightSideAnimation: rightSideAnimation,
      rightSideBlurred: rightSideBlurred ?? showInProgressIndicator,
      rightSide: rightSide,
      rightSideFlex: context.isTablet ? 2 : 1,
      leftSide: Hero(
        tag: 'appName',
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints.expand(),
                color: context.colorScheme.primaryContainer,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(),
                    AppNameText(
                      fontSize: context.isDesktop ? 50 : 36,
                      fontColor: context.colorScheme.primary,
                    ),
                    if (leftSideChild != null) ...[
                      const Spacer(),
                      leftSideChild!
                    ],
                    if (showInProgressIndicator) ...[
                      const Spacer(),
                      const LoadingIndicator(),
                    ],
                    const Spacer(),
                  ],
                ),
              ),
            ),
            if (optionsBar != null)
              Align(
                alignment: context.isArabicLocale
                    ? Alignment.topRight
                    : Alignment.bottomLeft,
                child: optionsBar,
              ),
          ],
        ),
      ),
    );
  }
}
