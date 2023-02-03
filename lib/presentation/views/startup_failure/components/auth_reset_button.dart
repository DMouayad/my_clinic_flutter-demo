import 'package:clinic_v2/app/blocs/auth_bloc/auth_bloc.dart';
import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/text_buttons.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetAuthButton extends StatelessWidget {
  const ResetAuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTextButton(
      labelColor: context.colorScheme.secondary,
      label: context.localizations!.reLogin,
      onPressed: () => _resetAuth(context),
    );
  }

  void _resetAuth(BuildContext context) {
    context.read<AuthBloc>().add(const ResetAuthState());
  }
}
