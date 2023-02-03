import 'package:flutter/material.dart';

//
import 'package:clinic_v2/presentation/navigation/src/route_transition/custom_transitions_helper.dart';
import 'package:clinic_v2/presentation/navigation/src/route_transition/transition_type.dart';
import 'package:clinic_v2/utils/helpers/builders/context_builder.dart';

class AppPage extends Page with CustomRouteTransitionsHelper {
  final RouteSettings routeSettings;
  final ContextBuilder<RouteTransitionType> pageTransitionBuilder;
  final ContextBuilder<Widget> Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) pageScreenBuilder;

  final Duration transitionDuration;

  final Duration reverseTransitionDuration;

  Route get route => _route;
  static const _defaultPageTransitionBuilder =
      ContextBuilder(defaultChild: RouteTransitionType.platformDefault);

  AppPage({
    required this.routeSettings,
    required this.pageScreenBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.pageTransitionBuilder = _defaultPageTransitionBuilder,
  }) {
    _route = PageRouteBuilder(
      settings: routeSettings,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget screen,
      ) {
        return buildTransition(
          context,
          screen,
          animation,
          secondaryAnimation,
          transitionType: pageTransitionBuilder
              .copyWith(defaultChild: RouteTransitionType.platformDefault)
              .getCurrentContextChild(context),
        );
      },
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return pageScreenBuilder(context, animation, secondaryAnimation)
            .getCurrentContextChild(context);
      },
    );
  }

  late final Route _route;

  @override
  Route createRoute(BuildContext context) {
    return _route;
  }
}
