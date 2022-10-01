part of 'windows_nav_view.dart';

class _RawNavView extends WindowsNavView {
//
  final NavigationPane? navigationPane;
  final NavigationAppBar? appBar;

  const _RawNavView({
    this.appBar,
    this.navigationPane,
    Color? backgroundColor,
    Widget? content,
  }) : super(content: content, backgroundColor: backgroundColor);

  @override
  Widget build(BuildContext context) {
    return NavigationPaneTheme(
      data: NavigationPaneThemeData(
        highlightColor: context.colorScheme.primary,
        tileColor: ButtonState.resolveWith(
          (states) {
            if (states.isPressing) {
              return Colors.white;
            }
            if (states.isHovering) {
              return context.fluentTheme.accentColor.lighter;
            }
          },
        ),
        selectedIconColor:
            ButtonState.all(context.colorScheme.onPrimaryContainer),
        backgroundColor: backgroundColor ?? context.colorScheme.backgroundColor,
        unselectedTextStyle: ButtonState.all(
          context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onBackground,
          ),
        ),
        selectedTextStyle: ButtonState.all(
          context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
      child: NavigationView(
        contentShape: const RoundedRectangleBorder(),
        appBar: appBar,
        content: content != null ? ScaffoldPage(content: content!) : null,
        pane: navigationPane,
      ),
    );
  }
}
