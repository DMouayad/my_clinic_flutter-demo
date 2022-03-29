import 'dart:io';

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

  /// True if the shortestSide is smaller than 600p
  bool get isMobile =>
      (screenWidth < 600) && (Platform.isAndroid || Platform.isIOS);

  /// True if the shortestSide is largest than 600p
  bool get isTablet =>
      (screenWidth >= 600) && (Platform.isAndroid || Platform.isIOS);

  //TODO: REPLACE ABOVE IMP WITH THE COMMENTED ONE
  bool get isDesktop => screenWidth >= 980;

  bool get isDesktopPlatform =>
      Platform.isLinux || Platform.isMacOS || Platform.isWindows;

  @override
  String toString() {
    return 'ContextInfo(orientation: $orientation, deviceType: $deviceType,'
        ' deviceScreenSize: $deviceScreenSize, widgetSize: $widgetSize)';
  }

  DeviceType get deviceType {
    // var orientation = mediaQuery.orientation;

    double deviceWidth = mediaQuery.size.width;

    // if (orientation == Orientation.landscape) {
    //   deviceWidth = mediaQuery.size.height;
    // } else {
    //   deviceWidth = mediaQuery.size.width;
    // }

    if (deviceWidth > 980) {
      return DeviceType.desktop;
    }

    if (deviceWidth > 600) {
      return DeviceType.tablet;
    }

    return DeviceType.mobile;
  }
}

enum DeviceType { mobile, tablet, desktop }
