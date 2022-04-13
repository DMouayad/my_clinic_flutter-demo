import 'package:clinic_v2/app/base/responsive/responsive.dart';

class SignUpStepIndicator extends Component {
  final String title;
  const SignUpStepIndicator({
    Key? key,
    required this.title,
  }) : super(key: key);
  // @override
  // Widget desktopBuilder(BuildContext context, ContextInfo contextInfo) {
  //   return fluent.Chip();
  // }

  @override
  Widget builder(BuildContext context, contextInfo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RawChip(
        backgroundColor: AppColorScheme.of(context).primaryContainer,
        label: Text(
          title,
          style: context.textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColorScheme.of(context).onBackground,
          ),
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
  const ErrorCard({required this.errorText, this.color, Key? key})
      : super(key: key);
  final String errorText;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 34),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color ?? AppColorScheme.of(context).errorColor,
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
