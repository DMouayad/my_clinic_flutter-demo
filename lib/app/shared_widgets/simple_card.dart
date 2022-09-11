import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';

class SimpleCard extends CustomStatelessWidget {
  const SimpleCard({
    required this.child,
    this.padding,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      padding: padding ?? const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius:
            BorderRadius.circular(contextInfo.isDesktopPlatform ? 6 : 16),
      ),
      child: child,
    );
  }
}
