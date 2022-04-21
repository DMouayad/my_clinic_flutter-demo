import 'package:flutter/material.dart';
//
import 'package:clinic_v2/app/base/entities/app_page/page_screens_info.dart';
import 'package:clinic_v2/app/base/responsive/src/context_info.dart';
import 'route_transition_builder.dart';
//
export 'route_transition_builder.dart';
export 'page_screens_builder.dart';
export 'page_screens_info.dart';

class AppPage extends Page with CustomRouteTransitionBuilder {
  final PageScreensInfo pageScreensInfo;
  final RouteSettings routeSettings;

  Route get route => _buildRoute();

  AppPage({
    required this.routeSettings,
    required this.pageScreensInfo,
  });

  @override
  Route createRoute(BuildContext context) {
    return route;
  }

  Route _buildRoute() {
    return PageRouteBuilder(
      settings: routeSettings,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return buildRouteByTransitionType(
          page: pageScreensInfo.screensBuilder(
            context,
            animation,
            secondaryAnimation,
          ),
          transitionType: _getPageRouteTransition(context),
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          context: context,
        );
      },
    );
  }

  RouteTransitionType _getPageRouteTransition(BuildContext context) {
    ContextInfo contextInfo = ContextInfo(context);
    if (contextInfo.isDesktop && contextInfo.isDesktopPlatform) {
      return pageScreensInfo.desktopScreenTransitionType;
    } else if (contextInfo.isTablet) {
      return pageScreensInfo.tabletScreenTransitionType;
    } else if (contextInfo.isMobile) {
      return pageScreensInfo.tabletScreenTransitionType;
    } else {
      return RouteTransitionType.platformDefault;
    }
  }
}
