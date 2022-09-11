import 'package:animations/animations.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/material.dart';

import 'transition_type.dart';

//
mixin CustomRouteTransitionsHelper {
  static const Curve _kDefaultCurve = Curves.easeOut;
  static const Curve _kDefaultReverseCurve = Curves.easeOut;
  @protected
  Widget buildTransition(
    BuildContext context,
    Widget page,
    Animation<double> animation,
    Animation<double> secondaryAnimation, {
    RouteTransitionType transitionType = RouteTransitionType.platformDefault,
  }) {
    switch (transitionType) {
      case RouteTransitionType.fade:
        return _fade(page, animation);
      case RouteTransitionType.fadeThrough:
        return _fadeThrough(page, animation, secondaryAnimation);
      case RouteTransitionType.fadeScale:
        return _fadeScale(page, animation);
      case RouteTransitionType.platformDefault:
        return _DefaultRouteTransitionBuilder(page)
            .buildPage(context, animation, secondaryAnimation);
      case RouteTransitionType.sharedAxisHorizontal:
        return _sharedAxis(
          page,
          animation,
          secondaryAnimation,
          type: SharedAxisTransitionType.horizontal,
        );
      case RouteTransitionType.sharedAxisScaled:
        return _sharedAxis(
          page,
          animation,
          secondaryAnimation,
          type: SharedAxisTransitionType.scaled,
        );

      case RouteTransitionType.sharedAxisVertical:
        return _sharedAxis(
          page,
          animation,
          secondaryAnimation,
          type: SharedAxisTransitionType.vertical,
        );

      case RouteTransitionType.none:
        return page;
      case RouteTransitionType.slideFromTop:
        return _slide(page, animation, startOffset: const Offset(0, 1));
      case RouteTransitionType.slideFromFromBottom:
        return _slide(page, animation, startOffset: const Offset(0, -1));

      case RouteTransitionType.slideFromLeft:
        return _slide(page, animation, startOffset: const Offset(-1, 0));

      case RouteTransitionType.slideFromRight:
        return _slide(page, animation, startOffset: const Offset(1, 0));
      case RouteTransitionType.desktopDrillIn:
        return fluent_ui.DrillInPageTransition(
          animation: animation,
          child: page,
        );
      case RouteTransitionType.desktopEntrance:
        return fluent_ui.EntrancePageTransition(
          animation: animation,
          child: page,
        );
    }
  }

  Widget _fade(Widget page, Animation<double> animation) {
    return FadeTransition(opacity: animation, child: page);
  }

  Widget _fadeThrough(
    Widget page,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return FadeThroughTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: page,
    );
  }

  Widget _fadeScale(Widget page, Animation<double> animation) {
    return FadeScaleTransition(
      animation: animation,
      child: page,
    );
  }

  Widget _sharedAxis<T>(
    Widget page,
    Animation<double> animation,
    Animation<double> secondaryAnimation, {
    SharedAxisTransitionType type = SharedAxisTransitionType.scaled,
  }) {
    return SharedAxisTransition(
      child: page,
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: type,
    );
  }

  Widget _slide<T>(
    Widget page,
    Animation<double> animation, {
    Offset startOffset = const Offset(1, 0),
    Curve easeFwd = _kDefaultCurve,
    Curve easeReverse = _kDefaultReverseCurve,
  }) {
    bool reverse = animation.status == AnimationStatus.reverse;
    return SlideTransition(
      position:
          Tween<Offset>(begin: startOffset, end: const Offset(0, 0)).animate(
        CurvedAnimation(
          parent: animation,
          curve: reverse ? easeReverse : easeFwd,
        ),
      ),
      child: page,
    );
  }
}

class _DefaultRouteTransitionBuilder extends PageRoute<dynamic>
    with MaterialRouteTransitionMixin {
  final Widget routeContent;

  _DefaultRouteTransitionBuilder(this.routeContent);
  @override
  Widget buildContent(BuildContext context) {
    return routeContent;
  }

  @override
  bool get maintainState => true;
}
