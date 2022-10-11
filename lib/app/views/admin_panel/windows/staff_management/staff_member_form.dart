import 'package:clinic_v2/app/core/enums.dart';
import 'package:clinic_v2/app/core/extensions/string_extensions.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/filled_buttons.dart';
import 'package:clinic_v2/app/shared_widgets/dropdown_menus/utils.dart';
import 'package:clinic_v2/app/shared_widgets/dropdown_menus/windows_tile_with_dropdown_menu.dart';
import 'package:clinic_v2/app/shared_widgets/input_text_field.dart';
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/app/shared_widgets/windows_components/windows_tile.dart';

class StaffMemberForm extends StatefulWidget {
  const StaffMemberForm({
    required this.onSubmit,
    required this.existingEmails,
    this.role,
    this.email,
    this.isEditingForm = false,
    Key? key,
  }) : super(key: key);
  final UserRole? role;
  final String? email;
  final void Function(String email, UserRole role) onSubmit;
  final bool isEditingForm;
  final List<String> existingEmails;

  @override
  _StaffMemberFormState createState() => _StaffMemberFormState();
}

class _StaffMemberFormState extends State<StaffMemberForm> {
  late UserRole userRole;
  late final TextEditingController emailController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final String? initialEmailAddress;
  @override
  void initState() {
    initialEmailAddress = widget.email;
    userRole = widget.role ?? UserRole.admin;
    emailController = TextEditingController(
      text: widget.email,
    );
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
              tileLabel: context.localizations!.roleOrPrivileges,
              title: context.localizations!.selectStaffRole,
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
              tileLabel: context.localizations!.email,
              subtitleText: context.localizations!.enterStaffMember,
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
                      } else if (value.toLowerCase() != initialEmailAddress &&
                          widget.existingEmails.contains(value.toLowerCase())) {
                        return context.localizations!.emailAlreadyExists;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    textInputAction: TextInputAction.done,
                    hintText: context.localizations!.email,
                    controller: emailController,
                    textStyle: context.textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment:
              context.isLTR ? Alignment.bottomRight : Alignment.bottomLeft,
          child: AdaptiveFilledButton(
            width: 70,
            label: context.localizations!.done.toUpperCase(),
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
