import 'package:flutter/material.dart';

export 'custom_builders_helper.dart';

abstract class CustomBuilders<T extends Object> {
  T? defaultBuilder(BuildContext context) => null;

  T? windowsBuilder(BuildContext context) => null;
  T? macBuilder(BuildContext context) => null;

  T? iosMobileBuilder(BuildContext context) => null;
  T? androidMobileBuilder(BuildContext context) => null;

  T? iosTabletBuilder(BuildContext context) => null;
  T? androidTabletBuilder(BuildContext context) => null;

  T? tabletScreenBuilder(BuildContext context) => null;
  T? mobileScreenBuilder(BuildContext context) => null;

  /// tablet screen or desktop screen
  T? wideScreenBuilder(BuildContext context) => null;
  T? desktopScreenBuilder(BuildContext context) => null;
}
