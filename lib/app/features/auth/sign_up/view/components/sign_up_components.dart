import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

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

class ErrorCard extends Component {
  const ErrorCard({
    required this.errorText,
    this.errorIcon,
    this.color,
    Key? key,
  }) : super(key: key);
  final String errorText;
  final Color? color;
  final Widget? errorIcon;

  @override
  Widget windowsDesktopBuilder(BuildContext context, ContextInfo contextInfo) {
    return fluent_ui.FluentTheme(
      data: fluent_ui.ThemeData(),
      child: fluent_ui.Card(
        backgroundColor: color ?? AppColorScheme.of(context).errorColor,
        child: Text(
          errorText,
          style: context.textTheme.subtitle1?.copyWith(
            color: AppColorScheme.of(context).onError,
          ),
        ),
      ),
    );
  }

  @override
  Widget builder(BuildContext context, contextInfo) {
    return SizedBox(
      width: contextInfo.widgetSize!.width * .7,
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          // decoration: BoxDecoration(
          tileColor: color ?? AppColorScheme.of(context).errorColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          leading: errorIcon,
          title: Text(
            errorText,
            style: context.textTheme.subtitle1?.copyWith(
              color: AppColorScheme.of(context).onError,
            ),
          ),
        ),
      ),
    );
  }
}
