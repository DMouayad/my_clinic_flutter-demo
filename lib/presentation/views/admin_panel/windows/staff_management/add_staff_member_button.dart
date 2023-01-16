import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/adaptive_text_icon_button.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';

import 'custom_dialogs.dart';

class AddStaffMemberButton extends StatelessWidget {
  const AddStaffMemberButton({
    required this.parentWidgetSize,
    required this.existingStaffMembers,
    Key? key,
  }) : super(key: key);

  final Size parentWidgetSize;
  final List<String> existingStaffMembers;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTextIconButton(
      label: context.localizations!.add.toUpperCase(),
      tooltipMessage: "add staff member",
      onPressed: () async {
        if (context.isWindowsPlatform) {
          await showWindowsAddStaffDialog(
            context,
            existingStaffMembers: existingStaffMembers,
          );
        }
      },
      iconWidget: Icon(
        Icons.add,
        color: context.colorScheme.primary,
      ),
      size: Size(
        context.isMobile
            ? parentWidgetSize.width * .4
            : parentWidgetSize.width * .2,
        36,
      ),
      foregroundColor: context.colorScheme.primary,
    );
  }
}
