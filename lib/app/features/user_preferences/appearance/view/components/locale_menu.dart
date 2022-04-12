import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/features/user_preferences/appearance/cubit/preferences_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LocaleDropDownMenuType { menuOnly, tileWithMenu }

class LocaleDropDownMenu extends Component {
  const LocaleDropDownMenu(this.type, {Key? key}) : super(key: key);
  final LocaleDropDownMenuType type;
  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
    return BlocBuilder<AppearancePreferencesCubit, AppearancePreferencesState>(
      builder: (context, state) {
        return Material(
          type: MaterialType.transparency,
          child: type == LocaleDropDownMenuType.menuOnly
              ? DropdownButtonHideUnderline(child: _dropDownLocaleMenu(context))
              : _tileWithLocaleDropDownMenu(context),
        );
      },
    );
  }

  Widget _tileWithLocaleDropDownMenu(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language_outlined),
      title: Text('Language'),
      subtitle: _dropDownLocaleMenu(context, showIcon: false),
    );
  }

  Widget _dropDownLocaleMenu(BuildContext context, {bool showIcon = true}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<Locale>(
        icon: showIcon ? null : const SizedBox.shrink(),
        elevation: 4,
        dropdownColor: context.colorScheme.backgroundColor,
        iconEnabledColor: context.colorScheme.onPrimaryContainer,
        style: context.textTheme.subtitle1?.copyWith(
          color: context.colorScheme.onPrimary,
        ),
        value: Locale(Localizations.localeOf(context).languageCode),
        items: AppLocalizations.supportedLocales
            .map((e) => DropdownMenuItem<Locale>(
                  value: e,
                  child: Text(
                    e.languageCode.toUpperCase(),
                    style: context.textTheme.bodyText1?.copyWith(
                      color: context.colorScheme.onBackground,
                    ),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            context.read<AppearancePreferencesCubit>().provideLocale(value);
          }
        },
      ),
    );
  }
}
