import 'package:flutter/material.dart';

import 'package:clinic_v2/app/core/entities/context_info.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'custom_builders.dart';

mixin CustomBuildersHelper<T extends Object> on CustomBuilders<T> {
  @protected
  T getCurrentContextBuilder(BuildContext context) {
    if (T == Widget) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          ContextInfo contextInfo = ContextInfo(
            context,
            widgetSize: Size(constraints.maxWidth, constraints.maxHeight),
          );
          return MediaQuery(
            data: contextInfo.mediaQuery.copyWith(
              textScaleFactor:
                  _getDeviceTextScaleFactor(contextInfo.deviceTypeByScreen),
            ),
            child: (_returnBuilderByPlatform(context, contextInfo)
                    as Widget?) ??
                (_returnBuilderByScreenSize(context, contextInfo) as Widget?) ??
                (defaultBuilder(context, contextInfo)! as Widget),
          );
        },
      ) as T;
    } else {
      ContextInfo contextInfo = ContextInfo(
        context,
      );

      return _returnBuilderByPlatform(context, contextInfo) ??
          _returnBuilderByScreenSize(context, contextInfo) ??
          defaultBuilder(context, contextInfo)!;
    }
  }

  T? _returnBuilderByPlatform(BuildContext context, ContextInfo contextInfo) {
    late final T? Function(BuildContext context, ContextInfo contextInfo)
        _builderByPlatform;

    switch (contextInfo.context.platform) {
      case TargetPlatform.android:
        if (contextInfo.isTablet) {
          _builderByPlatform = androidTabletBuilder;
        } else if (contextInfo.isMobile) {
          _builderByPlatform = androidMobileBuilder;
        }
        break;
      case TargetPlatform.iOS:
        if (contextInfo.isTablet) {
          _builderByPlatform = iosTabletBuilder;
        } else if (contextInfo.isMobile) {
          _builderByPlatform = iosMobileBuilder;
        }
        break;
      case TargetPlatform.windows:
        _builderByPlatform = windowsBuilder;
        break;
      case TargetPlatform.macOS:
        _builderByPlatform = macBuilder;
        break;
      default:
        break;
    }
    if (_builderByPlatform(context, contextInfo) != null) {
      return _builderByPlatform(context, contextInfo)!;
    } else {
      return null;
    }
  }

  T? _returnBuilderByScreenSize(BuildContext context, ContextInfo contextInfo) {
    late final T? Function(BuildContext context, ContextInfo contextInfo)
        _builderByScreenSize;

    switch (contextInfo.deviceTypeByScreen) {
      case DeviceType.mobile:
        _builderByScreenSize = mobileScreenBuilder;
        break;
      case DeviceType.tablet:
        _builderByScreenSize = tabletScreenBuilder;
        break;
      case DeviceType.desktop:
        _builderByScreenSize = desktopScreenBuilder;
        break;
      default:
        break;
    }
    if (_builderByScreenSize(context, contextInfo) != null) {
      return _builderByScreenSize(context, contextInfo)!;
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
