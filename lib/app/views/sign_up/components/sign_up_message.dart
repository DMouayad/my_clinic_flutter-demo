import 'package:clinic_v2/app/shared_widgets/custom_widget/custom_widget.dart';

class SignUpMessage extends CustomStatelessWidget {
  const SignUpMessage({Key? key}) : super(key: key);

  @override
  Widget defaultBuilder(BuildContext context, ContextInfo contextInfo) {
    return Text(
      AppLocalizations.of(context)!.signUpScreenMessage,
      textAlign: TextAlign.start,
      style: contextInfo.isDesktop
          ? context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onBackground,
            )
          : context.textTheme.headline6?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onBackground,
            ),
    );
  }
}
