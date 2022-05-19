import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinic_v2/app/base/responsive/responsive.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

class ErrorCard extends Component {
  const ErrorCard({
    required this.errorText,
    this.errorIcon,
    this.color,
    this.actionButton,
    Key? key,
  }) : super(key: key);
  final String errorText;
  final Color? color;
  final Widget? errorIcon;
  final Widget? actionButton;

  // @override
  // Widget windowsDesktopBuilder(BuildContext context, ContextInfo contextInfo) {
  //   return SizedBox(
  //     width: contextInfo.widgetSize!.width > 600
  //         ? contextInfo.widgetSize!.width * .6
  //         : contextInfo.widgetSize!.width < 400
  //             ? contextInfo.widgetSize!.width * .9
  //             : contextInfo.widgetSize!.width * .8,

  //     child:
  //     Flex(direction: Axis.horizontal,)
  //     //  ListTile(
  //     //   visualDensity: VisualDensity.adaptivePlatformDensity,
  //     //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  //     //   tileColor:
  //     //       color ?? AppColorScheme.of(context).errorColor!.withOpacity(.9),
  //     //   title: actionButton != null
  //     //       ? _title(context)
  //     //       : Center(
  //     //           child: _title(context),
  //     //         ),
  //     //   trailing: Container(color: Colors.black12, child: actionButton),
  //     // ),
  //   );
  // }

  Widget _title(BuildContext context) {
    return AutoSizeText(
      errorText,
      textAlign: TextAlign.center,
      minFontSize: 10,
      style: context.textTheme.bodyLarge?.copyWith(
        color: AppColorScheme.of(context).onError,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Widget builder(BuildContext context, contextInfo) {
    return SizedBox(
      width: contextInfo.widgetSize!.width > 600
          ? contextInfo.widgetSize!.width * .6
          : contextInfo.widgetSize!.width < 400
              ? contextInfo.widgetSize!.width * .9
              : contextInfo.widgetSize!.width * .8,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),

        decoration: BoxDecoration(
          color: color ?? AppColorScheme.of(context).errorColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 2, child: _title(context)),
            Expanded(
                child: Container(color: Colors.black12, child: actionButton)),
          ],
        ),

        //  ListTile(
        //   contentPadding:
        //       const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        //   tileColor: color ?? AppColorScheme.of(context).errorColor,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   leading: errorIcon,
        //   title: Text(
        //     errorText,
        //     textAlign: TextAlign.center,
        //     style: context.textTheme.subtitle1?.copyWith(
        //       color: AppColorScheme.of(context).onError,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   trailing: Container(color: Colors.black12, child: actionButton),
        // ),
      ),
    );
  }
}
