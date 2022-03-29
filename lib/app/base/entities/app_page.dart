import 'package:clinic_v2/app/base/entities/page_screen_info.dart';
export 'package:clinic_v2/app/base/entities/page_screen_info.dart';

import '../responsive/responsive.dart';

class AppPage extends Page with RouteBuilder {
  final PageScreenInfo mobileScreenInfo;
  final PageScreenInfo? tabletScreenInfo;
  final PageScreenInfo desktopScreenInfo;
  final RouteSettings routeSettings;

  Route get route => buildRoute(
        routeSettings: routeSettings,
        mobileScreenInfo: mobileScreenInfo,
        desktopScreenInfo: desktopScreenInfo,
      );

  AppPage({
    required this.routeSettings,
    required this.mobileScreenInfo,
    required this.desktopScreenInfo,
    this.tabletScreenInfo,
  });
  @override
  Route createRoute(BuildContext context) {
    return route;
  }
}

mixin RouteBuilder {
  Route buildRoute({
    PageScreenInfo? tabletScreenInfo,
    required PageScreenInfo mobileScreenInfo,
    required PageScreenInfo desktopScreenInfo,
    required RouteSettings routeSettings,
  }) {
    return PageRouteBuilder(
      settings: routeSettings,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        final ContextInfo contextInfo = ContextInfo(context);

        if (contextInfo.isTablet && tabletScreenInfo != null) {
          return tabletScreenInfo.screen ??
              tabletScreenInfo.screenBuilder!(
                context,
                animation,
                secondaryAnimation,
              );
        }
        if (contextInfo.isDesktop) {
          return desktopScreenInfo.screen ??
              desktopScreenInfo.screenBuilder!(
                context,
                animation,
                secondaryAnimation,
              );
        }
        return mobileScreenInfo.screen ??
            mobileScreenInfo.screenBuilder!(
              context,
              animation,
              secondaryAnimation,
            );
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        final ContextInfo contextInfo = ContextInfo(context);

        if (contextInfo.isTablet &&
            (tabletScreenInfo?.hasTransition ?? false)) {
          return RouteTransitionBuilder(child).buildPage(
            context,
            animation,
            secondaryAnimation,
          );
        }
        if (contextInfo.isDesktop && (desktopScreenInfo.hasTransition)) {
          return RouteTransitionBuilder(child).buildPage(
            context,
            animation,
            secondaryAnimation,
          );
        }
        if (contextInfo.isMobile && (mobileScreenInfo.hasTransition)) {
          return RouteTransitionBuilder(child).buildPage(
            context,
            animation,
            secondaryAnimation,
          );
        }
        return child;
      },
    );
  }
}

class RouteTransitionBuilder extends PageRoute<dynamic>
    with MaterialRouteTransitionMixin {
  final Widget routeContent;

  RouteTransitionBuilder(this.routeContent);
  @override
  Widget buildContent(BuildContext context) {
    return routeContent;
  }

  @override
  bool get maintainState => true;
}
