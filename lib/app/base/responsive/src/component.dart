import 'package:flutter/material.dart';
import 'responsive_mixin.dart';

/// A widget component, has the features of [GetResponsiveView] to build adaptive and responsive
/// block of widgets.
abstract class Component extends StatelessWidget with ResponsiveMixin {
  Component({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }
}
