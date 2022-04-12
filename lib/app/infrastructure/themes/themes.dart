import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color_scheme.dart';

class AppThemes {
  static final ThemeData defaultDarkTheme = ThemeData.dark().copyWith(
    // Colors //
    brightness: Brightness.dark,
    androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: const Color(0xFF96C7C1),
      primaryVariant: const Color(0xFF96C7C1),
      secondary: const Color(0xFF89B5AF),
      secondaryVariant: const Color(0xFF89B5AF),
      error: Colors.redAccent[600],
      background: _darkModeBackgroundColor,
    ),

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
      headline4: TextStyle(fontFamily: 'inter', color: Color(0xFFe4e9eb)),
      headline5: TextStyle(fontFamily: 'inter', color: Color(0xFFe4e9eb)),
      headline6: TextStyle(fontFamily: 'inter', color: Color(0xFFe4e9eb)),
      subtitle1: TextStyle(
        fontFamily: 'inter',
        fontSize: 16,
        color: Color(0xFFe4e9eb),
      ),
      subtitle2: TextStyle(
        fontFamily: 'inter',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFFe4e9eb),
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFFe0eeec),
        fontFamily: 'inter',
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFFe0eeec),
        fontFamily: 'inter',
      ),
      button: TextStyle(fontWeight: FontWeight.w500),
      caption: TextStyle(
        // fontSize: 12,
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

  static ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,

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

    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColorScheme.darkColorScheme.primary,
      primaryVariant: AppColorScheme.darkColorScheme.primary,
      secondary: AppColorScheme.darkColorScheme.secondary,
      secondaryVariant: AppColorScheme.darkColorScheme.secondary,
      error: const Color(0xFFB00020),
    ),
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
          BorderSide(color: AppColorScheme.darkColorScheme.secondary!),
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
      headline4: TextStyle(fontFamily: 'inter', color: Color(0xFF0f1413)),
      headline5: TextStyle(fontFamily: 'inter', color: Color(0xFF0f1413)),
      headline6: TextStyle(fontFamily: 'inter', color: Color(0xFF0f1413)),
      subtitle1: TextStyle(
        fontFamily: 'inter',
        fontSize: 16,
        color: Color(0xFF0f1413),
      ),
      subtitle2: TextStyle(
        fontFamily: 'inter',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF0f1413),
      ),
      bodyText1: TextStyle(
        color: Color(0xFF1e2827),
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'inter',
      ),
      bodyText2: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xFF1e2827),
        fontFamily: 'inter',
      ),
      button: TextStyle(
        fontWeight: FontWeight.w500,
        color: Color(0xFF1e2827),
        fontFamily: 'inter',
      ),
      caption: TextStyle(
        fontWeight: FontWeight.w500,
        color: Color(0xFF1e2827),
        fontFamily: 'inter',
      ),
    ),
  );

  static const _darkModeBackgroundColor = Color(0xFF272f33);
  static const _lightModeBackgroundColor = Color(0xFFffffff);
  // static const _lightModeBackgroundColor = Color(0xFFF8FBFB);

}
