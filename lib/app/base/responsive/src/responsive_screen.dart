import 'package:flutter/material.dart';

import 'responsive_helper.dart';

abstract class ResponsiveScreen extends StatelessWidget with ResponsiveBuilder {
  const ResponsiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }
}
