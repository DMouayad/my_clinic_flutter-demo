import 'package:fluent_ui/fluent_ui.dart';
//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';

import '../../../../presentation/shared_widgets/windows_components/custom_nav_view/windows_app_bar.dart';

export '../../../../presentation/shared_widgets/windows_components/custom_nav_view/custom_nav_pane_item.dart';

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
