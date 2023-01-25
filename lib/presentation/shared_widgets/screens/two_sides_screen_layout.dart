import 'package:flutter/material.dart';

//
import 'package:clinic_v2/utils/extensions/context_extensions.dart';
import 'package:clinic_v2/presentation/shared_widgets/color_barrier.dart';

class TwoSidesScreenLayout extends StatelessWidget {
  const TwoSidesScreenLayout({
    required this.rightSide,
    required this.leftSide,
    this.leftSideBlurred = false,
    this.rightSideBlurred = false,
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

  @override
  Widget build(context) {
    return Material(
      color: backgroundColor ?? context.colorScheme.backgroundColor,
      child: Flex(
        direction: Axis.horizontal,
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
            flex: rightSideFlex,
            child: rightSideAnimation != null
                ? _buildSideWithTransition(
                    animation: rightSideAnimation!,
                    widget: rightSide,
                    sideIsBlurred: rightSideBlurred,
                  )
                : _buildSide(
                    sideContent: rightSide,
                    sideIsBlurred: rightSideBlurred,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSide({required Widget sideContent, bool sideIsBlurred = false}) {
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
        ).chain(CurveTween(curve: Curves.easeInCubic)),
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
