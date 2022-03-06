import 'package:clinic_v2/app/common/widgets/screens/app_loading_screen.dart';
import 'package:clinic_v2/app/features/auth/cubit/auth_cubit.dart';
import 'package:clinic_v2/app/infrastructure/navigation/navigation.dart';
import 'package:clinic_v2/core/features/authentication/data/auth_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      lazy: false,
      create: (_) => ParseAuthRepository(),
      child: BlocProvider(
        create: (context) {
          return AuthCubit(context.read<ParseAuthRepository>())
            ..loadCurrentUser();
        },
        child: Builder(
          builder: (context) {
            return BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthHasLoggedInUser) {
                  Navigator.of(context).popAndPushNamed(Routes.homeScreenRoute);
                }
                if (state is AuthHasNoLoggedInUser) {
                  Navigator.of(context).pushNamed(
                    Routes.loginScreenRoute,
                    arguments: context.read<AuthCubit>(),
                  );
                }
              },
              child: const LoadingAppScreen(),
            );
          },
        ),
      ),
    );
  }
}
