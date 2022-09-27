import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CustomNavPaneItem extends PaneItem {
  CustomNavPaneItem({
    required String title,
    required IconData iconData,
    required BuildContext context,
  }) : super(
          icon: Icon(iconData, size: 22),
          title: Text(title),
          selectedTileColor: ButtonState.resolveWith((states) {
            if (states.isPressing || states.isHovering) {
              return context.fluentTheme.accentColor.lighter;
            }
            return context.fluentTheme.accentColor.lightest;
          }),
        );
}
