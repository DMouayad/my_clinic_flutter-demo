import 'package:animate_do/animate_do.dart';
import 'package:clinic_v2/app/base/responsive/responsive.dart';

class TwoSidesScreenLayout extends StatelessWidget {
  const TwoSidesScreenLayout({
    required this.leftSide,
    required this.rightSide,
    this.leftSideBlurred = false,
    this.rightSideBlurred = false,
    this.rightSideAnimation,
    this.leftSideAnimation,
    this.backgroundColor,
    this.leftSideFlex = 1,
    this.rightSideFlex = 1,
    Key? key,
  }) : super(key: key);

  final Widget leftSide;
  final Widget rightSide;
  final bool leftSideBlurred;
  final bool rightSideBlurred;
  final Animation<double>? leftSideAnimation;
  final Animation<double>? rightSideAnimation;
  final int leftSideFlex;
  final int rightSideFlex;
  final Color? backgroundColor;
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Row(
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
                    widget: leftSide,
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
                    widget: rightSide,
                    sideIsBlurred: rightSideBlurred,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSide({required Widget widget, bool sideIsBlurred = false}) {
    return Stack(
      children: [
        widget,
        if (sideIsBlurred)
          FadeIn(
            duration: const Duration(milliseconds: 400),
            child: Container(
              color: const Color(0xFF354c49).withOpacity(.3),
              child: GestureDetector(),
            ),
          ),
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
          widget: widget,
          sideIsBlurred: sideIsBlurred,
        ),
      ),
    );
  }
}
