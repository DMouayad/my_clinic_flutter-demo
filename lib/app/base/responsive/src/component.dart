import 'package:flutter/material.dart';
import 'responsive_helper.dart';

/// A widget component, has the features of the [ResponsiveMixin] to build adaptive and responsive
/// block of widgets.
abstract class Component extends StatelessWidget with ResponsiveBuilder {
  const Component({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }
}
