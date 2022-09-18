import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  const SimpleCard({
    required this.child,
    this.padding,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      padding: padding ?? const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(context.isDesktopPlatform ? 6 : 16),
      ),
      child: child,
    );
  }
}
