//
import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';

import 'locale/adaptive_locale_menu.dart';
import 'theme/adaptive_theme_switch.dart';

class AppearanceSettingsScreen extends CustomStatelessWidget {
  const AppearanceSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return Material(
      color: context.colorScheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
        child: ConstrainedBox(
          constraints: BoxConstraints.loose(contextInfo.widgetSize!),
          child: Column(
            children: const [
              AdaptiveThemeSwitch(
                ThemeModeSwitchType.tile,
              ),
              Divider(),
              AdaptiveLocaleMenu(LocaleDropDownMenuType.tileWithMenu),
            ],
          ),
        ),
      ),
    );
  }
}
