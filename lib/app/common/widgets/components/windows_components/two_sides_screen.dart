import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/error_card.dart';
import 'package:clinic_v2/app/common/widgets/screens/two_sides_screen_layout.dart';
import 'package:clinic_v2/app/features/startup/view/widgets/loading_indicator.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../app_name_text.dart';
import '../appearance_settings_bar.dart';

class WindowsTwoSidesScreen extends ResponsiveScreen {
  const WindowsTwoSidesScreen({
    required this.showInProgressIndicator,
    required this.leftSide,
    this.leftSideAnimation,
    this.errorText,
    this.leftSideBlurred,
    Key? key,
  }) : super(key: key);

  final Animation<double>? leftSideAnimation;
  final bool showInProgressIndicator;
  final bool? leftSideBlurred;
  final String? errorText;
  final Widget leftSide;

  @override
  Widget builder(BuildContext context, contextInfo) {
    return TwoSidesScreenLayout(
      leftSideAnimation: leftSideAnimation,
      leftSideBlurred: leftSideBlurred ?? showInProgressIndicator,
      leftSide: leftSide,
      rightSide: Hero(
        tag: 'appName',
        child: SizedBox(
          width: contextInfo.screenWidth / 2,
          height: contextInfo.screenHeight,
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
                          fontColor: context.colorScheme.secondary,
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
                Align(
                  alignment: context.isArabicLocale
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  child: const AppearanceSettingsBar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
