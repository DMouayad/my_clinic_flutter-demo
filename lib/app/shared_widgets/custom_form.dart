import 'package:flutter/services.dart';
//
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:clinic_v2/app/shared_widgets/material_with_utils.dart';
import '../core/helpers/form_helper.dart';
import 'input_text_field.dart';
import 'submit_button.dart';

class CustomAuthForm extends StatefulWidget {
  const CustomAuthForm({
    required this.onSubmit,
    required this.isLoginForm,
    this.errorText,
    Key? key,
  }) : super(key: key);

  final void Function(
    String email,
    String password,
    String? phoneNumber,
    String? username,
  ) onSubmit;
  final String? errorText;
  final bool isLoginForm;

  @override
  _CustomAuthFormState createState() => _CustomAuthFormState();
}

class _CustomAuthFormState extends State<CustomAuthForm> {
  late final FormHelper _formHelper;
  @override
  void initState() {
    _formHelper = FormHelper(isLoginForm: widget.isLoginForm);
    super.initState();
  }

  @override
  void dispose() {
    _formHelper.dispose();
    super.dispose();
  }

  bool? _emailIsValid;
  bool? _passwordIsValid;
  bool? _usernameIsValid;
  bool? _phoneNoIsValid;
  final _errorSuffixIcon = const Icon(Icons.error_outline, color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formHelper.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.horizontalMargins),
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
            if (!widget.isLoginForm) ...[
              InputTextField(
                controller: _formHelper.usernameController,
                prefixIcon: Icons.person,
                validator: (value) {
                  final errorText =
                      _formHelper.usernameValidator(value, context);
                  if (errorText != null) {
                    setState(() => _usernameIsValid = false);
                  } else {
                    setState(() => _usernameIsValid = true);
                  }
                  return errorText;
                },
                hintText: context.localizations?.username,
                textStyle: context.textTheme.bodyText1?.copyWith(
                  fontSize: 18,
                ),
                suffixIconColor: context.colorScheme.errorColor,
                suffixIcon:
                    (_usernameIsValid ?? true) ? null : _errorSuffixIcon,
              ),
              const SizedBox(height: 12),
              InputTextField(
                controller: _formHelper.phoneNoController,
                prefixIcon: Icons.phone,
                textDirection: TextDirection.ltr,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  final errorText =
                      _formHelper.phoneNoValidator(value, context);
                  if (errorText != null) {
                    setState(() => _phoneNoIsValid = false);
                  } else {
                    setState(() => _phoneNoIsValid = true);
                  }
                  return errorText;
                },
                maxLength: 22,
                keyboardType: TextInputType.phone,
                hintText: context.localizations?.phoneNo,
                textStyle: context.textTheme.bodyText1?.copyWith(
                  fontSize: 18,
                ),
                suffixIconColor: context.colorScheme.errorColor,
                suffixIcon: (_phoneNoIsValid ?? true) ? null : _errorSuffixIcon,
              ),
              const SizedBox(height: 12),
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
            SizedBox(height: context.screenHeight * .14),
            SubmitButton(
              text: widget.isLoginForm
                  ? context.localizations!.login
                  : context.localizations!.signUp,
              iconData:
                  widget.isLoginForm ? Icons.login : Icons.app_registration,
              onPressed: () {
                setState(() => _formHelper.validateInput());
                if (_formHelper.inputIsValid) {
                  widget.onSubmit(
                    _formHelper.emailController!.text,
                    _formHelper.passwordController.text,
                    widget.isLoginForm
                        ? null
                        : _formHelper.phoneNoController!.text,
                    widget.isLoginForm
                        ? null
                        : _formHelper.usernameController!.text,
                  );
                }
              },
            ),
            if (widget.isLoginForm) ...[
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
                  AppRoutes.signUpScreen,
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
          ],
        ),
      ),
    );
  }
}
