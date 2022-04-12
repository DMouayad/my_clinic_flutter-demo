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
    this.persistentFooterButtons,
    this.showLoadingIndicator = false,
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
  final bool centerTitle;
  final List<Widget>? persistentFooterButtons;

  /// when [true], this scaffold will be covered by a color-barrier with a
  /// progress indicator in the center
  final bool showLoadingIndicator;
  @override
  Widget builder(BuildContext context, contextInfo) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          floatingActionButton: floatingActionButton,
          persistentFooterButtons: persistentFooterButtons,
          appBar: AppBar(
            automaticallyImplyLeading: showLeading,
            backgroundColor: appBarBackgroundColor,
            centerTitle: centerTitle,
            foregroundColor: context.colorScheme.onBackground,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(14),
              ),
            ),
            leadingWidth: 48,
            title: title ??
                Text(
                  titleText!,
                  style: context.textTheme.headline6?.copyWith(
                    fontSize: titleFontSize,
                  ),
                ),
            actions: actions,
            bottom: appBarBottom,
          ),
          body: SafeArea(child: body),
        ),
        if (showLoadingIndicator) ...[
          const BlurredColorBarrier(),
          const LoadingIndicator(),
        ],
      ],
    );
  }
}
