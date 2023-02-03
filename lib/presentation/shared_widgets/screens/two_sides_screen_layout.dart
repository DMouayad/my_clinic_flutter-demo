import 'package:clinic_v2/presentation/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/custom_back_button.dart';
import 'package:flutter/material.dart';

//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:clinic_v2/presentation/shared_widgets/color_barrier.dart';

import '../loading_indicator.dart';

class TwoSidesScreenLayout extends StatelessWidget {
  factory TwoSidesScreenLayout.withAppLogo({
    required Widget rightSide,
    required bool rightSideBlurred,
    Animation<double>? rightSideAnimation,
    Widget? optionsBar,
    Widget? leftSideContent,
    bool rightSideScrollable = false,
    bool autoShowBackButton = true,
  }) {
    return TwoSidesScreenLayout(
      rightSideAnimation: rightSideAnimation,
      rightSideBlurred: rightSideBlurred,
      rightSide: rightSide,
      rightSideScrollable: rightSideScrollable,
      autoShowBackButton: autoShowBackButton,
      leftSide: _LeftSideWithAppLogo(
        showInProgressIndicator: rightSideBlurred,
        leftSideChild: leftSideContent,
        optionsBar: optionsBar,
      ),
    );
  }

  const TwoSidesScreenLayout({
    required this.rightSide,
    required this.leftSide,
    this.leftSideBlurred = false,
    this.rightSideBlurred = false,
    this.rightSideScrollable = false,
    this.autoShowBackButton = true,
    this.rightSideAnimation,
    this.leftSideAnimation,
    this.backgroundColor,
    this.leftSideFlex = 1,
    this.rightSideFlex = 1,
    Key? key,
  }) : super(key: key);

  final Widget rightSide;
  final Widget leftSide;
  final bool leftSideBlurred;
  final bool rightSideBlurred;
  final Animation<double>? rightSideAnimation;
  final Animation<double>? leftSideAnimation;
  final int leftSideFlex;
  final int rightSideFlex;
  final Color? backgroundColor;
  final bool rightSideScrollable;
  final bool autoShowBackButton;

  @override
  Widget build(context) {
    if (context.isPortraitTablet) {
      return _buildScrollableVerticalSides(context);
    }
    if (context.isDesktop || context.isLandScapeTablet) {
      return Material(
        color: context.colorScheme.backgroundColor,
        child: Flex(
          direction: context.isPortraitTablet ? Axis.vertical : Axis.horizontal,
          children: [
            Expanded(
              flex: leftSideFlex,
              child: leftSideAnimation != null
                  ? _buildSideWithTransition(
                      animation: leftSideAnimation!,
                      widget: leftSide,
                      sideIsBlurred: leftSideBlurred,
                    )
                  : _buildSide(
                      sideContent: leftSide,
                      sideIsBlurred: leftSideBlurred,
                    ),
            ),
            Expanded(
              flex: context.screenWidth > 1200 ? 1 : 2,
              child: SafeArea(
                child: rightSideAnimation != null
                    ? _buildSideWithTransition(
                        animation: rightSideAnimation!,
                        widget: _getRightSide(rightSide, context),
                        sideIsBlurred: rightSideBlurred,
                      )
                    : _buildSide(
                        sideContent: _getRightSide(rightSide, context),
                        sideIsBlurred: rightSideBlurred,
                      ),
              ),
            ),
          ],
        ),
      );
    }
    throw UnimplementedError();
  }

  Widget _buildScrollableVerticalSides(BuildContext context) {
    return Material(
      color: context.colorScheme.backgroundColor,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              backgroundColor: context.colorScheme.backgroundColor,
              expandedHeight: context.screenHeight * .2,
              centerTitle: true,
              elevation: 0,
              title: AppNameText(
                fontSize: 42,
                fontColor: context.colorScheme.primary,
              ),
            ),
            SliverFillRemaining(
              fillOverscroll: true,
              child: rightSide,
              // hasScrollBody: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getRightSide(Widget rightSide, BuildContext context) {
    if (autoShowBackButton && rightSideScrollable) {
      return CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            backgroundColor: context.colorScheme.backgroundColor,
            // expandedHeight: context.screenHeight * .2,
            leading: const CustomBackButton(),
            title: const SizedBox.shrink(),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            child: rightSide,
          ),
        ],
      );
    } else if (autoShowBackButton && !rightSideScrollable) {
      return Scaffold(
        backgroundColor: context.colorScheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.colorScheme.backgroundColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading:
              Navigator.of(context).canPop() ? const CustomBackButton() : null,
          title: const SizedBox.shrink(),
        ),
        body: rightSide,
      );
    }
    return rightSide;
  }

  Widget _buildSide({
    required Widget sideContent,
    bool sideIsBlurred = false,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        sideContent,
        if (sideIsBlurred) const BlurredColorBarrier(),
      ],
    );
  }

  Widget _buildSideWithTransition({
    required Animation<double> animation,
    required Widget widget,
    bool sideIsBlurred = false,
  }) {
    return SlideTransition(
      position: animation.drive(
        Tween(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        ).chain(CurveTween(curve: Curves.easeInOut)),
      ),
      child: FadeTransition(
        opacity: animation,
        child: _buildSide(
          sideContent: widget,
          sideIsBlurred: sideIsBlurred,
        ),
      ),
    );
  }
}

class _LeftSideWithAppLogo extends StatelessWidget {
  final bool showInProgressIndicator;
  final Widget? leftSideChild;

  final Widget? optionsBar;

  const _LeftSideWithAppLogo({
    this.showInProgressIndicator = false,
    this.leftSideChild,
    this.optionsBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'appName',
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              constraints: const BoxConstraints.expand(),
              color: context.colorScheme.primaryContainer,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(),
                  AppNameText(
                    fontSize: context.isDesktop ? 50 : 36,
                    fontColor: context.colorScheme.primary,
                  ),
                  if (leftSideChild != null) ...[
                    const Spacer(),
                    leftSideChild!
                  ],
                  if (showInProgressIndicator) ...[
                    const Spacer(),
                    const LoadingIndicator(),
                  ],
                  const Spacer(),
                ],
              ),
            ),
          ),
          if (optionsBar != null)
            Align(
              alignment: context.isArabicLocale
                  ? Alignment.topRight
                  : Alignment.bottomLeft,
              child: optionsBar,
            ),
        ],
      ),
    );
  }
}
