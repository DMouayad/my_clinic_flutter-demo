import 'package:clinic_v2/app/blocs/staff_emails_bloc/staff_emails_bloc.dart';
import 'package:clinic_v2/app/features/staff_email/domain/src/base_staff_email.dart';
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/dialogs/windows_general_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'staff_email_form.dart';

Future<void> showWindowsAddStaffDialog(
  BuildContext context, {
  required List<String> existingStaffEmails,
}) async {
  await showWindowsGeneralDialog(
    context: context,
    titleText: context.localizations!.addStaffEmailDialogTitle,
    content: StaffEmailForm(
      existingEmails: existingStaffEmails,
      onSubmit: (email, role) {
        context.read<StaffEmailsBloc>().add(AddStaffEmail(email, role));
        Navigator.of(context).pop();
      },
    ),
  );
}

Future<void> showWindowsEditStaffEmailDialog(
  BuildContext context, {
  required List<String> existingStaffEmails,
  required BaseStaffEmail staffEmail,
}) async {
  await showWindowsGeneralDialog(
    context: context,
    titleText: context.localizations!.editStaffEmailDialogTitle,
    content: StaffEmailForm(
      email: staffEmail.email,
      role: staffEmail.userRole,
      existingEmails: existingStaffEmails,
      onSubmit: (email, role) {
        context.read<StaffEmailsBloc>().add(
              UpdateStaffEmail(
                id: staffEmail.id,
                email: email,
                role: role,
              ),
            );
        Navigator.of(context).pop();
      },
    ),
  );
}
