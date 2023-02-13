import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'windows_nav_view.dart';

class WindowsNavViewWithPane extends StatefulWidget {
  const WindowsNavViewWithPane({
    this.footerItems = const [],
    required this.items,
    Key? key,
    this.appBar,
    this.header,
    this.autoSuggestBox,
    this.displayMode = PaneDisplayMode.auto,
    this.autoSuggestBoxReplacement,
  }) : super(key: key);

  final List<NavigationPaneItem> footerItems;
  final List<NavigationPaneItem> items;
  final Widget? header;
  final Widget? autoSuggestBoxReplacement;
  final Widget? autoSuggestBox;
  final NavigationAppBar? appBar;
  final PaneDisplayMode displayMode;

  @override
  _WindowsNavViewWithPaneState createState() => _WindowsNavViewWithPaneState();
}

class _WindowsNavViewWithPaneState extends State<WindowsNavViewWithPane> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WindowsNavView.raw(
      appBar: widget.appBar,
      navigationPane: NavigationPane(
        autoSuggestBox: widget.autoSuggestBox,
        autoSuggestBoxReplacement: widget.autoSuggestBoxReplacement,
        selected: _currentIndex,
        displayMode: widget.displayMode,
        onChanged: (value) {
          setState(() => _currentIndex = value);
        },
        size: NavigationPaneSize(
          headerHeight: 40,
          // openMinWidth: ,
          openMaxWidth: context.isDesktop
              ? context.screenWidth * .2
              : context.isTablet
                  ? context.screenWidth * .34
                  : context.screenWidth * .5,
        ),
        header: widget.header != null
            ? Container(
                alignment: context.isLTR
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                padding: const EdgeInsets.all(8.0),
                child: widget.header,
              )
            : const SizedBox(),
        footerItems: widget.footerItems,
        items: widget.items,
      ),
    );
  }
}
