import 'package:clinic_v2/app/common/extensions/context_extensions.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/view/components/locale_menu.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/view/components/theme_mode_switch.dart';
import 'package:flutter/material.dart';

class AppearanceSettingsBar extends StatelessWidget {
  const AppearanceSettingsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.onPrimary?.withOpacity(.12),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
