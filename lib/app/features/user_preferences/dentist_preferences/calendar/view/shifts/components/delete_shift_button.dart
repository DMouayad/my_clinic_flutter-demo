import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/custom_expander.dart';
import 'package:fluent_ui/fluent_ui.dart ' as fluent_ui;

class DeleteShiftButton extends ResponsiveStatelessWidget {
  const DeleteShiftButton({required this.onConfirmed, Key? key})
      : super(key: key);
  final void Function() onConfirmed;

  @override
  Widget windowsBuilder(BuildContext context, ContextInfo contextInfo) {
    return CustomExpander(
      headerBackgroundColor: fluent_ui.ButtonState.resolveWith((states) {
        if (states.isHovering) {
          return context.colorScheme.primaryContainer!;
        }
        if (states.isFocused) {
          return context.colorScheme.primary!;
        }
        return Colors.transparent;
      }),
      expanderWidth: 50,
      contentWidth: 110,
      direction: CustomExpanderDirection.left,
      contentBackgroundColor: context.colorScheme.secondaryContainer,
      // header: Text(
      //   'delete',
      //   style: context.textTheme.titleSmall?.copyWith(
      //     fontWeight: FontWeight.w600,
      //   ),
      // ),
      icon: Icon(
        Icons.delete,
        size: 22,
        color: context.colorScheme.errorColor,
      ),
      content: fluent_ui.FilledButton(
        style: fluent_ui.ButtonStyle(
          foregroundColor: fluent_ui.ButtonState.resolveWith(
            (states) {
              if (states.isHovering) {
                return context.colorScheme.onError;
              }
              return context.colorScheme.onBackground;
            },
          ),
          backgroundColor: fluent_ui.ButtonState.resolveWith((states) {
            if (states.isHovering) {
              return context.colorScheme.errorColor;
            }
            return context.colorScheme.backgroundColor;
          }),
        ),
        onPressed: onConfirmed,
        child: Text('confirm'),
      ),
    );
  }
}
