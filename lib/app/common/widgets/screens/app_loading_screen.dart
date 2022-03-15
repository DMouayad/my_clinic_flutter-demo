import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/simple_components.dart';
import 'package:clinic_v2/app/features/startup/view/widgets/loading_indicator.dart';

class LoadingAppScreen extends ResponsiveScreen {
  const LoadingAppScreen({Key? key}) : super(key: key);

  @override
  Widget mobile(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SimpleComponents.appNameText(),
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
