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
}
