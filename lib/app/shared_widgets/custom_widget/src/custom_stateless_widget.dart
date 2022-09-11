import 'package:clinic_v2/app/core/helpers/builders/custom_builders.dart';
import 'package:clinic_v2/app/core/helpers/builders/custom_builders_helper.dart';
import 'package:flutter/material.dart';



abstract class CustomStatelessWidget extends StatelessWidget
    with CustomBuilders<Widget>, CustomBuildersHelper<Widget> {
  const CustomStatelessWidget({
    Key? key,
  }) : super(key: key);

  @override
  @protected
  Widget build(BuildContext context) {
    return getCurrentContextBuilder(context);
  }
}
