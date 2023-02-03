import 'package:animate_do/animate_do.dart';

//
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:clinic_v2/presentation/views/startup_failure/components/auth_reset_button.dart';
import 'package:clinic_v2/presentation/views/startup_failure/components/startup_retry_button.dart';
import 'package:clinic_v2/shared/models/result/result.dart';
import 'package:clinic_v2/presentation/shared_widgets/app_name_text.dart';
import 'package:clinic_v2/presentation/shared_widgets/scaffold_with_appbar.dart';

class AppStartupFailureScreen extends StatelessWidget {
  final BasicError error;

  const AppStartupFailureScreen(
    this.error, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithAppBar(
      appBarBackgroundColor: Colors.transparent,
      bodyWithSafeArea: true,
      centerTitle: true,
      showLeading: false,
      title: AppNameText(
        fontColor: context.colorScheme.primary,
        fontSize: 36,
      ),
      body: Column(
        children: [
          const Spacer(),
          Flash(
            duration: const Duration(seconds: 4),
            child: Icon(
              error.exception == const ErrorException.noConnectionFound()
                  ? Icons.signal_wifi_bad_sharp
                  : Icons.error_outline,
              size: 50,
              color: context.colorScheme.errorColor,
            ),
          ),
          const SizedBox(height: 25),
          const StartupRetryButton(),
          const Spacer(),
          const Divider(),
          Text(
            context.localizations!.gettingSameError,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onPrimaryContainer,
            ),
          ),
          const ResetAuthButton(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
