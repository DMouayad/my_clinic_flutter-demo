import 'package:clinic_v2/app/shared_widgets/custom_widget.dart';

class DoneButton extends CustomStatelessWidget {
  const DoneButton({
    this.label,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final String? label;
  final void Function()? onPressed;

  @override
  Widget customBuild(BuildContext context, WidgetInfo contextInfo) {
    return Container(
      color: context.theme.scaffoldBackgroundColor.withOpacity(.9),
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        height: 46,
        color: context.theme.colorScheme.primary,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.done,
              size: 20,
              color: context.colorScheme.onPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              label ?? 'Done',
              style: context.textTheme.bodyText1?.copyWith(
                color: context.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
