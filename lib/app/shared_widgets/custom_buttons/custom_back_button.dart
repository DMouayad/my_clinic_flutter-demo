import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/themes/material_themes.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  Widget _windowsBuilder(BuildContext context) {
    return Theme(
      data: context.theme.copyWith(
        splashFactory: NoSplash.splashFactory,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        tooltipTheme: MaterialAppThemes.getTooltipThemeDataForDesktop(context),
      ),
      child: BackButton(
        color: context.colorScheme.onBackground,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.isWindowsPlatform
        ? _windowsBuilder(context)
        : BackButton(
            color: context.colorScheme.onBackground,
          );
  }
}
