import 'package:clinic_v2/app/base/responsive/responsive.dart';

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
    return
        // SizedBox(
        //   width: contextInfo.widgetSize!.width * .4,
        //   child: Padding(
        //     padding:
        //         padding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       mainAxisSize: MainAxisSize.min,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Stack(
        //           alignment: Alignment.center,
        //           children: [
        //             Container(height: 3, color: Colors.white),
        //             Row(
        //               // mainAxisSize: MainAxisSize.min,
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 CircleAvatar(
        //                   backgroundColor: Colors.red,
        //                   radius: 10,
        //                 ),
        //                 CircleAvatar(
        //                   backgroundColor: Colors.red,
        //                   radius: 10,
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //         Row(
        //           children: [],
        //         ),
        // ChoiceChip(
        //   selected: false,
        //   backgroundColor: AppColorScheme.of(context).primaryContainer,
        //   label: Text(
        //     AppLocalizations.of(context)!.stepOne,
        //     style: context.textTheme.bodyText1?.copyWith(
        //       fontWeight: FontWeight.bold,
        //       color: AppColorScheme.of(context).onPrimaryContainer,
        //     ),
        //   ),
        // ),
        // Divider(),
        // // VerticalDivider(width: 0,),
        Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              16, contextInfo.isDesktopPlatform ? 12 : 16, 16, 0),
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
        ),
      ],
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
