import 'package:flutter/material.dart';
//
import 'package:clinic_v2/utils/helpers/builders/custom_builders.dart';
import 'custom_transitions_helper.dart';
import 'transition_type.dart';

class RouteTransitionBuilder
    with
        CustomRouteTransitionsHelper,
        CustomBuilders<RouteTransitionType>,
        CustomBuildersHelper<RouteTransitionType> {
  final RouteTransitionType mobile;
  final RouteTransitionType androidMobile;
  final RouteTransitionType androidTablet;
  final RouteTransitionType tablet;
  final RouteTransitionType iosTablet;
  final RouteTransitionType iosMobile;
  final RouteTransitionType windows;
  final RouteTransitionType macOS;
  final RouteTransitionType linux;
  final RouteTransitionType defaultTransition;

  const RouteTransitionBuilder({
    this.mobile = RouteTransitionType.platformDefault,
    this.tablet = RouteTransitionType.platformDefault,
    this.androidMobile = RouteTransitionType.platformDefault,
    this.androidTablet = RouteTransitionType.platformDefault,
    this.iosTablet = RouteTransitionType.platformDefault,
    this.iosMobile = RouteTransitionType.platformDefault,
    this.windows = RouteTransitionType.platformDefault,
    this.macOS = RouteTransitionType.platformDefault,
    this.linux = RouteTransitionType.platformDefault,
    this.defaultTransition = RouteTransitionType.platformDefault,
  });

  @override
  RouteTransitionType? defaultBuilder(BuildContext context) {
    return defaultTransition;
  }

  @override
  RouteTransitionType? mobileScreenBuilder(BuildContext context) {
    return mobile;
  }

  @override
  RouteTransitionType? tabletScreenBuilder(BuildContext context) {
    return tablet;
  }

  @override
  RouteTransitionType? androidMobileBuilder(BuildContext context) {
    return androidMobile;
  }

  @override
  RouteTransitionType? androidTabletBuilder(BuildContext context) {
    return androidTablet;
  }

  @override
  RouteTransitionType? iosMobileBuilder(BuildContext context) {
    return iosMobile;
  }

  @override
  RouteTransitionType? iosTabletBuilder(BuildContext context) {
    return iosTablet;
  }

  @override
  RouteTransitionType? windowsBuilder(BuildContext context) {
    return windows;
  }

  @override
  RouteTransitionType? macBuilder(BuildContext context) {
    return macOS;
  }

  Widget buildRouteWithTransition(
    BuildContext context,
    Widget screen,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return buildTransition(
      context,
      screen,
      animation,
      secondaryAnimation,
      transitionType: getCurrentContextBuilder(context),
    );
  }
}
