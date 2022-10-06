import 'package:clinic_v2/app/blocs/staff_emails_bloc/staff_emails_bloc.dart';
import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/core/extensions/string_extensions.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/filled_buttons.dart';
import 'package:clinic_v2/app/shared_widgets/dropdown_menus/utils.dart';
import 'package:clinic_v2/app/shared_widgets/dropdown_menus/windows_tile_with_dropdown_menu.dart';
import 'package:clinic_v2/app/shared_widgets/input_text_field.dart';
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/dialogs/windows_general_dialog.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/windows_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showWindowsAddStaffDialog(BuildContext context) async {
  await showWindowsGeneralDialog(
    context: context,
    titleText: 'Add new staff email',
    content: _NewStaffEmailForm(
      onSubmit: (email, role) {
        context.read<StaffEmailsBloc>().add(AddStaffEmail(email, role));
        Navigator.of(context).pop();
      },
    ),
  );
}

class _NewStaffEmailForm extends StatefulWidget {
  const _NewStaffEmailForm({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final void Function(String email, UserRole role) onSubmit;

  @override
  __NewStaffEmailFormState createState() => __NewStaffEmailFormState();
}

class __NewStaffEmailFormState extends State<_NewStaffEmailForm> {
  var userRole = UserRole.admin;
  late final TextEditingController emailController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            WindowsTileWithDropdownMenu<UserRole>(
              tileLabel: 'Role',
              title: "Select the role of the new CLINIC's staff member",
              selectedValue: userRole,
              dropdownSize: const Size(150, 66),
              tooltipMessage: 'select a role',
              items: UserRole.values
                  .map((e) => CustomDropdownMenuItem<UserRole>(
                        selected: userRole == e,
                        value: e,
                        text: e.name,
                      ))
                  .toList(),
              onChanged: (item) {
                setState(() => userRole = item.value);
              },
            ),
            const Divider(height: 50),
            WindowsTile(
              childSize: const Size.fromWidth(350),
              tileLabel: 'Email address',
              subtitleText:
                  'Enter the email which will be used to register a new account',
              child: Material(
                type: MaterialType.transparency,
                child: Form(
                  key: _formKey,
                  child: InputTextField(
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return context.localizations!.emailIsRequired;
                      } else if (!value!.isValidEmail) {
                        return context.localizations!.emailInvalid;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    textInputAction: TextInputAction.done,
                    hintText: context.localizations!.email,
                    controller: emailController,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 20,
          right: 20,
          child: AdaptiveFilledButton(
            label: 'Add',
            onPressed: () {
              final isValid = _formKey.currentState?.validate() ?? false;
              if (isValid) {
                widget.onSubmit(emailController.text, userRole);
              }
            },
          ),
        ),
      ],
    );
  }
}
