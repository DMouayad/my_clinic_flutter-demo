import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:clinic_v2/app/common/widgets/components/src/app_name_text.dart';
import 'package:clinic_v2/app/features/startup/view/widgets/loading_indicator.dart';

class LoadingAppScreen extends ResponsiveScreen {
  const LoadingAppScreen({Key? key}) : super(key: key);

  @override
  Widget mobileBuilder(context, contextInfo) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppNameText(
              fontSize: 32,
              fontColor: AppColorScheme.primary(context),
            ),
            LoadingIndicator(
              currentDotColor: AppColorScheme.primary(context)!,
              defaultDotColor: AppColorScheme.primaryContainer(context)!,
              numDots: 5,
              size: 60,
            ),
          ],
        ),
      ),
    );
  }
}
