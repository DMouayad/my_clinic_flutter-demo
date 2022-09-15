import 'package:auto_size_text/auto_size_text.dart';
import 'package:clinic_v2/app/shared_widgets/custom_buttons/custom_elevated_button.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

import 'custom_widget/custom_widget.dart';

class SubmitButton extends CustomStatelessWidget {
  final void Function() onPressed;
  final String text;
  final IconData iconData;
  final bool expandInWidth;
  final double? height;

  const SubmitButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.iconData,
    this.expandInWidth = false,
    this.height,
  }) : super(key: key);

  @override
  Widget defaultBuilder(BuildContext context, contextInfo) {
    return SizedBox(
      width: expandInWidth
          ? contextInfo.widgetSize!.width
          : contextInfo.widgetSize!.width * .8,
      height: height ?? 44,
      child: contextInfo.isDesktopPlatform
          ? fluent_ui.FluentTheme(
              data: fluent_ui.ThemeData(),
              child: fluent_ui.OutlinedButton(
                onPressed: onPressed,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: AutoSizeText(text)),
                    const SizedBox(width: 8),
                    Icon(
                      iconData,
                      size: 22,
                    ),
                  ],
                ),
                style: fluent_ui.ButtonStyle(
                  // padding:
                  // ButtonState.all(const EdgeInsets.fromLTRB(16, 2, 24, 2)),
                  // border: fluent_ui.ButtonState.all(BorderSide.none),
                  // border: ButtonState.resolveWith(
                  //     (states) => _getDesktopButtonBorder(states, context)),
                  textStyle: fluent_ui.ButtonState.all(
                      context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  )),

                  foregroundColor: fluent_ui.ButtonState.all(context.isDarkMode
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.onBackground),

                  backgroundColor: fluent_ui.ButtonState.resolveWith((states) {
                    if (states.isHovering) {
                      return context.fluentTheme.accentColor.lighter;

                      // return context.fluentTheme.accentColor.normal;
                      // return context.fluentTheme.accentColor.dark
                      //     .withOpacity(.6);
                    } else if (states.isPressing) {
                      return context.fluentTheme.accentColor.normal;
                    } else {
                      return context.fluentTheme.accentColor.normal;
                    }
                  }),
                ),
              ),
            )
          : CustomElevatedButton(
              label: text,
              onPressed: onPressed,
              iconData: iconData,
            ),
    );
  }
}
