// import 'package:flutter/material.dart';
// import '';
// import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/extensions/context_extensions.dart';
import 'package:clinic_v2/app/infrastructure/themes/app_color_scheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:fluent_ui/fluent_ui.dart';

class WindowsToggleSwitch extends StatelessWidget {
  const WindowsToggleSwitch({
    required this.checked,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final bool checked;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      content: Text(
        checked
            ? AppLocalizations.of(context)!.enabled
            : AppLocalizations.of(context)!.disabled,
        style: context.textTheme.bodyText2,
      ),
      style: _getSwitchStyle(context),
      checked: checked,
      onChanged: onChanged,
    );
  }

  ToggleSwitchThemeData _getSwitchStyle(BuildContext context) {
    final defaultThumbDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(100),
    );

    final defaultDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(100),
    );
    final style = FluentTheme.of(context);

    return ToggleSwitchThemeData(
      checkedDecoration: ButtonState.resolveWith((states) {
        return defaultDecoration.copyWith(
          color: !states.isDisabled
              ? states.isHovering
                  ? context.colorScheme.secondary
                  : context.colorScheme.primary
              //  ButtonThemeData.checkedInputColor(style, states)
              : style.brightness.isLight
                  ? const Color.fromRGBO(0, 0, 0, 0.2169)
                  : const Color.fromRGBO(255, 255, 255, 0.1581),
          border: Border.all(
            width: 1,
            color: Colors.transparent,
          ),
        );
      }),
      uncheckedDecoration: ButtonState.resolveWith((states) {
        return defaultDecoration.copyWith(
          color: !states.isDisabled
              ? states.isHovering
                  ? context.isDarkMode
                      ? context.colorScheme.secondaryContainer
                      : AppColorScheme.darkColorScheme.primary
                  : Colors.transparent
              // ? ButtonThemeData.uncheckedInputColor(style, states)
              : Colors.transparent,
          border: Border.all(
            width: 1,
            color: !states.isDisabled
                ? context.colorScheme.onBackground!.withOpacity(.25)
                : style.brightness.isLight
                    ? const Color.fromRGBO(0, 0, 0, 0.2169)
                    : const Color.fromRGBO(255, 255, 255, 0.1581),
          ),
        );
      }),
      margin: const EdgeInsets.all(4),
      animationDuration: style.fastAnimationDuration,
      animationCurve: style.animationCurve,
      checkedThumbDecoration: ButtonState.resolveWith((states) {
        return defaultThumbDecoration.copyWith(
          color: !states.isDisabled
              ? states.isHovering
                  ? context.colorScheme.onBackground
                  : context.colorScheme.onPrimary
              : style.brightness.isLight
                  ? Colors.white
                  : const Color.fromRGBO(255, 255, 255, 0.5302),
        );
      }),
      uncheckedThumbDecoration: ButtonState.resolveWith((states) {
        return defaultThumbDecoration.copyWith(
          color: !states.isDisabled
              ? states.isHovering
                  ? context.isDarkMode
                      ? style.uncheckedColor
                      : context.colorScheme.onPrimary
                  : style.uncheckedColor
              : style.brightness.isLight
                  ? const Color.fromRGBO(0, 0, 0, 0.3614)
                  : const Color.fromRGBO(255, 255, 255, 0.3628),
        );
      }),
    );
  }
}
