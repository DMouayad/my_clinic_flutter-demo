import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';

NavigationAppBar buildCustomAppBar(
  BuildContext context, {
  Color? appBarColor,
  Widget? appBarActions,
  Widget? appBarTitle,
  String? appBarTitleText,
  Widget? appBarLeading,
  bool autoShowBackButton = true,
}) {
  Widget? getLeading(BuildContext context) {
    final showBackButton = autoShowBackButton &&
        Navigator.of(context).canPop() &&
        (ModalRoute.of(context)?.isCurrent == true);

    if (appBarLeading != null || showBackButton) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (appBarLeading != null) appBarLeading,
          if (showBackButton)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: IconButton(
                iconButtonMode: IconButtonMode.large,
                style: ButtonStyle(
                  iconSize: ButtonState.all(16),
                ),
                icon: const Icon(FluentIcons.back),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            )
        ],
      );
    }
    return null;
  }

  return NavigationAppBar(
    title: Container(
      alignment: context.isLTR ? Alignment.centerLeft : Alignment.centerRight,
      child: appBarTitle ??
          Text(
            appBarTitleText!,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
    ),
    height: 55,
    automaticallyImplyLeading: false,
    leading: getLeading(context),
    actions: appBarActions,
    backgroundColor: appBarColor ?? context.colorScheme.backgroundColor,
  );
}
