import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';
import 'package:clinic_v2/app/themes/material_themes.dart';

class CustomBackButton extends CustomStatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);
  @override
  Widget? windowsBuilder(BuildContext context, ContextInfo contextInfo) {
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
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return BackButton(
      color: context.colorScheme.onBackground,
    );
  }
}
