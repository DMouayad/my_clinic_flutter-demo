import 'package:clinic_v2/app/base/responsive/responsive.dart';

class PageScreensBuilder extends Component {
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
  final Widget? wideScreen;

  @override
  Widget? builder(BuildContext context, contextInfo) {
    if (defaultScreen != null) {
      return defaultScreen!;
    }
    return null;
  }

  @override
  Widget? mobileBuilder(BuildContext context, ContextInfo contextInfo) {
    if (mobileScreen != null) {
      return mobileScreen!;
    }
    return null;
  }

  @override
  Widget? tabletBuilder(BuildContext context, ContextInfo contextInfo) {
    if (tabletScreen != null) {
      return tabletScreen!;
    } else if (wideScreen != null) {
      return wideScreen!;
    }
    return null;
  }

  @override
  Widget? desktopBuilder(BuildContext context, ContextInfo contextInfo) {
    if (desktopScreen != null) {
      return desktopScreen!;
    } else if (wideScreen != null) {
      return wideScreen!;
    }
    return null;
  }
}
