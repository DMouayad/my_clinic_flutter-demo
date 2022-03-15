import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/src/input_text_field.dart';
import 'package:clinic_v2/app/features/auth/cubit/auth_cubit.dart';
import 'package:clinic_v2/app/features/auth/view/login/helpers/login_screen_helper.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with ResponsiveMixin, LoginScreenFormHelper {
  @override
  void initState() {
    initFormHelper();
    super.initState();
  }

  @override
  void dispose() {
    disposeFormHelper();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 45.0, bottom: 70),
              child: Text(
                'CLINIC',
                style: context.textTheme.headline4?.copyWith(
                  color: context.theme.colorScheme.secondary,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
          Text(
            'Login to your account',
            textAlign: TextAlign.start,
            style: context.textTheme.headline5?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 60),
          InputTextField(
            controller: usernameController,
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
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
              validateInput();
            },
          ),
          const SizedBox(height: 12),

          InputTextField(
            controller: passwordController,
            prefixIcon: Icons.remove_red_eye,
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
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
          ),
          // const Spacer(),
          SizedBox(height: context.heightTransformer(reducedBy: .2)),
          LogInButton(
            onPressed: () {
              if (inputIsValid) {
                context
                    .read<AuthCubit>()
                    .login(usernameController.text, passwordController.text);
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
          )
        ],
      ),
    );
  }
}
