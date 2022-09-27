import 'package:clinic_v2/app/shared_widgets/custom_widget.dart';
//
import 'package:clinic_v2/app/shared_widgets/dropdown_menus/adaptive_locale_menu.dart';
import 'package:clinic_v2/app/shared_widgets/dropdown_menus/utils.dart';
import 'package:clinic_v2/app/shared_widgets/adaptive_theme_switch.dart';

class AppearanceSettingsScreen extends CustomStatelessWidget {
  const AppearanceSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget customBuild(BuildContext context, WidgetInfo widgetInfo) {
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
              AdaptiveLocaleMenu(
                type: DropdownMenuType.tileWithMenu,
                onChanged: (locale) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
