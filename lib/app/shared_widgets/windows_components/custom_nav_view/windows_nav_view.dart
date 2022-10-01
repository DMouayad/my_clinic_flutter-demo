import 'package:fluent_ui/fluent_ui.dart';
//
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';

import 'windows_app_bar.dart';

export 'custom_nav_pane_item.dart';

part 'nav_view_with_app_bar.dart';
part 'raw_nav_view.dart';

abstract class WindowsNavView extends StatelessWidget {
  final Widget? content;
  final Color? backgroundColor;

  const WindowsNavView({
    Key? key,
    required this.content,
    this.backgroundColor,
  }) : super(key: key);

  const factory WindowsNavView.raw({
    NavigationPane? navigationPane,
    NavigationAppBar? appBar,
    Widget? content,
    Color? backgroundColor,
  }) = _RawNavView;

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
