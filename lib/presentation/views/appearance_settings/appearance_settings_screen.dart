//
import 'package:clinic_v2/presentation/shared_widgets/adaptive_locale_menu.dart';
import 'package:clinic_v2/presentation/shared_widgets/dropdown_menus/utils.dart';
import 'package:clinic_v2/presentation/shared_widgets/adaptive_theme_switch.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';

class AppearanceSettingsScreen extends StatelessWidget {
  const AppearanceSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuilderWithWidgetInfo(builder: (context, widgetInfo) {
      return Material(
        color: context.colorScheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(widgetInfo.widgetSize),
            child: Column(
              children: [
                AdaptiveThemeSwitch(
                  switchType: ThemeModeSwitchType.tile,
                  onThemeChanged: (theme) {},
                ),
                const Divider(),
                AdaptiveLocaleDropdown(
                  type: DropdownMenuType.tileWithMenu,
                  onChanged: (locale) {},
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
