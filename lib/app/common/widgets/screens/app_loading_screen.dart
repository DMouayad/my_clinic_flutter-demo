import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/components.dart';
import 'package:clinic_v2/app/features/startup/view/widgets/loading_indicator.dart';
import 'package:clinic_v2/app/infrastructure/themes/app_color_scheme.dart';

class LoadingAppScreen extends ResponsiveScreen {
  const LoadingAppScreen({Key? key}) : super(key: key);

  @override
  Widget mobile(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Components.appNameText(),
        const Spacer(),
        LoadingIndicator(
          currentDotColor: AppColorScheme.primary(context)!,
          defaultDotColor: AppColorScheme.primaryContainer(context)!,
          numDots: 5,
        ),
      ],
    );
  }
}
