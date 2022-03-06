import 'package:flutter/material.dart';

import 'md3_color_scheme.dart';

extension ThemeExtension on BuildContext {
  /// similar to [MediaQuery.of(context).theme]
  ThemeData get theme => Theme.of(this);

  /// Check if dark mode theme is enable
  bool get isDarkMode => (theme.brightness == Brightness.dark);

  /// give access to Theme.of(context).iconTheme.color
  Color? get iconColor => theme.iconTheme.color;

  /// similar to [MediaQuery.of(context).padding]
  TextTheme get textTheme => Theme.of(this).textTheme;
}

class AppColorScheme {
  // static bool  isDarkMode
  //
  static const MD3ColorScheme md3Dark = MD3ColorScheme.dark(
    primary: Color(0xFF85beb7),
    // primary: Color(0xFF78aba5),
    secondary: Color(0xFF5c9091),
    primaryContainer: Color(0xFF384349),
    onPrimaryContainer: Color(0xFFd4d5d6),
    secondaryContainer: Color(0xFF30393e),
    onSecondaryContainer: Color(0xFFfdfdfd),
    onPrimary: Color(0xFF1e2827),
    error: Color(0xFFcf6679),
    onError: Color(0xFFfff1f3),
    onBackground: Color(0xFFd4d5d6),
    background: Color(0xFF272f33),
    surface: Color(0xFF30393e),
    onSurface: Color(0xFFdce9e7),
  );

  // Light //
  static const MD3ColorScheme md3Light = MD3ColorScheme(
    primary: Color(0xFF85beb7),
    onPrimary: Color(0xFFffffff),
    primaryContainer: Color(0xFFe7f2f1),
    onPrimaryContainer: Color(0xFF283937),
    secondary: Color(0xFF4a8485),
    secondaryContainer: Color(0xFFdbe6e7),
    onSecondaryContainer: Color(0xFF162828),
    error: Color(0xFFca0025),
    onError: Color(0xFFfff1f4),
    onBackground: Color(0xFF2d3c3a),
    background: Color(0xFFffffff),
    surface: Color(0xFFf3f9f8),
    onSurface: Color(0xFF293634),
    // ============================== //
    /** NEW COLOR SCHEME **
     *
    primary: Color(0xFF7aa29d),
    onPrimary: Color(0xFFffffff),
    primaryContainer: Color(0xFFf2f6f5),
    onPrimaryContainer: Color(0xFF3d514f),
    // onPrimaryContainer: Color(0xFF31413f),
    secondary: Color(0xFF55716e),
    secondaryContainer: Color(0xFFdbe6e7),
    onSecondaryContainer: Color(0xFF31413f),
    error: Color(0xFFca0025),
    onError: Color(0xFFfff1f4),
    onBackground: Color(0xFF25312f),
    background: Color(0xFFffffff),
    surface: Color(0xFFf9fbfb),
    onSurface: Color(0xFF31413f),
     */
  );

  static Color? primary(BuildContext context) =>
      context.isDarkMode ? md3Dark.primary : md3Light.primary;

  static Color? secondary(BuildContext context) =>
      context.isDarkMode ? md3Dark.secondary : md3Light.secondary;

  static Color? secondaryContainer(BuildContext context) => context.isDarkMode
      ? md3Dark.secondaryContainer
      : md3Light.secondaryContainer;

  static Color? onSecondaryContainer(BuildContext context) => context.isDarkMode
      ? md3Dark.onSecondaryContainer
      : md3Light.onSecondaryContainer;

  static Color? primaryContainer(BuildContext context) =>
      context.isDarkMode ? md3Dark.primaryContainer : md3Light.primaryContainer;

  static Color? onPrimaryContainer(BuildContext context) => context.isDarkMode
      ? md3Dark.onPrimaryContainer
      : md3Light.onPrimaryContainer;

  static Color? onPrimary(BuildContext context) =>
      context.isDarkMode ? md3Dark.onPrimary : md3Light.onPrimary;

  //
  static Color cardColor(BuildContext context) => context.isDarkMode
      ? md3Dark.secondaryContainer!
      : const Color(0xfff3f9f8);

  ///
  static Color? drawerTileUnselectedColor(BuildContext context) =>
      context.isDarkMode
          ? const Color(0xFFd1e0f0)
          : const Color(0xFF0f1413).withOpacity(.7);

  ///
  static Color? dividerColor(BuildContext context) =>
      onPrimaryContainer(context)?.withOpacity(.2);

  ///
  static Color? navbarDestinationColor(BuildContext context) =>
      context.isDarkMode
          ? const Color(0xFFd1e0f0).withOpacity(.7)
          : const Color(0xFF1b2625).withOpacity(.7);

  static Color? navbarSelectedDestColor(BuildContext context) =>
      context.isDarkMode
          ? const Color(0xFFcee5e2)
          : const Color(0xFF354c49).withOpacity(.9);

  static Color navbarSelectedItemBackgroundColor(BuildContext context) =>
      const Color(0xFFa1cdc7);

  ///
  static Color? shadowColor(BuildContext context) =>
      context.isDarkMode ? const Color(0x90141f29) : const Color(0xFFf5f9f9);
  static Color? unSelectedTextColor(BuildContext context) => context.isDarkMode
      ? const Color(0xFFd0e1df)
      : const Color(0xFF1b2625).withOpacity(.7);

  ///
  static Color? onBackground(BuildContext context) =>
      context.isDarkMode ? md3Dark.onBackground : md3Light.onBackground;

  static Color? errorColor(BuildContext context) =>
      context.isDarkMode ? md3Dark.error : md3Light.error;

  static Color? onError(BuildContext context) =>
      context.isDarkMode ? md3Dark.onError : md3Light.onError;

  static Color textFieldBorderColor(BuildContext context) => context.isDarkMode
      ? const Color(0xffeaf4f3).withOpacity(.4)
      : const Color(0xFF4b6461).withOpacity(.5);

  static Color? backgroundColor(BuildContext context) =>
      context.isDarkMode ? md3Dark.background : md3Light.background;
  static Color? surface(BuildContext context) =>
      context.isDarkMode ? md3Dark.surface : md3Light.surface;
  // ============================================================= //

}
