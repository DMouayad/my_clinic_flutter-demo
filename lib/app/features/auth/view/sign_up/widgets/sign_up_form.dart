import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/src/input_text_field.dart';
import 'package:clinic_v2/app/features/auth/cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/auth/view/components/submit_button.dart';
import 'package:clinic_v2/app/features/auth/view/helpers/form_helper.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45.0, bottom: 70),
            child: Text(
              'CLINIC',
              style: context.textTheme.headline4?.copyWith(
                color: context.theme.colorScheme.secondary,
                letterSpacing: 1.1,
              ),
            ),
          ),
          Text(
            'Create new CLINIC account',
            textAlign: TextAlign.start,
            style: context.textTheme.headline5?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 60),
          InputTextField(
            controller: _formHelper.usernameController,
            prefixIcon: Icons.person,
            validator: (String? value) {
              if (value?.isEmpty ?? false) {
                return AppLocalizations.of(context)?.fieldIsRequired;
              }
            },
            hintText: AppLocalizations.of(context)?.username,
            textStyle: context.textTheme.bodyText1?.copyWith(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          InputTextField(
            controller: _formHelper.emailController,
            // prefixIcon: Icons.email_outlined,
            prefixIcon: CupertinoIcons.at,
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
            // prefixIcon: Icons.remove_red_eye,
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
          // const Spacer(),
          SizedBox(height: context.heightTransformer(reducedBy: .2)),
          SubmitButton(
            text: 'Sign up',
            onPressed: () {
              if (_formHelper.inputIsValid) {
                context.read<AuthCubit>().login(
                      _formHelper.usernameController.text,
                      _formHelper.passwordController.text,
                    );
                FocusScope.of(context).unfocus();
              }
            },
          ),
          const SizedBox(height: 12),

          TextButton(
            onPressed: () => Navigator.of(context).popAndPushNamed(
              Routes.signUpScreenRoute,
              arguments: context.read<AuthCubit>(),
            ),
            child: const Text("Or create new account"),
          ),
        ],
      ),
    );
  }
}
