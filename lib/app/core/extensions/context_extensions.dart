import 'package:clinic_v2/app/themes/app_color_scheme.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DeviceInfoExtension on BuildContext {
  DeviceType get deviceTypeByScreen {
    if (isDesktop) {
      return DeviceType.desktop;
    }

    if (isTablet) {
      return DeviceType.tablet;
    }

    return DeviceType.mobile;
  }
}

extension ResponsiveContextExtension on BuildContext {
  double get horizontalMargins {
    final screenWidth = MediaQuery.of(this).size.width;
    print(screenWidth);
    if (screenWidth <= 600) {
      return 16.0;
    } else if (screenWidth > 600 && screenWidth < 900) {
      return 32.0;
    } else if (screenWidth > 900 && screenWidth < 1200) {
      return 42.0;
    } else if (screenWidth >= 1200) {
      return screenWidth * 0.05;
    }
    return 12.0;
  }
}

extension ContextScreenSizeExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get deviceScreenSize => mediaQuery.size;
  double get screenHeight => deviceScreenSize.height;
  double get screenWidth => deviceScreenSize.width;
  Orientation get orientation => mediaQuery.orientation;
  bool get isPortraitMode => orientation == Orientation.portrait;
  bool get isLandscapeMode => orientation == Orientation.landscape;

  bool get isMobile => screenWidth < 600;

  bool get isLandScapeTablet => isTablet && isLandscapeMode;
  bool get isPortraitTablet => isTablet && isPortraitMode;
  bool get isTablet => (screenWidth >= 600 && screenWidth < 980);

  bool get isDesktop => screenWidth >= 980;
}

extension ContextThemeExtension on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);
  String themeModeName(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return localizations!.lightMode;
      case ThemeMode.dark:
        return localizations!.darkMode;
    }
  }

  /// similar to [MediaQuery.of(context).theme]
  ThemeData get theme => Theme.of(this);
  fluent_ui.ThemeData get fluentTheme => fluent_ui.FluentTheme.of(this);

  /// Check if dark mode theme is enable
  bool get isDarkMode => (theme.brightness == Brightness.dark);
  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  TextTheme get textTheme => Theme.of(this).textTheme;
  fluent_ui.Typography get fluentTextTheme => fluentTheme.typography;
  AppColorScheme get colorScheme => AppColorScheme.of(this);
  ColorScheme get darkColorScheme => AppColorScheme.darkColorScheme;
  bool get isDesktopPlatform {
    return Theme.of(this).platform == TargetPlatform.windows ||
        Theme.of(this).platform == TargetPlatform.macOS ||
        Theme.of(this).platform == TargetPlatform.linux;
  }
}

extension ContextPlatformExtension on BuildContext {
  bool get isIOSPlatform => Theme.of(this).platform == TargetPlatform.iOS;
  bool get isMacOsPlatform => Theme.of(this).platform == TargetPlatform.macOS;
  bool get isWindowsPlatform =>
      Theme.of(this).platform == TargetPlatform.windows;
  bool get isAndroidPlatform =>
      Theme.of(this).platform == TargetPlatform.android;
  bool get isMobilePlatform =>
      Theme.of(this).platform == TargetPlatform.iOS ||
      Theme.of(this).platform == TargetPlatform.android;
  TargetPlatform get platform => Theme.of(this).platform;
}

extension ContextLocaleExtension on BuildContext {
  bool get isArabicLocale => Localizations.localeOf(this).languageCode == 'ar';
  bool get isEnglishLocale => Localizations.localeOf(this).languageCode == 'en';
  bool get isRTL => isArabicLocale;
  bool get isLTR => isEnglishLocale;
  Locale get locale => Localizations.localeOf(this);

  String getLocaleFullName(Locale locale) {
    switch (locale.languageCode) {
      case 'ar':
        return localizations!.arabic;
      case 'en':
        return localizations!.english;
      default:
        throw UnimplementedError();
    }
  }

  AppLocalizations? get localizations => AppLocalizations.of(this);
}

enum DeviceType { mobile, tablet, desktop }
