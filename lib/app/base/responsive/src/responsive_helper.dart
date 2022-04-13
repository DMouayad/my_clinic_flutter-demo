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
        return MediaQuery(
          data: contextInfo.mediaQuery.copyWith(
              textScaleFactor:
                  _getDeviceTextScaleFactor(contextInfo.deviceType)),
          child: _getBuilder(context, contextInfo),
        );
      },
    );
  }

  Widget _getBuilder(BuildContext context, ContextInfo contextInfo) {
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
  }

  double _getDeviceTextScaleFactor(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.desktop:
        return 1.1;
      case DeviceType.tablet:
        return 1.1;
      case DeviceType.mobile:
        return 1.0;
    }
  }
}
