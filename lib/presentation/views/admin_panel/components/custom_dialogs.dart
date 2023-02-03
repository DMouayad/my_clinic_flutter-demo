import 'package:clinic_v2/app/blocs/staff_bloc/staff_bloc.dart';
import 'package:clinic_v2/domain/staff_member/base/base_staff_member.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_dialogs/adaptive_dialog.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'staff_member_form.dart';

Future<void> showAddStaffDialog(
  BuildContext context, {
  required List<String> existingStaffMembers,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AdaptiveDialog(
        type: DialogType.general,
        titleText: context.localizations!.addStaffMemberDialogTitle,
        content: StaffMemberForm(
          existingEmails: existingStaffMembers,
          onSubmit: (email, role) {
            context.read<StaffBloc>().add(AddStaffMember(email, role));
            Navigator.of(context).pop();
          },
        ),
      );
    },
  );
}

Future<void> showEditStaffMemberDialog(
  BuildContext context, {
  required List<String> existingStaffMembers,
  required BaseStaffMember staffMember,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AdaptiveDialog(
        type: DialogType.general,
        titleText: context.localizations!.editStaffMemberDialogTitle,
        content: StaffMemberForm(
          email: staffMember.email,
          role: staffMember.userRole,
          existingEmails: existingStaffMembers,
          onSubmit: (email, role) {
            if (email != staffMember.email) {
              context
                  .read<StaffBloc>()
                  .add(UpdateStaffMember(id: staffMember.id, email: email));
            }
            if (role != staffMember.userRole) {
              context
                  .read<StaffBloc>()
                  .add(UpdateStaffMember(id: staffMember.id, role: role));
            }
            Navigator.of(context).pop();
          },
        ),
      );
    },
  );
}
