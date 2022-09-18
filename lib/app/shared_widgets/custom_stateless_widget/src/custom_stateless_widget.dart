import 'package:clinic_v2/app/core/entities/widget_info.dart';
import 'package:flutter/material.dart';

abstract class CustomStatelessWidget extends StatelessWidget {
  const CustomStatelessWidget({
    Key? key,
  }) : super(key: key);

  @override
  @protected
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        WidgetInfo widgetInfo = WidgetInfo(
          widgetSize: Size(constraints.maxWidth, constraints.maxHeight),
        );
        return customBuild(context, widgetInfo);
      },
    );
  }

  Widget customBuild(BuildContext context, WidgetInfo widgetInfo);
}
