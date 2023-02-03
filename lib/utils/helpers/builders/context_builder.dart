export 'context_builder_helper.dart';

class ContextBuilder<T extends Object> {
  /// Used by Default
  final T? defaultChild;

  // Platform Adaptive
  /// Used If `(context.isWindowsPlatform && context.isMobile)` is true.
  ///
  /// If its `null`, `windowsChild` will be returned
  final T? windowsSmallScreenChild;

  /// Used If `(context.isWindowsPlatform && context.tablet)` is true.
  ///
  /// If its `null`, `windowsChild` will be returned
  final T? windowsMediumScreenChild;

  /// Used If `(context.isWindowsPlatform)` is true
  final T? windowsChild;

  final T? macChild;

  final T? iosMobileChild;

  final T? androidMobileChild;

  final T? iosTabletChild;

  final T? androidTabletChild;

  final T? tabletScreenChild;

  final T? mobileScreenChild;

  /// tablet screen or desktop screen
  final T? wideScreenChild;

  final T? desktopScreenChild;

  const ContextBuilder({
    this.defaultChild,
    this.windowsSmallScreenChild,
    this.windowsMediumScreenChild,
    this.windowsChild,
    this.macChild,
    this.iosMobileChild,
    this.androidMobileChild,
    this.iosTabletChild,
    this.androidTabletChild,
    this.tabletScreenChild,
    this.mobileScreenChild,
    this.wideScreenChild,
    this.desktopScreenChild,
  });

  ContextBuilder<T> copyWith({
    T? defaultChild,
    T? windowsSmallScreenChild,
    T? windowsMediumScreenChild,
    T? windowsChild,
    T? macChild,
    T? iosMobileChild,
    T? androidMobileChild,
    T? iosTabletChild,
    T? androidTabletChild,
    T? tabletScreenChild,
    T? mobileScreenChild,
    T? wideScreenChild,
    T? desktopScreenChild,
  }) {
    return ContextBuilder(
      defaultChild: defaultChild ?? this.defaultChild,
      windowsSmallScreenChild:
          windowsSmallScreenChild ?? this.windowsSmallScreenChild,
      windowsMediumScreenChild:
          windowsMediumScreenChild ?? this.windowsMediumScreenChild,
      windowsChild: windowsChild ?? this.windowsChild,
      macChild: macChild ?? this.macChild,
      iosMobileChild: iosMobileChild ?? this.iosMobileChild,
      androidMobileChild: androidMobileChild ?? this.androidMobileChild,
      iosTabletChild: iosTabletChild ?? this.iosTabletChild,
      androidTabletChild: androidTabletChild ?? this.androidTabletChild,
      tabletScreenChild: tabletScreenChild ?? this.tabletScreenChild,
      mobileScreenChild: mobileScreenChild ?? this.mobileScreenChild,
      wideScreenChild: wideScreenChild ?? this.wideScreenChild,
      desktopScreenChild: desktopScreenChild ?? this.desktopScreenChild,
    );
  }
}
