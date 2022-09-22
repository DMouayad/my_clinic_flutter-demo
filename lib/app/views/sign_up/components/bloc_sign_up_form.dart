import 'package:flutter/material.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/shared_widgets/custom_form.dart';

class BlocSignUpForm extends StatelessWidget {
  const BlocSignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      isLoginForm: false,
      errorText: () {
        final state = context.read<AuthBloc>().state;
        if (state is SignUpErrorState) {
          return state.error.message;
        }
      }(),
      onSubmit: (email, password, phoneNumber, username) {
        context.read<AuthBloc>().add(SignUpRequested(
              email: email,
              username: username!,
              phoneNumber: phoneNumber!,
              password: password,
              themeMode: context.themeMode,
              locale: context.locale,
            ));
      },
    );
  }
}
