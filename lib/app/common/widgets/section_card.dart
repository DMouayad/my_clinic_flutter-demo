import 'package:clinic_v2/app/base/responsive/responsive.dart';

class SectionCard extends Component {
  const SectionCard({
    required this.title,
    this.children = const [],
    this.headTrailing,
    this.titleIsColored = false,
    this.titleFontSize = 16,
    Key? key,
  }) : super(key: key);

  final String title;
  final List<Widget> children;
  final Widget? headTrailing;
  final bool titleIsColored;
  final double titleFontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      padding: EdgeInsets.fromLTRB(16, 0, 16, children.isNotEmpty ? 12 : 4),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(
          context.isDesktopPlatform?8:
          12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                title,
                style: context.textTheme.subtitle1?.copyWith(
                  color: context.colorScheme.onPrimaryContainer,
                  fontSize: titleFontSize,
                ),
              ),
              trailing: headTrailing,
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
