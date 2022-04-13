import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/features/startup/view/widgets/loading_indicator.dart';

import 'color_barrier.dart';

class ScaffoldWithAppBar extends Component {
  const ScaffoldWithAppBar({
    this.showLeading = true,
    this.centerTitle = false,
    this.appBarBottom,
    this.floatingActionButton,
    this.actions,
    this.titleFontSize = 18,
    Key? key,
    this.titleText,
    this.title,
    this.appBarBackgroundColor,
    this.scaffoldBackgroundColor,
    this.persistentFooterButtons,
    this.appBarBorderRadius,
    this.titleFontColor,
    this.showLoadingIndicator = false,
    this.bodyWithSafeArea = true,
    required this.body,
  })  : assert(title != null || titleText != null),
        super(key: key);

  final List<Widget>? actions;
  final PreferredSizeWidget? appBarBottom;
  final Widget body;
  final Widget? title;
  final Widget? floatingActionButton;
  final bool showLeading;
  final String? titleText;
  final double titleFontSize;
  final Color? appBarBackgroundColor;
  final Color? scaffoldBackgroundColor;
  final Color? titleFontColor;
  final bool centerTitle;
  final List<Widget>? persistentFooterButtons;
  final double? appBarBorderRadius;
  final bool bodyWithSafeArea;

  /// when [true], this scaffold will be covered by a color-barrier with a
  /// progress indicator in the center
  final bool showLoadingIndicator;
  @override
  Widget builder(BuildContext context, contextInfo) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: scaffoldBackgroundColor,
          floatingActionButton: floatingActionButton,
          persistentFooterButtons: persistentFooterButtons,
          appBar: AppBar(
            automaticallyImplyLeading: showLeading,
            backgroundColor: appBarBackgroundColor,
            centerTitle: centerTitle,
            foregroundColor: context.colorScheme.onBackground,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(appBarBorderRadius ?? 0),
              ),
            ),
            leadingWidth: 48,
            title: title ??
                Text(
                  titleText!,
                  style: context.textTheme.headline6?.copyWith(
                    fontSize: titleFontSize,
                    color: titleFontColor,
                  ),
                ),
            actions: actions,
            bottom: appBarBottom,
          ),
          body: bodyWithSafeArea ? SafeArea(child: body) : body,
        ),
        if (showLoadingIndicator) ...[
          const BlurredColorBarrier(),
          const LoadingIndicator(),
        ],
      ],
    );
  }
}
