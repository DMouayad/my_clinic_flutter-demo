import 'dart:io';

import 'package:flutter/material.dart';

class ContextInfo {
  final Orientation orientation;
  final DeviceType deviceType;
  final Size deviceScreenSize;
  final Size widgetSize;

  ContextInfo({
    required this.orientation,
    required this.deviceType,
    required this.deviceScreenSize,
    required this.widgetSize,
  });

  double get screenHeight => deviceScreenSize.height;
  double get screenWidth => deviceScreenSize.width;
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
}

enum DeviceType { mobile, tablet, desktop }

// mixin ResponsiveLayoutValues {
//   double getHorizontalMargins(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     if (screenWidth <= 600) {
//       return 16.0;
//     } else if (screenWidth > 600 && screenWidth < 900) {
//       return 32.0;
//     } else if (screenWidth > 900 && screenWidth < 1200) {
//       return 42.0;
//     } else if (screenWidth >= 1200) {
//       return screenWidth * 0.05;
//     }
//     return 12.0;
//   }
// }
