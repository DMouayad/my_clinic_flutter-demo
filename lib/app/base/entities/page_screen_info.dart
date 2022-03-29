import 'package:flutter/material.dart';

class PageScreenInfo {
  final Widget? screen;
  final bool hasTransition;
  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  )? screenBuilder;

  const PageScreenInfo({
    this.screen,
    this.hasTransition = true,
    this.screenBuilder,
  }) : assert(screen != null || screenBuilder != null);
}
