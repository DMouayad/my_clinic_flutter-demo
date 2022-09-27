import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/shared_widgets/app_name_text.dart';
import 'package:fluent_ui/fluent_ui.dart';

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
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: appBarTitle ??
              Text(
                appBarTitleText!,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
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

  const WindowsNavView({
    Key? key,
    required this.content,
    this.backgroundColor,
  }) : super(key: key);

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
  const factory WindowsNavView.withAppBar({
    required Widget content,
    Color? backgroundColor,
    Color? appBarColor,
    Widget? appBarActions,
    Widget? appBarTitle,
    String? appBarTitleText,
    Widget? appBarLeading,
  }) = _NavViewWithAppBar;
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
        highlightColor: context.colorScheme.primary,
        tileColor: ButtonState.resolveWith(
          (states) {
            if (states.isPressing) {
              return context.fluentTheme.accentColor.lighter;
            }
            if (states.isHovering) {
              return Colors.white;
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

class WindowsNavViewWithPane extends StatefulWidget {
  const WindowsNavViewWithPane({
    required this.contentWidgets,
    required this.footerItems,
    required this.items,
    Key? key,
  }) : super(key: key);

  final List<Widget> contentWidgets;
  final List<NavigationPaneItem> footerItems;
  final List<NavigationPaneItem> items;

  @override
  _WindowsNavViewWithPaneState createState() => _WindowsNavViewWithPaneState();
}

class _WindowsNavViewWithPaneState extends State<WindowsNavViewWithPane> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WindowsNavView.raw(
      content: Container(
        constraints: const BoxConstraints.expand(),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colorScheme.surface,
        ),
        child: widget.contentWidgets[_currentIndex],
      ),
      navigationPane: NavigationPane(
        selected: _currentIndex,
        onChanged: (value) {
          setState(() => _currentIndex = value);
        },
        size: const NavigationPaneSize(
          headerHeight: 67,
        ),
        header: Container(
          alignment:
              context.isLTR ? Alignment.centerLeft : Alignment.centerRight,
          padding: const EdgeInsets.all(8.0),
          child: AppNameText(
            fontSize: 26,
            fontColor: context.colorScheme.primary,
          ),
        ),
        footerItems: widget.footerItems,
        items: widget.items,
      ),
    );
  }
}
