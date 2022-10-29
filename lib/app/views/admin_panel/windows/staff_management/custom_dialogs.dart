import 'package:clinic_v2/app/blocs/staff_bloc/staff_bloc.dart';
import 'package:clinic_v2/app/features/staff_member/domain/base_staff_member.dart';
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/dialogs/windows_general_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'staff_member_form.dart';

Future<void> showWindowsAddStaffDialog(
  BuildContext context, {
  required List<String> existingStaffMembers,
}) async {
  await showWindowsGeneralDialog(
    context: context,
    titleText: context.localizations!.addStaffMemberDialogTitle,
    content: StaffMemberForm(
      existingEmails: existingStaffMembers,
      onSubmit: (email, role) {
        context.read<StaffBloc>().add(AddStaffMember(email, role));
        Navigator.of(context).pop();
      },
    ),
  );
}

Future<void> showWindowsEditStaffMemberDialog(
  BuildContext context, {
  required List<String> existingStaffMembers,
  required BaseStaffMember staffMember,
}) async {
  await showWindowsGeneralDialog(
    context: context,
    titleText: context.localizations!.editStaffMemberDialogTitle,
    content: StaffMemberForm(
      email: staffMember.email,
      role: staffMember.userRole,
      existingEmails: existingStaffMembers,
      onSubmit: (email, role) {
        if (email != staffMember.email && role != staffMember.userRole) {
          context.read<StaffBloc>().add(
                UpdateStaffMember(
                  id: staffMember.id,
                  email: email,
                  role: role,
                ),
              );
        }
        Navigator.of(context).pop();
      },
    ),
  );
}
