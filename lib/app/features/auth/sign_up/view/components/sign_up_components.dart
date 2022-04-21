import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

class SignUpStepIndicator extends Component {
  final String title;
  const SignUpStepIndicator({
    Key? key,
    required this.title,
    this.padding,
  }) : super(key: key);

  final EdgeInsets? padding;

  @override
  Widget builder(BuildContext context, contextInfo) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: RawChip(
        backgroundColor: AppColorScheme.of(context).primaryContainer,
        label: Text(
          title,
          style: context.textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColorScheme.of(context).onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}

class SignUpMessage extends Component {
  const SignUpMessage({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, ContextInfo contextInfo) {
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
    return SizedBox(
      width: contextInfo.widgetSize!.width > 540
          ? contextInfo.widgetSize!.width * .6
          : contextInfo.widgetSize!.width * .7,
      child: fluent_ui.FluentTheme(
        data: fluent_ui.ThemeData(),
        child: fluent_ui.Card(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          backgroundColor: color ?? AppColorScheme.of(context).errorColor,
          child: Text(
            errorText,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge?.copyWith(
              color: AppColorScheme.of(context).onError,
              fontWeight: FontWeight.bold,
            ),
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          tileColor: color ?? AppColorScheme.of(context).errorColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          leading: errorIcon,
          title: Text(
            errorText,
            textAlign: TextAlign.center,
            style: context.textTheme.subtitle1?.copyWith(
              color: AppColorScheme.of(context).onError,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
