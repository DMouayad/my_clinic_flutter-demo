import 'package:clinic_v2/presentation/shared_widgets/custom_buttons/filled_buttons.dart';
import 'package:clinic_v2/presentation/shared_widgets/material_with_utils.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;

import '../custom_buttons/custom_icon_button.dart';

//
enum DialogType { alert, error, options, general, progress }

class AdaptiveDialog extends StatelessWidget {
  const AdaptiveDialog({
    required this.type,
    this.title,
    this.titleText,
    this.contentText,
    this.actions,
    this.withOkOptionButton = false,
    this.content,
    this.constraints,
    this.titleTextColor,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
    Key? key,
  }) : super(key: key);

  final String? titleText;
  final Widget? title;
  final String? contentText;
  final Widget? content;
  final List<Widget>? actions;
  final bool withOkOptionButton;
  final Color? titleTextColor;
  final BoxConstraints? constraints;
  final DialogType type;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    return BuilderWithWidgetInfo(builder: (context, widgetInfo) {
      final dialogConstraints = constraints ??
          BoxConstraints.loose(
            Size(350, context.screenHeight * .5),
          );
      if (context.isWindowsPlatform) {
        if (type == DialogType.general) {
          return _windowsGeneralDialog(context);
        } else {
          return fluent_ui.ContentDialog(
            constraints: dialogConstraints,
            style: fluent_ui.ContentDialogThemeData(
              bodyPadding: contentPadding,
            ),
            title: _getTitle(context),
            content: _getContent(context),
            actions: _getActions(context),
          );
        }
      } else {
        if (type == DialogType.alert || type == DialogType.error) {
          return AlertDialog(
            backgroundColor: context.colorScheme.backgroundColor,
            title: _getTitle(context),
            content: _getContent(context),
            actions: _getActions(context),
            contentPadding: contentPadding,
          );
        } else {
          return Dialog(
            backgroundColor: context.colorScheme.backgroundColor,
            child: SizedBox(
              width: context.screenWidth * .7,
              child: ListView(
                shrinkWrap: true,
                padding: contentPadding,
                children: [
                  if (_getTitle(context) != null) _getTitle(context)!,
                  const SizedBox(height: 20),
                  if (_getContent(context) != null) _getContent(context)!,
                  if (_getActions(context) != null) ..._getActions(context)!,
                ],
              ),
            ),
          );
        }
      }
    });
  }

  Widget _windowsGeneralDialog(BuildContext context) {
    return BuilderWithWidgetInfo(builder: (context, widgetInfo) {
      return fluent_ui.ContentDialog(
        content: content,
        constraints: BoxConstraints.tight(
          Size(
            widgetInfo.widgetSize.width *
                (context.isTablet
                    ? .7
                    : context.isMobile
                        ? .8
                        : .5),
            widgetInfo.widgetSize.height * .7,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (titleText != null)
              Text(
                titleText!,
                style: context.fluentTextTheme.subtitle?.copyWith(
                  color:
                      titleTextColor ?? context.colorScheme.onPrimaryContainer,
                ),
              ),
            CustomIconButton(
              tooltipMessage: context.localizations!.close,
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.close,
                size: 22,
                color: context.colorScheme.errorColor,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget? _getTitle(BuildContext context) {
    return title ??
        (titleText != null
            ? Text(
                titleText!,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineMedium?.copyWith(
                  color:
                      titleTextColor ?? context.colorScheme.onPrimaryContainer,
                ),
              )
            : null);
  }

  Widget? _getContent(BuildContext context) {
    return content ??
        ((contentText != null)
            ? Text(
                contentText!,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onBackground,
                ),
              )
            : null);
  }

  List<Widget>? _getActions(BuildContext context) {
    List<Widget>? actionsButtons;
    if (withOkOptionButton) {
      actionsButtons = [];
      actionsButtons.add(
        AdaptiveFilledButton(
          label: context.localizations!.ok,
          onPressed: () => Navigator.of(context).pop(),
        ),
      );
    }

    if (actions != null) {
      actionsButtons ??= [];
      actionsButtons.addAll(actions!);
    }
    return actionsButtons;
  }
}
