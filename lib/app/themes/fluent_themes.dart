import 'package:clinic_v2/app/themes/app_color_scheme.dart';
import 'package:fluent_ui/fluent_ui.dart';

class FluentAppThemes {
  static final ThemeData defaultDarkTheme = ThemeData.dark().copyWith(
    // COLORS
    accentColor: AccentColor(
      'primary',
      const {
        'normal': Color(0xFF78aba5),
        'primary': Color(0xFF78aba5),
        'light': Color(0xFF86b3ae),
        'lighter': Color(0xFF93bcb7),
        'lightest': Color(0xFFa1c4c0),
        'dark': Color(0xFF6c9a95),
        'darker': Color(0xFF608984),
        'darkest': Color(0xFF547873),
      },
    ),
    menuColor: AppColorScheme.darkColorScheme.surface,
    buttonTheme: ButtonThemeData(
        iconButtonStyle: ButtonStyle(
      foregroundColor:
          ButtonState.all(AppColorScheme.darkColorScheme.onBackground),
    )),
    navigationPaneTheme: NavigationPaneThemeData(
      backgroundColor: AppColorScheme.darkColorScheme.surface,
    ),
    checkedColor: AppColorScheme.darkColorScheme.primary,
    // tooltipTheme:
    //     TooltipThemeData.standard(ThemeData.dark()).merge(TooltipThemeData(
    //   showDuration: const Duration(seconds: 1),
    //   textStyle:
    //       Typography.fromBrightness(brightness: Brightness.dark).body?.copyWith(
    //             color: AppColorScheme.darkColorScheme.onPrimaryContainer,
    //           ),
    //   decoration: BoxDecoration(
    //     boxShadow: [
    //       BoxShadow(
    //         // color: Colors.transparent,
    //         color: AppColorScheme.darkColorScheme.onBackground.withOpacity(0.1),
    //         offset: const Offset(1, 1),
    //         blurRadius: 10.0,
    //       ),
    //     ],
    //     borderRadius: BorderRadius.circular(4),
    //     color: AppColorScheme.darkColorScheme.primaryContainer,
    //   ),
    // )),
    //
    scaffoldBackgroundColor: AppColorScheme.darkColorScheme.background,
    // default Text Theme //
    typography: _getThemeTypography(
      const Color(0xFFe4e9eb),
      const Color(0xFFe0eeec),
    ),
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    //
    accentColor: AccentColor(
      'primary',
      const {
        'normal': Color(0xFF85beb7),
        'primary': Color(0xFF85beb7),
        'light': Color(0xFF9dcbc5),
        'lighter': Color(0xFFc2dfdb),
        'lightest': Color(0xFFe7f2f1),
        'dark': Color(0xFF6a9892),
        'darker': Color(0xFF435f5c),
        'darkest': Color(0xFF1b2625),
      },
    ),
    // 'lightest': Color(0xFFE5F5F2),
    // 'lighter': Color(0xFFB8DED8),
    // 'darker': Color(0xFF569B91),
    // 'darkest': Color(0xFF338076),
    scaffoldBackgroundColor: AppColorScheme.lightColorScheme.background,
    checkedColor: AppColorScheme.lightColorScheme.primary,
    // tooltipTheme: TooltipThemeData.standard(ThemeData.light()).merge(
    //   TooltipThemeData(
    //     showDuration: const Duration(seconds: 1),
    //     textStyle: Typography.fromBrightness(brightness: Brightness.light)
    //         .body
    //         ?.copyWith(
    //           color: AppColorScheme.lightColorScheme.onPrimaryContainer,
    //         ),
    //     decoration: BoxDecoration(
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.black.withOpacity(0.2),
    //           offset: const Offset(1, 1),
    //           blurRadius: 10.0,
    //         ),
    //       ],
    //       borderRadius: BorderRadius.circular(4),
    //       color: AppColorScheme.lightColorScheme.primaryContainer,
    //     ),
    // //   ),
    // ),
    navigationPaneTheme: NavigationPaneThemeData(
      backgroundColor: AppColorScheme.lightColorScheme.surface,
    ),
    typography: _getThemeTypography(
      const Color(0xFF0f1413),
      const Color(0xFF1e2827),
    ),
  );

  static Typography _getThemeTypography(Color mainColor, Color secondaryColor) {
    return Typography.raw(
      display: TextStyle(
        fontSize: 68,
        color: mainColor,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        fontSize: 40,
        color: mainColor,
        fontWeight: FontWeight.w600,
      ),
      title: TextStyle(
        fontSize: 28,
        color: mainColor,
        fontWeight: FontWeight.w600,
      ),
      subtitle: TextStyle(
        fontSize: 20,
        color: mainColor,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        color: secondaryColor,
        fontWeight: FontWeight.w600,

        // fontWeight: FontWeight.normal,
      ),
      bodyStrong: TextStyle(
        fontSize: 14,
        color: secondaryColor,
        fontWeight: FontWeight.w600,
      ),
      body: TextStyle(
        fontSize: 14,
        color: secondaryColor,
        fontWeight: FontWeight.w600,

        // fontWeight: FontWeight.normal,
      ),
      caption: TextStyle(
        fontSize: 12,
        color: secondaryColor,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
