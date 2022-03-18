import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/features/auth/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends ResponsiveScreen {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget mobileBuilder(BuildContext context, ContextInfo contextInfo) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            print(context.read<AuthCubit>().state);
          },
          child: Text('Press meeeeee'),
        ),
      ),
    );
  }
}
