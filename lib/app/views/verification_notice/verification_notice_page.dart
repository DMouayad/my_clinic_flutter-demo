import 'package:clinic_v2/app/blocs/email_verification_cubit/email_verification_cubit.dart';
import 'package:clinic_v2/app/features/authentication/domain/base_auth_repository.dart';
import 'package:clinic_v2/app/navigation/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'windows_verification_notice_screen.dart';

class VerificationNoticePage extends AppPage {
  VerificationNoticePage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.signUpScreen),
          pageTransitions: const RouteTransitionBuilder(
            tablet: RouteTransitionType.none,
            windows: RouteTransitionType.none,
          ),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder(
              windowsScreen: BlocProvider(
                create: (context) =>
                    EmailVerificationCubit(context.read<BaseAuthRepository>()),
                child: const WindowsVerificationNoticeScreen(),
              ),
            );
          },
        );
}
