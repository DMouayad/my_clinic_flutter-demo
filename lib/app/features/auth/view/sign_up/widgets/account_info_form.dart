import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/src/input_text_field.dart';
import 'package:clinic_v2/app/features/auth/view/components/submit_button.dart';
import 'package:clinic_v2/app/features/auth/view/helpers/form_helper.dart';
import 'package:clinic_v2/app/features/auth/view/sign_up/cubit/sign_up_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpAccountInfoForm extends StatefulWidget {
  const SignUpAccountInfoForm({Key? key}) : super(key: key);
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
      child: Column(
        children: [
          InputTextField(
            controller: _formHelper.usernameController,
            prefixIcon: Icons.person,
            validator: (String? value) {
              if (value?.isEmpty ?? false) {
                return AppLocalizations.of(context)?.fieldIsRequired;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: AppLocalizations.of(context)?.username,
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
                return AppLocalizations.of(context)?.fieldIsRequired;
              }
            },
            hintText: AppLocalizations.of(context)?.email,
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
                return AppLocalizations.of(context)?.fieldIsRequired;
              }
            },
            hintText: AppLocalizations.of(context)?.password,
            textStyle: context.textTheme.bodyText1?.copyWith(
              fontSize: 18,
            ),
            obscure: true,
          ),
          SizedBox(height: context.height * .1),
          SubmitButton(
            text: 'Continue',
            iconData: Icons.navigate_next,
            onPressed: () {
              _formHelper.validateInput();
              if (_formHelper.inputIsValid) {
                context.read<SignUpCubit>().validateUserEmail(
                      _formHelper.emailController!.text,
                    );
                FocusScope.of(context).unfocus();
              }
            },
          ),
        ],
      ),
    );
  }
}
