import 'package:clinic_v2/app/features/user_preferences/appearance/view/locale/adaptive_locale_menu.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/view/theme/adaptive_theme_switch.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            AdaptiveLocaleMenu(LocaleDropDownMenuType.menuOnly),
            SizedBox(width: 8),
            AdaptiveThemeSwitch(
              ThemeModeSwitchType.icon,
            ),
          ],
        ),
      ),
    );
  }
}
