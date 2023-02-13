import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:flutter/services.dart';

import '../../presentation/themes/app_color_scheme.dart';

class MaterialAppThemes {
  static TooltipThemeData getTooltipThemeDataForDesktop(BuildContext context) {
    return TooltipThemeData(
      height: context.isDesktopPlatform ? 32.0 : null,
      verticalOffset: context.isDesktopPlatform ? 24.0 : null,
      // showDuration:
      waitDuration: const Duration(seconds: 1),
      textStyle: context.isDesktopPlatform
          ? context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onPrimaryContainer,
            )
          : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.isDesktopPlatform ? 4 : 16),
        color: context.colorScheme.primaryContainer,
      ),
    );
  }

  static ThemeData of(BuildContext context) =>
      context.isDarkMode ? defaultDarkTheme : lightTheme;
  static final ThemeData defaultDarkTheme =
      ThemeData.dark(useMaterial3: true).copyWith(
    // Colors //
    brightness: Brightness.dark,
    colorScheme: AppColorScheme.darkColorScheme,
    useMaterial3: true,

    // ----------------- //
    dialogTheme: const DialogTheme(
      backgroundColor: _darkModeBackgroundColor,
    ),
    // ----------------- //
    appBarTheme: AppBarTheme(
      titleTextStyle: const TextStyle(
        fontFamily: 'inter',
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Color(0xFFd4d5d6),
      ),
      foregroundColor: const Color(0xFFd4d5d6),
      backgroundColor: _darkModeBackgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: _darkModeBackgroundColor,
        systemNavigationBarContrastEnforced: true,
      ),
    ),

    scaffoldBackgroundColor: _darkModeBackgroundColor,

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColorScheme.darkColorScheme.primary,
      foregroundColor: const Color(0xFFf3f8f7),
      elevation: 4,
    ),
    //
    tabBarTheme: const TabBarTheme(
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF78aba5),
            width: 2,
          ),
        ),
      ),
      labelColor: Color(0xFFd4d5d6),
    ),

    // default Text Theme //
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontFamily: 'inter', color: Color(0xFFe4e9eb)),
      headlineMedium: TextStyle(fontFamily: 'inter', color: Color(0xFFe4e9eb)),
      headlineSmall: TextStyle(fontFamily: 'inter', color: Color(0xFFe4e9eb)),
      titleLarge: TextStyle(
        fontFamily: 'inter',
        color: Color(0xFFe4e9eb),
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontFamily: 'inter',
        color: Color(0xFFe4e9eb),
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontFamily: 'inter',
        color: Color(0xFFe4e9eb),
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w500,
        color: Color(0xFFe0eeec),
        fontFamily: 'inter',
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: Color(0xFFe0eeec),
        fontFamily: 'inter',
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xFFe0eeec),
        fontFamily: 'inter',
      ),
    ),
    //
    //
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          const BorderSide(
            color: Color(0xFF87b3ae),
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ),
  );

  static const lightSysOverlayStyle = SystemUiOverlayStyle.light;

  // ====================LIGHT THEME===================== //
  static ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    useMaterial3: true,
    //
    scaffoldBackgroundColor: _lightModeBackgroundColor,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'inter',
        fontSize: 20,
        color: AppColorScheme.darkColorScheme.onBackground,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: _lightModeBackgroundColor,
      foregroundColor: AppColorScheme.darkColorScheme.onBackground,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: _lightModeBackgroundColor,
        systemNavigationBarContrastEnforced: true,
      ),
    ),

    colorScheme: AppColorScheme.lightColorScheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Color(0xFFf5f9f9),
      elevation: 4,
    ),
    //
    tabBarTheme: const TabBarTheme(
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF91c5be),
            width: 2,
          ),
        ),
      ),
      labelColor: Color(0xFF293634),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(color: AppColorScheme.darkColorScheme.secondary),
        ),
        overlayColor: MaterialStateProperty.all(const Color(0xFF1e2827)),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            color: Color(0xFF1e2827),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    ),
    dialogTheme: DialogTheme(
        backgroundColor: AppColorScheme.darkColorScheme.primaryContainer),
    //
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontFamily: 'inter', color: Color(0xFF0f1413)),
      headlineMedium: TextStyle(fontFamily: 'inter', color: Color(0xFF0f1413)),
      headlineSmall: TextStyle(fontFamily: 'inter', color: Color(0xFF0f1413)),
      titleLarge: TextStyle(
        fontFamily: 'inter',
        color: Color(0xFF0f1413),
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontFamily: 'inter',
        color: Color(0xFF0f1413),
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: 'inter',
        color: Color(0xFFe4e9eb),
        fontWeight: FontWeight.w500,
      ),
      // titleMedium: const TextStyle(
      //   fontFamily: 'inter',
      //   fontSize: 16,
      //   color: Color(0xFF0f1413),
      // ),
      // subtitle2: const TextStyle(
      //   fontFamily: 'inter',
      //   fontSize: 14,
      //   fontWeight: FontWeight.w500,
      //   color: Color(0xFF0f1413),
      // ),
      bodyLarge: TextStyle(
        color: Color(0xFF1e2827),
        fontWeight: FontWeight.w500,
        fontFamily: 'inter',
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xFF1e2827),
        fontFamily: 'inter',
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xFF1e2827),
        fontFamily: 'inter',
      ),
    ),
  );

  static const _darkModeBackgroundColor = Color(0xFF272f33);
  static const _lightModeBackgroundColor = Color(0xFFffffff);
// static const _lightModeBackgroundColor = Color(0xFFF8FBFB);
}
