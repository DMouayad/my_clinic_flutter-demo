part of 'locale_menu.dart';

class _WindowsLocaleMenu extends StatelessWidget {
  const _WindowsLocaleMenu(this.type, {Key? key}) : super(key: key);
  final LocaleDropDownMenuType type;

  @override
  Widget build(BuildContext context) {
    return type == LocaleDropDownMenuType.menuOnly
        ? _buildDropDownMenu(context)
        : WindowsSettingTile(
            tileLabel: AppLocalizations.of(context)!.language,
            leadingIcon:
                const fluent_ui.Icon(fluent_ui.FluentIcons.locale_language),
            titleText: AppLocalizations.of(context)!.selectAppLang,
            trailing: SizedBox(
              width: 300,
              child: fluent_ui.Combobox<Locale>(
                itemHeight: 52,
                onChanged: (selectedValue) {
                  if (selectedValue != null) {
                    context
                        .read<AppearancePreferencesCubit>()
                        .provideLocale(selectedValue);
                  }
                },
                value: Locale(Localizations.localeOf(context).languageCode),
                isExpanded: true,
                items: AppLocalizations.supportedLocales
                    .map((e) => fluent_ui.ComboboxItem(
                          value: e,
                          child: Text(
                            e.languageCode.toUpperCase(),
                            style: context.textTheme.labelLarge,
                          ),
                        ))
                    .toList(),
              ),
            ),
          );
  }

  Widget _buildDropDownMenu(BuildContext context) {
    return fluent_ui.FluentTheme(
      data: fluent_ui.FluentTheme.of(context).copyWith(
        buttonTheme: fluent_ui.ButtonThemeData(
          defaultButtonStyle: fluent_ui.ButtonStyle(
            border: fluent_ui.ButtonState.all(
              fluent_ui.BorderSide.none,
            ),
            elevation: fluent_ui.ButtonState.all(0),
            backgroundColor: fluent_ui.ButtonState.all(Colors.transparent),
            foregroundColor:
                fluent_ui.ButtonState.all(context.colorScheme.onBackground),
          ),
        ),
      ),
      child: fluent_ui.Tooltip(
        message: AppLocalizations.of(context)!.selectAppLang,
        // message: ,
        child: fluent_ui.DropDownButton(
          menuDecoration: BoxDecoration(
            color: context.colorScheme.backgroundColor,
          ),
          title: Text(
            Locale(Localizations.localeOf(context).languageCode).toString(),
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onBackground,
            ),
          ),
          items: AppLocalizations.supportedLocales
              .map((e) => fluent_ui.DropDownButtonItem(
                    onTap: () {
                      context
                          .read<AppearancePreferencesCubit>()
                          .provideLocale(e);
                    },
                    leading: const fluent_ui.Icon(
                      fluent_ui.FluentIcons.locale_language,
                    ),
                    title: Text(
                      e.languageCode.toUpperCase(),
                      style: context.textTheme.labelLarge,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _AndroidLocaleMenu extends StatelessWidget {
  const _AndroidLocaleMenu(this.type, {Key? key}) : super(key: key);
  final LocaleDropDownMenuType type;

  @override
  Widget build(BuildContext context) {
    return type == LocaleDropDownMenuType.menuOnly
        ? _dropDownLocaleMenu(context)
        : ListTile(
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
