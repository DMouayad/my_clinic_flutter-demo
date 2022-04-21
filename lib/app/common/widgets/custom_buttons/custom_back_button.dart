import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/infrastructure/themes/material_themes.dart';

class CustomBackButton extends Component {
  const CustomBackButton({Key? key}) : super(key: key);
  @override
  Widget? windowsDesktopBuilder(BuildContext context, ContextInfo contextInfo) {
    return Theme(
      data: context.theme.copyWith(
        splashFactory: NoSplash.splashFactory,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        tooltipTheme: MaterialAppThemes.getTooltipThemeDataForDesktop(context),
      ),
      child: const BackButton(),
    );
  }

  @override
  Widget mobileBuilder(BuildContext context, ContextInfo contextInfo) {
    return const BackButton();
  }
}
