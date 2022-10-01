import 'package:flutter/material.dart';

class CustomTableRow extends TableRow {
  CustomTableRow({
    required List<dynamic> childrenContent,
    Decoration? decoration,
    TextStyle? textStyle,
    EdgeInsets? padding,
    Key? key,
  }) : super(
          decoration: decoration,
          children: childrenContent
              .map(
                (e) => e.runtimeType == String
                    ? Padding(
                        padding: padding ?? const EdgeInsets.all(10.0),
                        child: Text(
                          e,
                          style: textStyle,
                        ),
                      )
                    : e as Widget,
              )
              .toList(),
        );
}
