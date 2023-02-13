import 'package:flutter/material.dart';

//
import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/custom_back_button.dart';
import 'package:clinic_v2/presentation/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:clinic_v2/presentation/shared_widgets/color_barrier.dart';

import '../loading_indicator.dart';

part 'two_sides_screen_layout_with_logo.dart';

class TwoSidesScreenLayout extends StatelessWidget {
  factory TwoSidesScreenLayout.withAppLogo({
    required Widget rightSide,
    required bool rightSideBlurred,
    Animation<double>? rightSideAnimation,
    Widget? optionsBar,
    Widget? leftSideContent,
    int leftSideFlex,
    bool rightSideScrollable,
    bool autoShowBackButton,
  }) = TwoSidesScreenLayoutWithAppLogo;

  const TwoSidesScreenLayout({
    required this.rightSide,
    required this.leftSide,
    this.leftSideBlurred = false,
    this.rightSideBlurred = false,
    this.rightSideScrollable = false,
    this.autoShowBackButton = true,
    this.hideLeftSideOnPortraitTablet = true,
    this.rightSideAnimation,
    this.leftSideAnimation,
    this.backgroundColor,
    this.leftSideFlex = 1,
    this.rightSideFlex = 1,
    this.portraitTabletLayoutFooter,
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
  final bool hideLeftSideOnPortraitTablet;
  final Widget? portraitTabletLayoutFooter;

  @override
  Widget build(context) {
    return Material(
      color: context.colorScheme.backgroundColor,
      child: Flex(
        direction: context.isPortraitTablet ? Axis.vertical : Axis.horizontal,
        children: [
          if (!(hideLeftSideOnPortraitTablet && context.isPortraitTablet))
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
          if (context.isPortraitTablet && portraitTabletLayoutFooter != null)
            Expanded(
              flex: 0,
              child: portraitTabletLayoutFooter!,
            ),
        ],
      ),
    );
  }

  Widget _getRightSide(Widget rightSide, BuildContext context) {
    if (rightSideScrollable) {
      return CustomScrollView(
        physics:
            rightSideScrollable ? null : const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar.medium(
            backgroundColor: context.colorScheme.backgroundColor,
            surfaceTintColor: context.colorScheme.backgroundColor,
            expandedHeight:
                context.screenHeight * (context.screenHeight > 800 ? .2 : .1),
            automaticallyImplyLeading: false,
            leading: autoShowBackButton ? const CustomBackButton() : null,
            title: context.isPortraitTablet
                ? AppNameText(
                    fontSize: context.isDesktop ? 50 : 36,
                    fontColor: context.colorScheme.primary,
                  )
                : const SizedBox.shrink(),
          ),
          SliverFillRemaining(
            child: rightSide,
          ),
        ],
      );
    } else {
      return Scaffold(
        backgroundColor: context.colorScheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.colorScheme.backgroundColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: (Navigator.of(context).canPop() && autoShowBackButton)
              ? const CustomBackButton()
              : null,
          title: context.isPortraitTablet
              ? AppNameText(
                  fontSize: context.isDesktop ? 50 : 36,
                  fontColor: context.colorScheme.primary,
                )
              : const SizedBox.shrink(),
        ),
        body: rightSide,
      );
    }
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
