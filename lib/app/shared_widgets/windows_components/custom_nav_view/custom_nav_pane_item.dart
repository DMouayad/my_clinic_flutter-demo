import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CustomNavPaneItem extends PaneItem {
  CustomNavPaneItem({
    required String title,
    required IconData iconData,
    required BuildContext context,
    required Widget bodyContent,
    EdgeInsets? contentPadding,
  }) : super(
          icon: Icon(iconData, size: 22),
          body: Container(
            constraints: const BoxConstraints.expand(),
            margin: EdgeInsets.fromLTRB(
                context.isLTR ? 30 : 0, 44, context.isLTR ? 0 : 30, 0),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.isDarkMode
                  ? context.colorScheme.primaryContainer
                  : Colors.white,
            ),
            child: bodyContent,
          ),
          title: Text(title),
          selectedTileColor: ButtonState.resolveWith((states) {
            if (states.isPressing || states.isHovering) {
              return context.isDarkMode
                  ? context.fluentTheme.accentColor.darker
                  : context.fluentTheme.accentColor.lighter;
            }
            return context.isDarkMode
                ? context.fluentTheme.accentColor.darkest
                : context.fluentTheme.accentColor.lightest;
          }),
        );
}
