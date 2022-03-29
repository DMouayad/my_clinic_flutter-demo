import 'package:clinic_v2/app/base/responsive/src/context_info.dart';
import 'package:flutter/material.dart';

mixin ResponsiveBuilder {
  Widget? builder(BuildContext context, ContextInfo contextInfo) => null;

  Widget? desktopBuilder(BuildContext context, ContextInfo contextInfo) => null;

  Widget? mobileBuilder(BuildContext context, ContextInfo contextInfo) => null;

  Widget? tabletBuilder(BuildContext context, ContextInfo contextInfo) => null;

  Widget buildWidget(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // ------------------------------------ //
        var contextInfo = ContextInfo(
          context,
          widgetSize: Size(constraints.maxWidth, constraints.maxHeight),
        );
        switch (contextInfo.deviceType) {
          case DeviceType.mobile:
            if (mobileBuilder(context, contextInfo) != null) {
              return mobileBuilder(context, contextInfo)!;
            }
            break;
          case DeviceType.tablet:
            if (tabletBuilder(context, contextInfo) != null) {
              return tabletBuilder(context, contextInfo)!;
            }
            break;
          case DeviceType.desktop:
            if (desktopBuilder(context, contextInfo) != null) {
              return desktopBuilder(context, contextInfo)!;
            }
            break;

          default:
            break;
        }
        return mobileBuilder(context, contextInfo) ??
            tabletBuilder(context, contextInfo) ??
            desktopBuilder(context, contextInfo) ??
            builder(context, contextInfo)!;
      },
    );
  }
}
