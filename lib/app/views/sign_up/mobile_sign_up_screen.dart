import 'package:clinic_v2/app/core/extensions/context_extensions.dart';
import 'package:clinic_v2/app/views/sign_up/components/bloc_sign_up_form.dart';
import 'package:flutter/material.dart';
//
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/app/shared_widgets//scaffold_with_appbar.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/custom_back_button.dart';

import 'components/sign_up_message.dart';

class MobileSignUpScreen extends StatelessWidget {
  const MobileSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return ScaffoldWithAppBar(
          showLoadingIndicator: state is SignUpInProgress,
          title: const SignUpMessage(),
          leading: const CustomBackButton(),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.horizontalMargins,
              vertical: 25,
            ),
            child: const Center(
              child: SingleChildScrollView(
                child: BlocSignUpForm(),
              ),
            ),
          ),
        );
      },
    );
  }
}
