import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
//
import 'package:clinic_v2/app/shared_widgets/custom_buttons/custom_elevated_button.dart';
import 'material_with_utils.dart';

class SubmitButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BuilderWithWidgetInfo(builder: (context, widgetInfo) {
      return SizedBox(
        width: expandInWidth
            ? widgetInfo.widgetSize.width
            : widgetInfo.widgetSize.width * .8,
        height: height ?? 44,
        child: context.isDesktopPlatform
            ? fluent_ui.FluentTheme(
                data: fluent_ui.ThemeData(),
                child: fluent_ui.OutlinedButton(
                  onPressed: onPressed,
                  style: fluent_ui.ButtonStyle(
                    border: fluent_ui.ButtonState.all(BorderSide.none),
                    textStyle: fluent_ui.ButtonState.all(
                        context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    )),
                    foregroundColor: fluent_ui.ButtonState.all(
                      context.isDarkMode
                          ? context.colorScheme.onPrimary
                          : context.colorScheme.onBackground,
                    ),
                    backgroundColor:
                        fluent_ui.ButtonState.resolveWith((states) {
                      if (states.isHovering) {
                        return context.fluentTheme.accentColor.lighter;
                      } else if (states.isPressing) {
                        return context.fluentTheme.accentColor.normal;
                      } else {
                        return context.fluentTheme.accentColor.normal;
                      }
                    }),
                  ),
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
                ),
              )
            : CustomElevatedButton(
                label: text,
                onPressed: onPressed,
                iconData: iconData,
              ),
      );
    });
  }
}
