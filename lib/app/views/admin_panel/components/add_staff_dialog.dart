import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/features/staff_email/domain/src/base_staff_email.dart';
import 'package:clinic_v2/app/shared_widgets/custom_widget.dart';
import 'package:clinic_v2/app/shared_widgets/dropdown_menus/utils.dart';
import 'package:clinic_v2/app/shared_widgets/dropdown_menus/windows_tile_with_dropdown_menu.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/dialogs/windows_general_dialog.dart';

Future<void> showWindowsAddStaffDialog(BuildContext context) async {
  showWindowsGeneralDialog(
    context: context,
    titleText: 'Add new staff',
    content: const _NewStaffEmailForm(),
  );
}

class _NewStaffEmailForm extends StatefulWidget {
  const _NewStaffEmailForm({Key? key}) : super(key: key);

  @override
  __NewStaffEmailFormState createState() => __NewStaffEmailFormState();
}

class __NewStaffEmailFormState extends State<_NewStaffEmailForm> {
  var userRole = UserRole.admin;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          WindowsTileWithDropdownMenu<UserRole>(
            labelText: 'Staff role',
            title: 'select new staff position',
            selectedValue: userRole,
            items: UserRole.values
                .map((e) => CustomDropdownMenuItem<UserRole>(
                      selected: userRole == e,
                      value: e,
                      text: e.name,
                    ))
                .toList(),
            onChanged: (item) {
              print(item);
              setState(() => userRole = item.value);
              print(userRole);
            },
          ),
        ],
      ),
    );
  }
}
