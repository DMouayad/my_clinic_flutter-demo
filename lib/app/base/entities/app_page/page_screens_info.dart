import 'package:flutter/material.dart';

import 'page_screens_builder.dart';
import 'route_transition_builder.dart';

class PageScreensInfo {
  final RouteTransitionType mobileScreenTransitionType;
  final RouteTransitionType tabletScreenTransitionType;
  final RouteTransitionType desktopScreenTransitionType;

  final PageScreensBuilder Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) screensBuilder;

  const PageScreensInfo({
    required this.screensBuilder,
    this.mobileScreenTransitionType = RouteTransitionType.platformDefault,
    this.desktopScreenTransitionType = RouteTransitionType.platformDefault,
    this.tabletScreenTransitionType = RouteTransitionType.platformDefault,
  });

  @override
  String toString() {
    return ' PageScreensBuilderInfo(mobileScreenTransitionType: $mobileScreenTransitionType,'
        ' tabletScreenTransitionType: $tabletScreenTransitionType, desktopScreenTransitionType:'
        ' $desktopScreenTransitionType, screensBuilder: $screensBuilder)';
  }
}
