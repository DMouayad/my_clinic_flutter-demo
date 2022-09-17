import 'package:clinic_v2/app/navigation/navigation.dart';

class AppearanceSettingsPage extends AppPage {
  AppearanceSettingsPage()
      : super(
          routeSettings:
              const RouteSettings(name: Routes.stepTwoSignUpScreenRoute),
          pageScreensBuilder: (context, animation, secondaryAnimation) {
            return PageScreensBuilder();
          },
        );
}
