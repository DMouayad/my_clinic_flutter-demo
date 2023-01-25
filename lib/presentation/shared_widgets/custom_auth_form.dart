import 'package:clinic_v2/utils/helpers/form_helper.dart';
import 'package:flutter/services.dart';

//
import 'package:clinic_v2/presentation/navigation/navigation.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import '../../presentation/shared_widgets/input_text_field.dart';
import '../../presentation/shared_widgets/submit_button.dart';

class CustomAuthForm extends StatefulWidget {
  const CustomAuthForm({
    required this.onSubmit,
    required this.isLoginForm,
    Key? key,
  }) : super(key: key);

  final void Function(
      String email,
      String password,
      String? phoneNumber,
      String? username,
      ) onSubmit;
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formHelper.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.horizontalMargins),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            if (!widget.isLoginForm) ...[
              InputTextField(
                controller: _formHelper.usernameController,
                prefixIcon: Icons.person,
                validator: (value) {
                  return _formHelper.usernameValidator(value, context);
                },
                hintText: context.localizations?.username,
                textStyle: context.textTheme.bodyText1?.copyWith(
                  fontSize: 18,
                ),
                suffixIconColor: context.colorScheme.errorColor,
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
                  return _formHelper.phoneNoValidator(value, context);
                },
                maxLength: 22,
                keyboardType: TextInputType.phone,
                hintText: context.localizations?.phoneNo,
                textStyle: context.textTheme.bodyText1?.copyWith(
                  fontSize: 18,
                ),
                suffixIconColor: context.colorScheme.errorColor,
              ),
              const SizedBox(height: 12),
            ],
            InputTextField(
              controller: _formHelper.emailController,
              prefixIcon: Icons.email_outlined,
              textInputAction: TextInputAction.next,
              validator: (value) {
                return _formHelper.emailValidator(value, context);
              },
              hintText: context.localizations?.email,
              textStyle: context.textTheme.bodyText1?.copyWith(
                fontSize: 18,
              ),
              suffixIconColor: context.colorScheme.errorColor,
            ),
            const SizedBox(height: 12),
            InputTextField(
              controller: _formHelper.passwordController,
              prefixIcon: Icons.remove_red_eye,
              textInputAction: TextInputAction.done,
              validator: (value) {
                return _formHelper.passwordValidator(value, context);
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
            SizedBox(height: context.screenHeight * .14),
            SubmitButton(
              expandInWidth: true,
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
                onPressed: () =>
                    Navigator.of(context).pushNamed(
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
