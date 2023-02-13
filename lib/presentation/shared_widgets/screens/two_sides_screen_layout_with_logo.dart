part of 'two_sides_screen_layout.dart';

class TwoSidesScreenLayoutWithAppLogo extends TwoSidesScreenLayout {
  TwoSidesScreenLayoutWithAppLogo({
    required super.rightSide,
    required super.rightSideBlurred,
    super.leftSideFlex = 1,
    super.rightSideScrollable,
    super.autoShowBackButton,
    super.rightSideAnimation,
    Widget? optionsBar,
    Widget? leftSideContent,
    super.key,
  }) : super(
          portraitTabletLayoutFooter: optionsBar,
          leftSide: _LeftSideWithAppLogo(
            showInProgressIndicator: rightSideBlurred,
            leftSideChild: leftSideContent,
            optionsBar: optionsBar,
          ),
        );
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
