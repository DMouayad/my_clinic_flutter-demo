import 'package:clinic_v2/app/features/user_preferences/appearance/view/components/locale_menu.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/view/components/theme_mode_switch.dart';
import 'package:flutter/material.dart';

class LeftSideAppearanceSettings extends StatelessWidget {
  const LeftSideAppearanceSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            LocaleDropDownMenu(LocaleDropDownMenuType.menuOnly),
            SizedBox(width: 8),
            ThemeModeSwitch(
              switchType: ThemeModeSwitchType.icon,
            ),
          ],
        ),
      ),
    );
  }
}
