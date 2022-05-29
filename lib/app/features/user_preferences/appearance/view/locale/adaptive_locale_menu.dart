import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets//windows_components/windows_settings_tile.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/preferences_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
part 'custom_locale_menus.dart';

enum LocaleDropDownMenuType { menuOnly, tileWithMenu }

class AdaptiveLocaleMenu extends ResponsiveStatelessWidget {
  const AdaptiveLocaleMenu(this.type, {Key? key}) : super(key: key);
  final LocaleDropDownMenuType type;

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return BlocBuilder<AppearancePreferencesCubit, AppearancePreferencesState>(
      builder: (context, state) {
        if (context.isDesktopPlatform) {
          return _WindowsLocaleMenu(type);
        } else {
          return _AndroidLocaleMenu(type);
        }
      },
    );
  }
}
