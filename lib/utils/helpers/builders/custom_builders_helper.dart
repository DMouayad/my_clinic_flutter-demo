import 'package:flutter/material.dart';

import 'package:clinic_v2/utils/extensions/context_extensions.dart';
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
    late final T? Function(BuildContext context) builderByPlatform;

    switch (context.platform) {
      case TargetPlatform.android:
        if (context.isTablet) {
          builderByPlatform = androidTabletBuilder;
        } else if (context.isMobile) {
          builderByPlatform = androidMobileBuilder;
        }
        break;
      case TargetPlatform.iOS:
        if (context.isTablet) {
          builderByPlatform = iosTabletBuilder;
        } else if (context.isMobile) {
          builderByPlatform = iosMobileBuilder;
        }
        break;
      case TargetPlatform.windows:
        builderByPlatform = windowsBuilder;
        break;
      case TargetPlatform.macOS:
        builderByPlatform = macBuilder;
        break;
      default:
        break;
    }
    if (builderByPlatform(context) != null) {
      return builderByPlatform(context)!;
    } else {
      return null;
    }
  }

  T? _returnBuilderByScreenSize(BuildContext context) {
    late final T? Function(BuildContext context) builderByScreenSize;

    switch (context.deviceTypeByScreen) {
      case DeviceType.mobile:
        builderByScreenSize = mobileScreenBuilder;
        break;
      case DeviceType.tablet:
        builderByScreenSize = tabletScreenBuilder;
        break;
      case DeviceType.desktop:
        builderByScreenSize = desktopScreenBuilder;
        break;
      default:
        break;
    }
    if (builderByScreenSize(context) != null) {
      return builderByScreenSize(context)!;
    } else {
      return null;
    }
  }
}
