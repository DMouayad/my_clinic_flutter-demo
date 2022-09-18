import 'package:clinic_v2/app/core/helpers/builders/custom_builders.dart';
import 'package:flutter/material.dart';

abstract class StateWithAdaptiveBuilders<T extends StatefulWidget>
    extends State<T> with CustomBuilders<Widget>, CustomBuildersHelper<Widget> {
  @override
  Widget build(BuildContext context) {
    return getCurrentContextBuilder(context);
  }
}
