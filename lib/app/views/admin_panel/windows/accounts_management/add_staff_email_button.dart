import 'package:clinic_v2/app/shared_widgets/custom_buttons/filled_buttons.dart';
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';

import 'add_staff_dialog.dart';

class AddStaffEmailButton extends StatelessWidget {
  const AddStaffEmailButton({required this.parentWidgetSize, Key? key})
      : super(key: key);
  final Size parentWidgetSize;

  @override
  Widget build(BuildContext context) {
    return AdaptiveFilledButton(
      label: 'New',
      onPressed: () async {
        if (context.isWindowsPlatform) {
          await showWindowsAddStaffDialog(context);
        }
      },
      width: context.isMobile
          ? parentWidgetSize.width * .4
          : parentWidgetSize.width * .2,
    );
  }
}
