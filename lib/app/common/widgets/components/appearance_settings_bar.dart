import 'package:clinic_v2/app/features/user_preferences/appearance/view/components/locale/locale_menu.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/view/components/theme/theme_mode_switch.dart';
import 'package:flutter/material.dart';

class AppearanceSettingsBar extends StatelessWidget {
  const AppearanceSettingsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 2,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            LocaleDropDownMenu(LocaleDropDownMenuType.menuOnly),
            SizedBox(width: 8),
            ThemeModeSwitch(
              ThemeModeSwitchType.icon,
            ),
          ],
        ),
      ),
    );
  }
}
