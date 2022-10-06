import 'package:clinic_v2/app/core/entities/widget_info.dart';
import 'package:flutter/material.dart';

class BuilderWithWidgetInfo extends StatelessWidget {
  final Widget Function(BuildContext context, WidgetInfo widgetInfo) builder;

  const BuilderWithWidgetInfo({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        WidgetInfo widgetInfo = WidgetInfo(
          widgetSize: Size(constraints.maxWidth, constraints.maxHeight),
        );
        return builder(context, widgetInfo);
      },
    );
  }
}
