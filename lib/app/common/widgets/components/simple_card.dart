import 'package:clinic_v2/app/base/responsive/responsive.dart';

class SimpleCard extends Component {
  const SimpleCard({
    required this.child,
    this.padding,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget builder(BuildContext context, contextInfo) {
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
