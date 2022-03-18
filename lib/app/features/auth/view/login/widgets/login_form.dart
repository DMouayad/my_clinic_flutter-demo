import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/src/app_name_text.dart';
import 'package:clinic_v2/app/common/widgets/components/src/input_text_field.dart';
import 'package:clinic_v2/app/features/auth/cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/auth/view/components/submit_button.dart';
import 'package:clinic_v2/app/features/auth/view/helpers/form_helper.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

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
        children: [
          const SizedBox(height: 60),
          InputTextField(
            controller: _formHelper.usernameController,
            prefixIcon: Icons.person,
            textInputAction: TextInputAction.next,
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
            controller: _formHelper.passwordController,
            prefixIcon: Icons.remove_red_eye,
            textInputAction: TextInputAction.done,
            validator: (String? password) {
              if (password?.isEmpty ?? true) {
                return AppLocalizations.of(context)?.fieldIsRequired;
              }
            },
            hintText: AppLocalizations.of(context)?.password,
            textStyle: context.textTheme.bodyText1?.copyWith(
              fontSize: 18,
            ),
            onEditingComplete: () {
              setState(() => _formHelper.validateInput());
              FocusScope.of(context).unfocus();
            },
            obscure: true,
          ),
          // const Spacer(),
          SizedBox(height: context.heightTransformer(reducedBy: 90)),
          SubmitButton(
            text: AppLocalizations.of(context)?.login ?? 'Login',
            onPressed: () {
              setState(() => _formHelper.validateInput());
              print(context.read<AuthCubit>().isClosed);
              // if (_formHelper.inputIsValid) {
              //   context.read<AuthCubit>().login(
              //         _formHelper.usernameController.text,
              //         _formHelper.passwordController.text,
              //       );
              //   FocusScope.of(context).unfocus();
              // }
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
