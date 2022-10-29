import 'package:clinic_v2/app/navigation/navigation.dart';
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
              windowsScreen: WindowsVerificationNoticeScreen(),
            );
          },
        );
}
