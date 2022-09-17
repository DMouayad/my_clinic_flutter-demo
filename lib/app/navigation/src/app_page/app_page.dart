import 'package:flutter/material.dart';
//
import 'package:clinic_v2/app/navigation/src/route_transition/route_transition_builder.dart';
//
import 'page_screens_builder.dart';

class AppPage extends Page {
  final RouteSettings routeSettings;
  final RouteTransitionBuilder pageTransitions;
  final PageScreensBuilder Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) pageScreensBuilder;

  Route get route => _buildRoute();

  const AppPage({
    required this.routeSettings,
    required this.pageScreensBuilder,
    this.pageTransitions = const RouteTransitionBuilder(),
  });

  @override
  Route createRoute(BuildContext context) {
    return route;
  }

  Route _buildRoute() {
    return PageRouteBuilder(
      settings: routeSettings,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        print(pageScreensBuilder);
        return pageTransitions.buildRouteWithTransition(
          context,
          pageScreensBuilder(context, animation, secondaryAnimation),
          animation,
          secondaryAnimation,
        );
      },
    );
  }
}
