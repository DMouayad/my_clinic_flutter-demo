import 'package:clinic_v2/app/base/responsive/responsive.dart';

class PageScreensBuilder extends ResponsiveStatelessWidget {
  const PageScreensBuilder({
    this.desktopScreen,
    this.tabletScreen,
    this.mobileScreen,
    this.defaultScreen,
    this.wideScreen,
    Key? key,
  }) : super(key: key);

  final Widget? mobileScreen;
  final Widget? tabletScreen;
  final Widget? desktopScreen;
  final Widget? defaultScreen;

  /// if set this will be used for both tablet and desktop screens
  final Widget? wideScreen;

  @override
  Widget? defaultBuilder(BuildContext context, contextInfo) {
    if (defaultScreen != null) {
      return defaultScreen!;
    }
    return null;
  }

  @override
  Widget? mobileScreenBuilder(BuildContext context, ContextInfo contextInfo) {
    if (mobileScreen != null) {
      return mobileScreen!;
    }
    return null;
  }

  @override
  Widget? tabletScreenBuilder(BuildContext context, ContextInfo contextInfo) {
    if (tabletScreen != null) {
      return tabletScreen!;
    } else if (wideScreen != null) {
      return wideScreen!;
    }
    return null;
  }

  @override
  Widget? computerScreenBuilder(BuildContext context, ContextInfo contextInfo) {
    if (desktopScreen != null) {
      return desktopScreen!;
    } else if (wideScreen != null) {
      return wideScreen!;
    }
    return null;
  }
}
