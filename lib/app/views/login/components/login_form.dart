import 'package:clinic_v2/app/core/helpers/form_helper.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:clinic_v2/app/shared_widgets//input_text_field.dart';
import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';
import 'package:clinic_v2/app/shared_widgets/submit_button.dart';
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
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputTextField(
            // filled: false,
            controller: _formHelper.usernameController,
            prefixIcon: Icons.person,
            textInputAction: TextInputAction.next,
            validator: (String? value) {
              if (value?.isEmpty ?? false) {
                return AppLocalizations.of(context)?.fieldIsRequired;
              }
              return null;
            },
            hintText: AppLocalizations.of(context)?.username,
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
                return AppLocalizations.of(context)?.fieldIsRequired;
              }
              return null;
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
          SizedBox(height: context.height * .1),
          SubmitButton(
            text: AppLocalizations.of(context)!.login,
            iconData: Icons.login,
            onPressed: () {
              setState(() => _formHelper.validateInput());
              if (_formHelper.inputIsValid) {
                context.read<AuthCubit>().login(
                      _formHelper.usernameController.text,
                      _formHelper.passwordController.text,
                    );
              }
            },
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.or,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(
              Routes.stepOneSignUpScreenRoute,
              arguments: context.read<AuthCubit>(),
            ),
            child: Text(
              AppLocalizations.of(context)!.createAccount,
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
