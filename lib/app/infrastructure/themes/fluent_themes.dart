import 'package:clinic_v2/app/infrastructure/themes/app_color_scheme.dart';
import 'package:fluent_ui/fluent_ui.dart';

class FluentAppThemes {
  static final ThemeData defaultDarkTheme = ThemeData.dark().copyWith(
    // ----------------- //
    // dialogTheme: const DialogTheme(
    //   backgroundColor: _darkModeBackgroundColor,
    // ),
    // ----------------- //
    // bar: AppBarTheme(
    //   titleTextStyle: const TextStyle(
    //     fontFamily: 'inter',
    //     fontSize: 20,
    //     fontWeight: FontWeight.w500,
    //     color: Color(0xFFd4d5d6),
    //   ),
    //   foregroundColor: const Color(0xFFd4d5d6),
    //   backgroundColor: _darkModeBackgroundColor,
    //   systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
    //     statusBarColor: _darkModeBackgroundColor,
    //     systemNavigationBarContrastEnforced: true,
    //   ),
    // ),

    // tabBarTheme: const TabBarTheme(
    //   indicator: BoxDecoration(
    //     border: Border(
    //       bottom: BorderSide(
    //         color: Color(0xFF78aba5),
    //         width: 2,
    //       ),
    //     ),
    //   ),
    //   labelColor: Color(0xFFd4d5d6),
    // ),
    // COLORS
    // accentColor: AccentColor(),
    checkedColor: AppColorScheme.darkColorScheme.primary,
    tooltipTheme:
        TooltipThemeData.standard(ThemeData.dark()).merge(TooltipThemeData(
      showDuration: const Duration(seconds: 1),
      textStyle:
          Typography.fromBrightness(brightness: Brightness.dark).body?.copyWith(
                color: AppColorScheme.darkColorScheme.onPrimaryContainer,
              ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            // color: Colors.transparent,
            color: AppColorScheme.darkColorScheme.onBackground.withOpacity(0.1),
            offset: const Offset(1, 1),
            blurRadius: 10.0,
          ),
        ],
        borderRadius: BorderRadius.circular(4),
        color: AppColorScheme.darkColorScheme.primaryContainer,
      ),
    )),
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
    scaffoldBackgroundColor: AppColorScheme.lightColorScheme.background,
    checkedColor: AppColorScheme.lightColorScheme.primary,
    tooltipTheme:
        TooltipThemeData.standard(ThemeData.light()).merge(TooltipThemeData(
      showDuration: const Duration(seconds: 1),
      textStyle: Typography.fromBrightness(brightness: Brightness.light)
          .body
          ?.copyWith(
            color: AppColorScheme.lightColorScheme.onPrimaryContainer,
          ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(1, 1),
            blurRadius: 10.0,
          ),
        ],
        borderRadius: BorderRadius.circular(4),
        color: AppColorScheme.lightColorScheme.primaryContainer,
      ),
    )),
    // appBarTheme: AppBarTheme(
    //   titleTextStyle: TextStyle(
    //     fontFamily: 'inter',
    //     fontSize: 20,
    //     color: AppColorScheme.darkColorScheme.onBackground,
    //     fontWeight: FontWeight.w500,
    //   ),
    //   backgroundColor: _lightModeBackgroundColor,
    //   foregroundColor: AppColorScheme.darkColorScheme.onBackground,
    //   systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
    //     statusBarColor: _lightModeBackgroundColor,
    //     systemNavigationBarContrastEnforced: true,
    //   ),
    // ),

    //
    // tabBarTheme: const TabBarTheme(
    //   indicator: BoxDecoration(
    //     border: Border(
    //       bottom: BorderSide(
    //         color: Color(0xFF91c5be),
    //         width: 2,
    //       ),
    //     ),
    //   ),
    //   labelColor: Color(0xFF293634),
    // ),
    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: ButtonStyle(
    //     shape: MaterialStateProperty.all(
    //       RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //     ),
    //     side: MaterialStateProperty.all(
    //       BorderSide(color: AppColorScheme.darkColorScheme.secondary),
    //     ),
    //     overlayColor: MaterialStateProperty.all(const Color(0xFF1e2827)),
    //     textStyle: MaterialStateProperty.all(
    //       const TextStyle(
    //         color: Color(0xFF1e2827),
    //         fontWeight: FontWeight.w600,
    //         fontSize: 14,
    //       ),
    //     ),
    //   ),
    // ),
    // dialogTheme: DialogTheme(
    // backgroundColor: AppColorScheme.darkColorScheme.primaryContainer),
    //
    typography: _getThemeTypography(
      const Color(0xFF0f1413),
      const Color(0xFF1e2827),
    ),
  );

  // static const _darkModeBackgroundColor = Color(0xFF272f33);
  // static const _lightModeBackgroundColor = Color(0xFFffffff);
  // static const _lightModeBackgroundColor = Color(0xFFF8FBFB);
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
        fontWeight: FontWeight.w500,
      ),
      title: TextStyle(
        fontSize: 28,
        color: mainColor,
        fontWeight: FontWeight.w600,
      ),
      subtitle: TextStyle(
        fontSize: 20,
        color: mainColor,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        color: secondaryColor,
        fontWeight: FontWeight.normal,
      ),
      bodyStrong: TextStyle(
        fontSize: 14,
        color: secondaryColor,
        fontWeight: FontWeight.w600,
      ),
      body: TextStyle(
        fontSize: 14,
        color: secondaryColor,
        fontWeight: FontWeight.normal,
      ),
      caption: TextStyle(
        fontSize: 12,
        color: secondaryColor,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
