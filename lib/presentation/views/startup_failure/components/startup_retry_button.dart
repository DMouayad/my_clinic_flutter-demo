import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/adaptive_text_icon_button.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupRetryButton extends StatelessWidget {
  const StartupRetryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTextIconButton(
      margins: const EdgeInsets.symmetric(vertical: 20),
      label: context.localizations!.retry,
      iconWidget: const Icon(Icons.refresh),
      tooltipMessage: context.localizations!.retry,
      onPressed: () =>
          context.read<AuthBloc>().add(const AuthInitRetryRequested()),
    );
  }
}
