import 'package:flutter/material.dart';

import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'custom_builders.dart';

mixin CustomBuildersHelper<T extends Object> on CustomBuilders<T> {
  @protected
  T getCurrentContextBuilder(BuildContext context) {
    return _returnBuilderByPlatform(context) ??
        _returnBuilderByScreenSize(context) ??
        _getDefaultBuilder(context);
  }

  T _getDefaultBuilder(BuildContext context) {
    return ((context.isDesktop || context.isTablet) &&
            wideScreenBuilder(context) != null)
        ? wideScreenBuilder(context)!
        : defaultBuilder(context)!;
  }

  T? _returnBuilderByPlatform(BuildContext context) {
    late final T? Function(BuildContext context) _builderByPlatform;

    switch (context.platform) {
      case TargetPlatform.android:
        if (context.isTablet) {
          _builderByPlatform = androidTabletBuilder;
        } else if (context.isMobile) {
          _builderByPlatform = androidMobileBuilder;
        }
        break;
      case TargetPlatform.iOS:
        if (context.isTablet) {
          _builderByPlatform = iosTabletBuilder;
        } else if (context.isMobile) {
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
    if (_builderByPlatform(context) != null) {
      return _builderByPlatform(context)!;
    } else {
      return null;
    }
  }

  T? _returnBuilderByScreenSize(BuildContext context) {
    late final T? Function(BuildContext context) _builderByScreenSize;

    switch (context.deviceTypeByScreen) {
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
    if (_builderByScreenSize(context) != null) {
      return _builderByScreenSize(context)!;
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
