import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';

class PageScreensBuilder extends CustomStatelessWidget {
  const PageScreensBuilder({
    this.mobileScreen,
    this.tabletScreen,
    this.androidMobileScreen,
    this.androidTabletScreen,
    this.iosTabletScreen,
    this.iosMobileScreen,
    this.windowsScreen,
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
  final Widget? windowsScreen;
  final Widget? macOSScreen;
  final Widget? linuxScreen;

  /// if set this will be used for both tablet and desktop screens
  final Widget? defaultWideScreen;
  final Widget? defaultScreen;

  @override
  Widget? defaultBuilder(BuildContext context, contextInfo) {
    return defaultScreen;
  }

  @override
  Widget? mobileScreenBuilder(BuildContext context, ContextInfo contextInfo) {
    return mobileScreen;
  }

  @override
  Widget? tabletScreenBuilder(BuildContext context, ContextInfo contextInfo) {
    return tabletScreen ?? defaultWideScreen;
  }

  @override
  Widget? wideScreenBuilder(BuildContext context, ContextInfo contextInfo) {
    return defaultWideScreen;
  }

  @override
  Widget? androidMobileBuilder(BuildContext context, ContextInfo contextInfo) {
    return androidMobileScreen;
  }

  @override
  Widget? androidTabletBuilder(BuildContext context, ContextInfo contextInfo) {
    return androidTabletScreen;
  }

  @override
  Widget? iosMobileBuilder(BuildContext context, ContextInfo contextInfo) {
    return iosMobileScreen;
  }

  @override
  Widget? iosTabletBuilder(BuildContext context, ContextInfo contextInfo) {
    return iosTabletScreen;
  }

  @override
  Widget? windowsBuilder(BuildContext context, ContextInfo contextInfo) {
    return windowsScreen;
  }

  @override
  Widget? macBuilder(BuildContext context, ContextInfo contextInfo) {
    return macOSScreen;
  }
}
