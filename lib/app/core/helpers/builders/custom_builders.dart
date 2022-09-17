import 'package:flutter/material.dart';

import 'package:clinic_v2/app/core/entities/context_info.dart';

export 'custom_builders_helper.dart';

abstract class CustomBuilders<T extends Object> {
  T? defaultBuilder(BuildContext context, ContextInfo contextInfo) => null;

  T? windowsBuilder(BuildContext context, ContextInfo contextInfo) => null;
  T? macBuilder(BuildContext context, ContextInfo contextInfo) => null;

  T? iosMobileBuilder(BuildContext context, ContextInfo contextInfo) => null;
  T? androidMobileBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;

  T? iosTabletBuilder(BuildContext context, ContextInfo contextInfo) => null;
  T? androidTabletBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;

  T? tabletScreenBuilder(BuildContext context, ContextInfo contextInfo) => null;
  T? mobileScreenBuilder(BuildContext context, ContextInfo contextInfo) => null;

  /// tablet screen or desktop screen
  T? wideScreenBuilder(BuildContext context, ContextInfo contextInfo) => null;
  T? desktopScreenBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;
}
