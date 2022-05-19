import 'package:clinic_v2/app/common/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';

class _NavViewWithPane extends WindowsNavView {
  const _NavViewWithPane({
    required Widget content,
    required this.navigationPane,
    this.appBar,
    Color? backgroundColor,
  }) : super(
          content: content,
          backgroundColor: backgroundColor,
        );
  final NavigationPane navigationPane;
  final NavigationAppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return _RawNavView(
      content: content,
      backgroundColor: backgroundColor,
      navigationPane: navigationPane,
      appBar: appBar,
    );
  }
}

class _NavViewWithAppBar extends WindowsNavView {
  const _NavViewWithAppBar({
    this.appBarColor,
    this.appBarActions,
    this.appBarTitle,
    this.appBarTitleText,
    this.appBarLeading,
    Color? backgroundColor,
    required Widget content,
  }) : super(content: content, backgroundColor: backgroundColor);

  final Color? appBarColor;
  final Widget? appBarActions;
  final Widget? appBarTitle;
  final String? appBarTitleText;
  final Widget? appBarLeading;

  @override
  Widget build(BuildContext context) {
    return _RawNavView(
      content: content,
      backgroundColor: backgroundColor,
      appBar: NavigationAppBar(
        // height: 65,
        title: appBarTitle ??
            Text(
              appBarTitleText!,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
        automaticallyImplyLeading: false,
        leading: appBarLeading ??
            (Navigator.of(context).canPop()
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      iconButtonMode: IconButtonMode.large,
                      style: ButtonStyle(
                        padding: ButtonState.all(
                          const EdgeInsets.symmetric(vertical: 16),
                        ),
                        iconSize: ButtonState.all(16),
                        // foregroundColor:
                        // ButtonState.all(context.colorScheme.onBackground),
                      ),
                      icon: const Icon(FluentIcons.back),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  )
                : null),
        actions: appBarActions,
        backgroundColor: appBarColor ?? context.colorScheme.surface,
      ),
    );
  }
}

abstract class WindowsNavView extends StatelessWidget {
  final Widget content;
  final Color? backgroundColor;

  const WindowsNavView({Key? key, required this.content, this.backgroundColor})
      : super(key: key);

  factory WindowsNavView.raw({
    NavigationPane? navigationPane,
    NavigationAppBar? appBar,
    Widget content = const SizedBox.shrink(),
    Color? backgroundColor,
  }) {
    return _RawNavView(
      appBar: appBar,
      content: content,
      navigationPane: navigationPane,
      backgroundColor: backgroundColor,
    );
  }
  factory WindowsNavView.onlyPane({
    required NavigationPane navigationPane,
    NavigationAppBar? appBar,
    Widget content = const SizedBox.shrink(),
    Color? backgroundColor,
  }) {
    return _NavViewWithPane(
      content: content,
      navigationPane: navigationPane,
      appBar: appBar,
      backgroundColor: backgroundColor,
    );
  }
  factory WindowsNavView.onlyAppBar({
    Widget content = const SizedBox.shrink(),
    Color? backgroundColor,
    Color? appBarColor,
    Widget? appBarActions,
    Widget? appBarTitle,
    String? appBarTitleText,
    Widget? appBarLeading,
  }) {
    return _NavViewWithAppBar(
      content: content,
      backgroundColor: backgroundColor,
      appBarTitle: appBarTitle,
      appBarColor: appBarColor,
      appBarActions: appBarActions,
      appBarLeading: appBarLeading,
      appBarTitleText: appBarTitleText,
    );
  }
}

class _RawNavView extends WindowsNavView {
//
  final NavigationPane? navigationPane;
  final NavigationAppBar? appBar;

  const _RawNavView({
    this.appBar,
    this.navigationPane,
    Color? backgroundColor,
    Widget content = const SizedBox.shrink(),
  }) : super(content: content, backgroundColor: backgroundColor);

  @override
  Widget build(BuildContext context) {
    return NavigationPaneTheme(
      data: NavigationPaneThemeData(
        backgroundColor: backgroundColor ?? context.colorScheme.surface,
        unselectedTextStyle: ButtonState.all(
          context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        selectedTextStyle: ButtonState.all(
          context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            // color:
          ),
        ),
      ),
      child: NavigationView(
        contentShape: const RoundedRectangleBorder(),
        appBar: appBar,
        content: content,
        pane: navigationPane,
      ),
    );
  }
}
