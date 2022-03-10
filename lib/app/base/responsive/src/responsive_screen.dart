import 'package:flutter/material.dart';

import 'responsive_mixin.dart';

abstract class ResponsiveScreen extends StatelessWidget with ResponsiveMixin {
  const ResponsiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }
}
