import 'package:flutter/material.dart';

//
import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_auth_form.dart';

class BlocSignUpForm extends StatelessWidget {
  const BlocSignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAuthForm(
      isLoginForm: false,
      onSubmit: (email, password, phoneNumber, username) {
        context.read<AuthBloc>().add(SignUpRequested(
              email: email,
              username: username!,
              phoneNumber: phoneNumber!,
              password: password,
            ));
      },
    );
  }
}
