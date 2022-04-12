import 'package:clinic_v2/app/base/responsive/responsive.dart';

class SignUpStepIndicator extends StatelessWidget {
  final String title;
  const SignUpStepIndicator({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      backgroundColor: AppColorScheme.of(context).primaryContainer,
      label: Text(
        title,
        style: context.textTheme.bodyText1?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColorScheme.of(context).onBackground,
        ),
      ),
    );
  }
}

class SignUpMessage extends StatelessWidget {
  const SignUpMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.signUpScreenMessage,
      textAlign: TextAlign.start,
      style: context.textTheme.headline6?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.onBackground,
      ),
    );
  }
}

class ErrorCard extends StatelessWidget {
  const ErrorCard({required this.errorText, Key? key}) : super(key: key);
  final String errorText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 34),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        errorText,
        style: context.textTheme.subtitle1?.copyWith(
          color: AppColorScheme.of(context).onError,
        ),
      ),
    );
  }
}
