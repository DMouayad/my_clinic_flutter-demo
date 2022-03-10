import 'package:flutter/material.dart';

mixin ResponsiveMixin {
  Widget? builder(BuildContext context) => null;

  Widget? desktop(BuildContext context) => null;

  Widget? mobile(BuildContext context) => null;

  Widget? tablet(BuildContext context) => null;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  Widget buildWidget(BuildContext context) {
    assert(
      builder(context) != null ||
          mobile(context) != null ||
          tablet(context) != null ||
          desktop(context) != null,
    );

    if (isMobile(context) && mobile(context) != null) {
      return mobile(context)!;
    } else if (isTablet(context) && tablet(context) != null) {
      return tablet(context)!;
    } else if (isDesktop(context) && desktop(context) != null) {
      return desktop(context)!;
    } else {
      return mobile(context) ??
          tablet(context) ??
          desktop(context) ??
          builder(context)!;
    }
  }
}
