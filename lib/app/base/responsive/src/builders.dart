import 'package:flutter/material.dart';

import 'context_info.dart';

abstract class CustomBuilders {
  Widget? defaultBuilder(BuildContext context, ContextInfo contextInfo) => null;

  Widget? windowsBuilder(BuildContext context, ContextInfo contextInfo) => null;
  Widget? macBuilder(BuildContext context, ContextInfo contextInfo) => null;

  Widget? iosMobileBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;
  Widget? androidMobileBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;

  Widget? iosTabletBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;
  Widget? androidTabletBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;

  Widget? tabletScreenBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;
  Widget? mobileScreenBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;
  Widget? computerScreenBuilder(
          BuildContext context, ContextInfo contextInfo) =>
      null;
}
