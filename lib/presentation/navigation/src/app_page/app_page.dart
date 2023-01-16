import 'package:flutter/material.dart';
//
import '../route_transition/route_transition_builder.dart';
import 'page_screens_builder.dart';

class AppPage extends Page {
  final RouteSettings routeSettings;
  final RouteTransitionBuilder pageTransitions;
  final PageScreensBuilder Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) pageScreensBuilder;

  Route get route => _route;

  AppPage({
    required this.routeSettings,
    required this.pageScreensBuilder,
    this.pageTransitions = const RouteTransitionBuilder(),
  }) {
    _route = PageRouteBuilder(
      settings: routeSettings,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return pageTransitions.buildRouteWithTransition(
          context,
          pageScreensBuilder(context, animation, secondaryAnimation),
          animation,
          secondaryAnimation,
        );
      },
    );
  }

  late final Route _route;
  @override
  Route createRoute(BuildContext context) {
    return _route;
  }
}
