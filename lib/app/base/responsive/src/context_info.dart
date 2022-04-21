import 'package:clinic_v2/app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ContextInfo {
  final BuildContext context;
  final Size? widgetSize;

  ContextInfo(
    this.context, {
    this.widgetSize,
  });

  MediaQueryData get mediaQuery => MediaQuery.of(context);
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

  bool get isAndroidPlatform => context.isAndroidPlatform;
  bool get isIosPlatform => context.isIOSPlatform;
  bool get isMobilePlatform => context.isMobilePlatform;

  bool get isDesktopPlatform => context.isDesktopPlatform;

  @override
  String toString() {
    return 'ContextInfo(orientation: $orientation, deviceTypeByScreen: $deviceTypeByScreen,'
        ' deviceScreenSize: $deviceScreenSize, widgetSize: $widgetSize)';
  }

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

enum DeviceType { mobile, tablet, desktop }
