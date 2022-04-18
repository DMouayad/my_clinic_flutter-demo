import 'package:clinic_v2/app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
export 'package:clinic_v2/app/common/extensions/context_extensions.dart';

class AppColorScheme {
  final BuildContext context;

  //
  factory AppColorScheme.of(BuildContext context) {
    return AppColorScheme(context);
  }

  static const ColorScheme darkColorScheme = ColorScheme.dark(
    // primary: Color(0xFF85beb7),
    primary: Color(0xFF78aba5),
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
  static const ColorScheme lightColorScheme = ColorScheme.light(
    // primary: Color(0xFF7aa29d),
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

  AppColorScheme(this.context);

  Color? get primary =>
      context.isDarkMode ? darkColorScheme.primary : lightColorScheme.primary;

  Color? get secondary => context.isDarkMode
      ? darkColorScheme.secondary
      : lightColorScheme.secondary;

  Color? get secondaryContainer => context.isDarkMode
      ? darkColorScheme.secondaryContainer
      : lightColorScheme.secondaryContainer;

  Color? get onSecondaryContainer => context.isDarkMode
      ? darkColorScheme.onSecondaryContainer
      : lightColorScheme.onSecondaryContainer;

  Color? get primaryContainer => context.isDarkMode
      ? darkColorScheme.primaryContainer
      : lightColorScheme.primaryContainer;

  Color? get onPrimaryContainer => context.isDarkMode
      ? darkColorScheme.onPrimaryContainer
      : lightColorScheme.onPrimaryContainer;

  Color? get onPrimary => context.isDarkMode
      ? darkColorScheme.onPrimary
      : lightColorScheme.onPrimary;

  //
  Color? get cardColor => context.isDarkMode
      ? darkColorScheme.secondaryContainer
      : const Color(0xfff3f9f8);

  ///
  Color? get drawerTileUnselectedColor => context.isDarkMode
      ? const Color(0xFFd1e0f0)
      : const Color(0xFF0f1413).withOpacity(.7);

  ///
  Color? get dividerColor => onPrimaryContainer?.withOpacity(.2);

  ///
  Color? get navbarDestinationColor => context.isDarkMode
      ? const Color(0xFFd1e0f0).withOpacity(.7)
      : const Color(0xFF1b2625).withOpacity(.7);

  Color? get navbarSelectedDestColor => context.isDarkMode
      ? const Color(0xFFcee5e2)
      : const Color(0xFF354c49).withOpacity(.9);

  Color get navbarSelectedItemBackgroundColor => const Color(0xFFa1cdc7);

  ///
  Color? get shadowColor =>
      context.isDarkMode ? const Color(0x90141f29) : const Color(0xFFf5f9f9);
  Color? get unSelectedTextColor => context.isDarkMode
      ? const Color(0xFFd0e1df)
      : const Color(0xFF1b2625).withOpacity(.7);

  ///
  Color? get onBackground => context.isDarkMode
      ? darkColorScheme.onBackground
      : lightColorScheme.onBackground;

  Color? get errorColor =>
      context.isDarkMode ? darkColorScheme.error : lightColorScheme.error;

  Color? get onError =>
      context.isDarkMode ? darkColorScheme.onError : lightColorScheme.onError;

  Color get textFieldBorderColor => context.isDarkMode
      ? const Color(0xffeaf4f3).withOpacity(.3)
      : const Color(0xFF4b6461).withOpacity(.5);

  Color? get backgroundColor => context.isDarkMode
      ? darkColorScheme.background
      : lightColorScheme.background;
  Color? get surface =>
      context.isDarkMode ? darkColorScheme.surface : lightColorScheme.surface;
  // ============================================================= //

}
