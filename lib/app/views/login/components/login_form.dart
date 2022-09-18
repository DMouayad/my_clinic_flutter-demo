import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/core/helpers/form_helper.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:clinic_v2/app/shared_widgets//input_text_field.dart';
import 'package:clinic_v2/app/shared_widgets/submit_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({required this.onSubmit, Key? key}) : super(key: key);
  final void Function(String email, String password) onSubmit;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final FormHelper _formHelper;
  @override
  void initState() {
    _formHelper = FormHelper(isLoginForm: true);
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
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputTextField(
            // filled: false,
            controller: _formHelper.usernameController,
            prefixIcon: Icons.person,
            textInputAction: TextInputAction.next,
            validator: (String? value) {
              if (value?.isEmpty ?? false) {
                return context.localizations?.fieldIsRequired;
              }
              return null;
            },
            hintText: context.localizations?.username,
            textStyle: context.textTheme.bodyText1?.copyWith(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          InputTextField(
            // filled: false,
            controller: _formHelper.passwordController,
            prefixIcon: Icons.remove_red_eye,
            textInputAction: TextInputAction.done,
            validator: (String? password) {
              if (password?.isEmpty ?? true) {
                return context.localizations?.fieldIsRequired;
              }
              return null;
            },
            hintText: context.localizations?.password,
            textStyle: context.textTheme.bodyText1?.copyWith(
              fontSize: 18,
            ),
            onEditingComplete: () {
              setState(() => _formHelper.validateInput());
              FocusScope.of(context).unfocus();
            },
            obscure: true,
          ),
          SizedBox(height: context.screenHeight * .1),
          SubmitButton(
            text: context.localizations!.login,
            iconData: Icons.login,
            onPressed: () {
              setState(() => _formHelper.validateInput());
              if (_formHelper.inputIsValid) {
                widget.onSubmit(
                  _formHelper.emailController!.text,
                  _formHelper.passwordController.text,
                );
              }
            },
          ),
          const SizedBox(height: 20),
          Text(
            context.localizations!.or,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(
              Routes.stepOneSignUpScreenRoute,
            ),
            child: Text(
              context.localizations!.createAccount,
              style: context.textTheme.subtitle2?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
