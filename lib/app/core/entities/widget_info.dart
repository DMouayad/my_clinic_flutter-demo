import 'package:flutter/material.dart';

class WidgetInfo {
  final Size widgetSize;

  WidgetInfo({required this.widgetSize});

  @override
  String toString() {
    return 'widgetSize: $widgetSize)';
  }
}
