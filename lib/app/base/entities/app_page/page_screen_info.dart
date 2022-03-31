import 'package:flutter/material.dart';

import 'route_transition_builder.dart';

class PageScreenInfo {
  final Widget? screen;
  final RouteTransitionType transitionType;

  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  )? screenBuilder;

  const PageScreenInfo({
    this.screen,
    this.screenBuilder,
    this.transitionType = RouteTransitionType.platformDefault,
  }) : assert(screen != null || screenBuilder != null);
}
