part of 'windows_nav_view.dart';

class _NavViewWithAppBar extends WindowsNavView {
  const _NavViewWithAppBar({
    super.key,
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
      appBar: buildCustomAppBar(
        context,
        appBarActions: appBarActions,
        appBarColor: appBarColor,
        appBarLeading: appBarLeading,
        appBarTitle: appBarTitle,
        appBarTitleText: appBarTitleText,
      ),
    );
  }
}
