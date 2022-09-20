import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/core/helpers/form_helper.dart';
import 'package:clinic_v2/app/shared_widgets//input_text_field.dart';
import 'package:clinic_v2/app/shared_widgets/submit_button.dart';

class SignUpAccountInfoForm extends StatefulWidget {
  const SignUpAccountInfoForm({required this.onSubmit, Key? key})
      : super(key: key);
  final void Function(
    String emailAddress,
    String username,
    String password,
  ) onSubmit;

  @override
  State<SignUpAccountInfoForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpAccountInfoForm> {
  late final FormHelper _formHelper;
  @override
  void initState() {
    _formHelper = FormHelper(isLoginForm: false);
    super.initState();
  }

  @override
  void dispose() {
    _formHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formHelper.formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 30),
        child: Column(
          children: [
            InputTextField(
              controller: _formHelper.usernameController,
              prefixIcon: Icons.person,
              validator: (String? value) {
                if (value?.isEmpty ?? false) {
                  return context.localizations?.usernameIsRequired;
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              hintText: context.localizations?.username,
              textStyle: context.textTheme.bodyText1?.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            InputTextField(
              controller: _formHelper.emailController,
              prefixIcon: CupertinoIcons.at,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? value) {
                if (value?.isEmpty ?? false) {
                  return context.localizations?.emailIsRequired;
                }
                return null;
              },
              hintText: context.localizations?.email,
              textStyle: context.textTheme.bodyText1?.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            InputTextField(
              controller: _formHelper.passwordController,
              prefixIcon: CupertinoIcons.eye,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? password) {
                if (password?.isEmpty ?? true) {
                  return context.localizations?.passwordIsRequired;
                }
                return null;
              },
              hintText: context.localizations?.password,
              textStyle: context.textTheme.bodyText1?.copyWith(
                fontSize: 18,
              ),
              obscure: true,
            ),
            // SizedBox(height: context.screenHeight * .1),
            SubmitButton(
              text: context.localizations!.continueToNextStep,
              iconData: Icons.navigate_next,
              onPressed: () {
                _formHelper.validateInput();
                if (_formHelper.inputIsValid) {
                  widget.onSubmit(
                    _formHelper.emailController!.text,
                    _formHelper.usernameController!.text,
                    _formHelper.passwordController.text,
                  );
                  FocusScope.of(context).unfocus();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
