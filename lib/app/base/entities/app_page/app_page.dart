import 'package:clinic_v2/app/base/responsive/src/context_info.dart';

import 'route_transition_builder.dart';
import 'package:flutter/material.dart';
import 'package:clinic_v2/app/base/entities/app_page/page_screen_info.dart';
export 'package:clinic_v2/app/base/entities/app_page/page_screen_info.dart';
export 'route_transition_builder.dart';

class AppPage extends Page with CustomRouteTransitionBuilder {
  final PageScreenInfo mobileScreenInfo;
  final PageScreenInfo? tabletScreenInfo;
  final PageScreenInfo? desktopScreenInfo;
  final RouteSettings routeSettings;

  Route get route => _buildRoute(
        routeSettings: routeSettings,
        mobileScreenInfo: mobileScreenInfo,
        desktopScreenInfo: desktopScreenInfo,
      );

  AppPage({
    required this.routeSettings,
    required this.mobileScreenInfo,
    this.desktopScreenInfo,
    this.tabletScreenInfo,
  });
  @override
  Route createRoute(BuildContext context) {
    return route;
  }

  Route _buildRoute({
    PageScreenInfo? tabletScreenInfo,
    PageScreenInfo? desktopScreenInfo,
    required PageScreenInfo mobileScreenInfo,
    required RouteSettings routeSettings,
  }) {
    return PageRouteBuilder(
      settings: routeSettings,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        print('route builder');
        final ContextInfo contextInfo = ContextInfo(context);

        if (contextInfo.isTablet && tabletScreenInfo != null) {
          return _buildPageRoute(
            tabletScreenInfo,
            context,
            animation,
            secondaryAnimation,
          );
        }
        if (contextInfo.isDesktop && desktopScreenInfo != null) {
          return _buildPageRoute(
            desktopScreenInfo,
            context,
            animation,
            secondaryAnimation,
          );
        }
        return _buildPageRoute(
          mobileScreenInfo,
          context,
          animation,
          secondaryAnimation,
        );
      },
    );
  }

  Widget _buildPageRoute(
    PageScreenInfo screenInfo,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return buildRouteByTransitionType(
      page: screenInfo.screen ??
          screenInfo.screenBuilder!(context, animation, secondaryAnimation),
      transitionType: screenInfo.transitionType,
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      context: context,
    );
  }
}
