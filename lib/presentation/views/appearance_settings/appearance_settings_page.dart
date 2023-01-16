import 'package:clinic_v2/presentation/navigation/navigation.dart';

class AppearanceSettingsPage extends AppPage {
  AppearanceSettingsPage()
      : super(
          routeSettings:
              const RouteSettings(name: AppRoutes.stepTwoSignUpScreen),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return const PageScreensBuilder();
          },
        );
}
