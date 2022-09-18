import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    required this.title,
    this.children = const [],
    this.headTrailing,
    this.titleIsColored = false,
    this.titleFontSize = 16,
    this.contentPadding,
    this.cardColor,
    Key? key,
  }) : super(key: key);

  final String title;
  final List<Widget> children;
  final Widget? headTrailing;
  final bool titleIsColored;
  final double titleFontSize;
  final EdgeInsets? contentPadding;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints.expand(),
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      padding: contentPadding ??
          EdgeInsets.fromLTRB(
            16,
            12,
            16,
            children.isNotEmpty ? 12 : 4,
          ),
      decoration: BoxDecoration(
        color: cardColor ?? context.colorScheme.surface,
        borderRadius: BorderRadius.circular(
          context.isDesktopPlatform ? 8 : 12,
        ),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: context.textTheme.subtitle1?.copyWith(
                  color: titleIsColored
                      ? context.colorScheme.primary
                      : context.colorScheme.onPrimaryContainer,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ...children,
            ],
          ),
          if (headTrailing != null)
            Align(
              alignment: context.isArabicLocale
                  ? Alignment.topLeft
                  : Alignment.topRight,
              child: headTrailing!,
            ),
        ],
      ),
    );
  }
}
