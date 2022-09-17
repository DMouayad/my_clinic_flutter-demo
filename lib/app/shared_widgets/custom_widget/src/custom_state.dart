import 'package:clinic_v2/app/core/helpers/builders/custom_builders.dart';
import 'package:flutter/material.dart';

abstract class CustomState<T extends StatefulWidget> extends State<T>
    with CustomBuilders<Widget>, CustomBuildersHelper<Widget> {
  @override
  @protected
  Widget build(BuildContext context) {
    return getCurrentContextBuilder(context);
  }
}
