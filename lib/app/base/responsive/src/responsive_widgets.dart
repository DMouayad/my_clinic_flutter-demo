import 'package:clinic_v2/app/base/responsive/src/builders.dart';
import 'package:flutter/material.dart';

import 'responsive_builder.dart';

abstract class ResponsiveStatelessWidget extends StatelessWidget
    with CustomBuilders, CustomBuildersHelper {
  const ResponsiveStatelessWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getWidgetBuilder(context);
  }
}

abstract class StateWithResponsiveBuilder<W extends StatefulWidget>
    extends State<W> with CustomBuilders, CustomBuildersHelper {
  @override
  Widget build(BuildContext context) {
    return getWidgetBuilder(context);
  }
}
