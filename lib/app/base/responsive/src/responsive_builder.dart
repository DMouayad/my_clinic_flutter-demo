import 'package:clinic_v2/app/base/responsive/src/builders.dart';
import 'package:clinic_v2/app/base/responsive/src/context_info.dart';
import 'package:clinic_v2/app/common/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

mixin CustomBuildersHelper on CustomBuilders {
  Widget getWidgetBuilder(BuildContext context) {
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

  Widget _getBuilder(BuildContext context, ContextInfo contextInfo) {
    return _returnBuilderByPlatform(context, contextInfo) ??
        _returnBuilderByScreenSize(context, contextInfo) ??
        defaultBuilder(context, contextInfo)!;
  }

  Widget? _returnBuilderByPlatform(
      BuildContext context, ContextInfo contextInfo) {
    late final Widget? Function(BuildContext context, ContextInfo contextInfo)
        _platformBuilder;

    switch (contextInfo.context.platform) {
      case TargetPlatform.android:
        if (contextInfo.isTablet) {
          _platformBuilder = androidTabletBuilder;
        } else if (contextInfo.isMobile) {
          _platformBuilder = androidMobileBuilder;
        }
        break;
      case TargetPlatform.iOS:
        if (contextInfo.isTablet) {
          _platformBuilder = iosTabletBuilder;
        } else if (contextInfo.isMobile) {
          _platformBuilder = iosMobileBuilder;
        }
        break;
      // we only have one builder when the platform is windows pc
      case TargetPlatform.windows:
        _platformBuilder = windowsBuilder;
        break;
      case TargetPlatform.macOS:
        _platformBuilder = macBuilder;
        break;
      default:
        break;
    }
    if (_platformBuilder(context, contextInfo) != null) {
      return _platformBuilder(context, contextInfo)!;
    } else {
      return null;
    }
  }

  Widget? _returnBuilderByScreenSize(
      BuildContext context, ContextInfo contextInfo) {
    late final Widget? Function(BuildContext context, ContextInfo contextInfo)
        _screenBuilder;

    switch (contextInfo.deviceTypeByScreen) {
      case DeviceType.mobile:
        _screenBuilder = mobileScreenBuilder;
        break;
      case DeviceType.tablet:
        _screenBuilder = tabletScreenBuilder;
        break;
      case DeviceType.desktop:
        _screenBuilder = computerScreenBuilder;
        break;
      default:
        break;
    }
    if (_screenBuilder(context, contextInfo) != null) {
      return _screenBuilder(context, contextInfo)!;
    } else {
      return null;
    }
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
