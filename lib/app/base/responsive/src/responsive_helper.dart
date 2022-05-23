import 'package:clinic_v2/app/base/responsive/src/context_info.dart';
import 'package:clinic_v2/app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

// import 'context';
mixin ResponsiveBuilder {
  Widget? builder(BuildContext context, ContextInfo contextInfo) => null;

  Widget? desktopBuilder(BuildContext context, ContextInfo contextInfo) => null;
  Widget? windowsDesktopBuilder(
          BuildContext context, ContextInfo contextInfo) =>
      null;
  Widget? macDesktopBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;

  Widget? mobileBuilder(BuildContext context, ContextInfo contextInfo) => null;
  Widget? iosMobileBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;
  Widget? androidMobileBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;

  Widget? tabletBuilder(BuildContext context, ContextInfo contextInfo) => null;
  Widget? iosTabletBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;
  Widget? androidTabletBuilder(BuildContext context, ContextInfo contextInfo) =>
      null;

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
                  _getDeviceTextScaleFactor(contextInfo.deviceTypeByScreen)),
          child: _getBuilder(context, contextInfo),
        );
      },
    );
  }

  Widget? _returnBuilderByPlatform(
      BuildContext context, ContextInfo contextInfo) {
    if (context.isIOSPlatform &&
        macDesktopBuilder(context, contextInfo) != null) {
      return macDesktopBuilder(context, contextInfo)!;
    } else if (context.isWindowsPlatform &&
        windowsDesktopBuilder(context, contextInfo) != null) {
      return windowsDesktopBuilder(context, contextInfo)!;
    }
    if (context.isIOSPlatform &&
        iosMobileBuilder(context, contextInfo) != null) {
      return iosMobileBuilder(context, contextInfo)!;
    } else if (context.isAndroidPlatform &&
        androidMobileBuilder(context, contextInfo) != null) {
      return androidMobileBuilder(context, contextInfo)!;
    }
    if (context.isIOSPlatform &&
        iosTabletBuilder(context, contextInfo) != null) {
      return iosTabletBuilder(context, contextInfo)!;
    } else if (context.isAndroidPlatform &&
        androidTabletBuilder(context, contextInfo) != null) {
      return androidTabletBuilder(context, contextInfo)!;
    }
    return null;
  }

  Widget? _returnBuilderByScreenSize(
      BuildContext context, ContextInfo contextInfo) {
    switch (contextInfo.deviceTypeByScreen) {
      case DeviceType.mobile:
        if (mobileBuilder(context, contextInfo) != null) {
          return mobileBuilder(context, contextInfo)!;
        } else if (builder(context, contextInfo) != null) {
          return builder(context, contextInfo)!;
        }
        break;
      case DeviceType.tablet:
        if (tabletBuilder(context, contextInfo) != null) {
          return tabletBuilder(context, contextInfo)!;
        } else if (builder(context, contextInfo) != null) {
          return builder(context, contextInfo)!;
        }
        break;
      case DeviceType.desktop:
        if (desktopBuilder(context, contextInfo) != null) {
          return desktopBuilder(context, contextInfo)!;
        } else if (builder(context, contextInfo) != null) {
          return builder(context, contextInfo)!;
        }
        break;

      default:
        throw UnimplementedError('No screen provided');
    }
    return null;
  }

  Widget _getBuilder(BuildContext context, ContextInfo contextInfo) {
    return _returnBuilderByPlatform(context, contextInfo) ??
        _returnBuilderByScreenSize(context, contextInfo)!;
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
