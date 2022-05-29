import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

extension ResponsiveContextExtensions on BuildContext {
  double get horizontalMargins {
    final screenWidth = MediaQuery.of(this).size.width;
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

extension ContextSizeExtensions on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

extension ContextThemeExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// similar to [MediaQuery.of(context).theme]
  ThemeData get theme => Theme.of(this);
  fluent_ui.ThemeData get fluentTheme => fluent_ui.FluentTheme.of(this);

  /// Check if dark mode theme is enable
  bool get isDarkMode => (theme.brightness == Brightness.dark);
  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  TextTheme get textTheme => Theme.of(this).textTheme;
  fluent_ui.Typography get fluentTextTheme => fluentTheme.typography;
  AppColorScheme get colorScheme => AppColorScheme.of(this);
  bool get isDesktopPlatform {
    return Theme.of(this).platform == TargetPlatform.windows ||
        Theme.of(this).platform == TargetPlatform.macOS ||
        Theme.of(this).platform == TargetPlatform.linux;
  }

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
  bool get isArabicLocale => Localizations.localeOf(this).languageCode == 'ar';
  bool get isEnglishLocale => Localizations.localeOf(this).languageCode == 'en';
}
