import 'package:flutter/material.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/shared_widgets/custom_form.dart';

class BlocLoginForm extends StatelessWidget {
  const BlocLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAuthForm(
      isLoginForm: true,
      errorText: () {
        final state = context.read<AuthBloc>().state;
        if (state is LoginErrorState) {
          return state.error.message;
        }
      }(),
      onSubmit: (email, password, phoneNumber, username) {
        context.read<AuthBloc>().add(LoginRequested(email, password));
      },
    );
  }
}
