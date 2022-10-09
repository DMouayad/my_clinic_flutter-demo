import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';

import 'staff_email_dialogs.dart';

class AddStaffEmailButton extends StatelessWidget {
  const AddStaffEmailButton({
    required this.parentWidgetSize,
    required this.existingStaffEmails,
    Key? key,
  }) : super(key: key);

  final Size parentWidgetSize;
  final List<String> existingStaffEmails;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(context.localizations!.add.toUpperCase()),
      onPressed: () async {
        if (context.isWindowsPlatform) {
          await showWindowsAddStaffDialog(
            context,
            existingStaffEmails: existingStaffEmails,
          );
        }
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(
          context.isMobile
              ? parentWidgetSize.width * .4
              : parentWidgetSize.width * .2,
          36,
        )),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          return context.colorScheme.primary;
        }),
        textStyle:
            MaterialStateProperty.all(context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w500,
        )),
      ),
      icon: Icon(
        Icons.add,
        color: context.colorScheme.primary,
      ),
    );
  }
}
