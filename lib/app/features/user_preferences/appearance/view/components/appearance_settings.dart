//
import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/view/components/locale/locale_menu.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/view/components/theme/theme_mode_switch.dart';

class AppearanceSettingsScreen extends Component {
  const AppearanceSettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(BuildContext context, contextInfo) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(contextInfo.widgetSize!),
      child: Column(
        children: const [
          ThemeModeSwitch(
            ThemeModeSwitchType.tile,
          ),
          LocaleDropDownMenu(LocaleDropDownMenuType.tileWithMenu),
        ],
      ),
    );
  }
}
