import 'package:clinic_v2/app/navigation/navigation.dart';

class AppearanceSettingsPage extends AppPage {
  AppearanceSettingsPage()
      : super(
          routeSettings: const RouteSettings(name: Routes.stepTwoSignUpScreen),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return const PageScreensBuilder();
          },
        );
}
