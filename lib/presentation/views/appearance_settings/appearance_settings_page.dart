import 'package:clinic_v2/presentation/navigation/navigation.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';

class AppearanceSettingsPage extends AppPage {
  AppearanceSettingsPage()
      : super(
          routeSettings:
              const RouteSettings(name: AppRoutes.stepTwoSignUpScreen),
          pageScreenBuilder: (context, animation, secondaryAnimation) {
            return const ContextBuilder();
          },
        );
}
