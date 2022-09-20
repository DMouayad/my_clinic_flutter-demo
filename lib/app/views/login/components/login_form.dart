import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/core/helpers/form_helper.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:clinic_v2/app/shared_widgets//input_text_field.dart';
import 'package:clinic_v2/app/shared_widgets/submit_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    required this.onSubmit,
    this.errorText,
    Key? key,
  }) : super(key: key);

  final void Function(String email, String password) onSubmit;
  final String? errorText;
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

  bool? _emailIsValid;
  bool? _passwordIsValid;
  final _errorSuffixIcon = const Icon(Icons.error_outline, color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formHelper.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.errorText != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: context.colorScheme.errorColor,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.errorText!,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.errorColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
          InputTextField(
            controller: _formHelper.emailController,
            prefixIcon: Icons.email_outlined,
            textInputAction: TextInputAction.next,
            validator: (value) {
              final errorText = _formHelper.emailValidator(value, context);
              if (errorText != null) {
                setState(() => _emailIsValid = false);
              } else {
                setState(() => _emailIsValid = true);
              }
              return errorText;
            },
            hintText: context.localizations?.email,
            textStyle: context.textTheme.bodyText1?.copyWith(
              fontSize: 18,
            ),
            suffixIconColor: context.colorScheme.errorColor,
            suffixIcon: (_emailIsValid ?? true) ? null : _errorSuffixIcon,
          ),
          const SizedBox(height: 12),
          InputTextField(
            controller: _formHelper.passwordController,
            prefixIcon: Icons.remove_red_eye,
            textInputAction: TextInputAction.done,
            validator: (value) {
              final errorText = _formHelper.passwordValidator(value, context);
              if (errorText != null) {
                setState(() => _passwordIsValid = false);
              } else {
                setState(() => _passwordIsValid = true);
              }
              return errorText;
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
            suffixIcon: (_passwordIsValid ?? true) ? null : _errorSuffixIcon,
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
              Routes.signUpScreenRoute,
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
