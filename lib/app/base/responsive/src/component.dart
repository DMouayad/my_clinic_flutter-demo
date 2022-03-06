import 'package:flutter/material.dart';
import 'responsive_mixin.dart';

/// A widget component, has the features of [GetResponsiveView] to build adaptive and responsive
/// block of widgets.
abstract class Component extends StatelessWidget with ResponsiveMixin {
  Component({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isMobile(context) && mobile(context) != null) {
      return mobile(context)!;
    } else if (isTablet(context) && tablet(context) != null) {
      return tablet(context)!;
    } else if (isDesktop(context) && desktop(context) != null) {
      return desktop(context)!;
    } else {
      return builder(context)!;
    }
  }
}
