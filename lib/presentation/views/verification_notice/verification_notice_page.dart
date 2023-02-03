import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
import 'package:clinic_v2/app/blocs/email_verification_cubit/email_verification_cubit.dart';
import 'package:clinic_v2/domain/authentication/base/base_auth_repository.dart';
import 'package:clinic_v2/presentation/navigation/navigation.dart';
import '../../../presentation/views/verification_notice/windows_verification_notice_screen.dart';

class VerificationNoticePage extends AppPage {
  VerificationNoticePage()
      : super(
          routeSettings: const RouteSettings(name: AppRoutes.signUpScreen),
          pageTransitionBuilder: const ContextBuilder(
            tabletScreenChild: RouteTransitionType.none,
            windowsChild: RouteTransitionType.none,
          ),
          pageScreenBuilder: (context, animation, secondaryAnimation) {
            return ContextBuilder(
              windowsChild: BlocProvider(
                create: (context) =>
                    EmailVerificationCubit(context.read<BaseAuthRepository>()),
                child: const WindowsVerificationNoticeScreen(),
              ),
            );
          },
        );
}
