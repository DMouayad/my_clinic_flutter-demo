import 'package:clinic_v2/app/base/responsive/responsive.dart'
    show BuildContext, Component, ContextThemeExtensions;
import 'package:clinic_v2/app/common/widgets/custom_buttons/custom_elevated_button.dart';
import 'package:fluent_ui/fluent_ui.dart';

class SubmitButton extends Component {
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
  Widget builder(BuildContext context, contextInfo) {
    return SizedBox(
      width: expandInWidth
          ? contextInfo.widgetSize!.width
          : contextInfo.widgetSize!.width * .8,
      height: height ?? 45,
      child: contextInfo.isDesktop
          ? FluentTheme(
              data: ThemeData(),
              child: OutlinedButton(
                onPressed: onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(text),
                    const SizedBox(width: 8),
                    Icon(
                      iconData,
                      size: 22,
                    ),
                  ],
                ),
                style: ButtonStyle(
                  padding:
                      ButtonState.all(const EdgeInsets.fromLTRB(16, 2, 24, 2)),
                  border: ButtonState.all(BorderSide.none),
                  // border: ButtonState.resolveWith(
                  //     (states) => _getDesktopButtonBorder(states, context)),
                  textStyle:
                      ButtonState.all(context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  )),

                  foregroundColor:
                      ButtonState.all(context.colorScheme.onPrimary),
                  // shape: ButtonState.all(
                  //   RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  // ),
                  backgroundColor: ButtonState.resolveWith((states) {
                    if (states.isHovering) {
                      return context.colorScheme.primary;
                    } else if (states.isPressing) {
                      return context.colorScheme.onBackground?.withOpacity(.5);
                    } else {
                      return context.colorScheme.secondary;
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

  BorderSide _getDesktopButtonBorder(
      Set<ButtonStates> states, BuildContext context) {
    if (states.contains(ButtonStates.hovering)) {
      return BorderSide(color: context.colorScheme.onBackground!);
    }
    return BorderSide.none;
  }
}
