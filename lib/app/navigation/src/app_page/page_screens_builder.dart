import 'package:flutter/material.dart';
//
import 'package:clinic_v2/app/core/helpers/builders/custom_builders.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';

class PageScreensBuilder extends StatelessWidget
    with CustomBuilders<Widget>, CustomBuildersHelper<Widget> {
  const PageScreensBuilder({
    this.mobileScreen,
    this.tabletScreen,
    this.androidMobileScreen,
    this.androidTabletScreen,
    this.iosTabletScreen,
    this.iosMobileScreen,
    this.windowsLargeScreen,
    this.windowsMediumScreen,
    this.windowsSmallScreen,
    this.macOSScreen,
    this.linuxScreen,
    this.defaultWideScreen,
    this.defaultScreen,
    Key? key,
  }) : super(key: key);

  final Widget? mobileScreen;
  final Widget? androidMobileScreen;
  final Widget? androidTabletScreen;
  final Widget? tabletScreen;
  final Widget? iosTabletScreen;
  final Widget? iosMobileScreen;
  final Widget? windowsLargeScreen;
  final Widget? windowsSmallScreen;
  final Widget? windowsMediumScreen;
  final Widget? macOSScreen;
  final Widget? linuxScreen;

  /// if set this will be used for both tablet and desktop screens
  final Widget? defaultWideScreen;
  final Widget? defaultScreen;

  @override
  Widget? defaultBuilder(BuildContext context) {
    return defaultScreen;
  }

  @override
  Widget? mobileScreenBuilder(BuildContext context) {
    return mobileScreen;
  }

  @override
  Widget? tabletScreenBuilder(BuildContext context) {
    return tabletScreen ?? defaultWideScreen;
  }

  @override
  Widget? wideScreenBuilder(BuildContext context) {
    return defaultWideScreen;
  }

  @override
  Widget? androidMobileBuilder(BuildContext context) {
    return androidMobileScreen;
  }

  @override
  Widget? androidTabletBuilder(BuildContext context) {
    return androidTabletScreen;
  }

  @override
  Widget? iosMobileBuilder(BuildContext context) {
    return iosMobileScreen;
  }

  @override
  Widget? iosTabletBuilder(BuildContext context) {
    return iosTabletScreen;
  }

  @override
  Widget? windowsBuilder(BuildContext context) {
    if (context.isMobile) {
      return windowsSmallScreen;
    }
    if (context.isTablet) {
      return windowsMediumScreen;
    }
    if (context.isDesktop) {
      return windowsLargeScreen;
    }
    return null;
  }

  @override
  Widget? macBuilder(BuildContext context) {
    return macOSScreen;
  }

  @override
  Widget build(BuildContext context) {
    return getCurrentContextBuilder(context);
  }
}
