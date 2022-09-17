import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
//
import '../custom_widget/custom_widget.dart';
import 'utils.dart';

class WindowsDropdownMenu extends BaseDropdownMenu {
  const WindowsDropdownMenu({
    required String title,
    required List<CustomDropdownMenuItem> items,
    required void Function(CustomDropdownMenuItem item) onChanged,
    String? tooltipMessage,
    Key? key,
  }) : super(
          key: key,
          title: title,
          items: items,
          onChanged: onChanged,
          tooltipMessage: tooltipMessage,
          leadingIconData: null,
          leading: null,
        );

  @override
  Widget build(BuildContext context) {
    return fluent_ui.FluentTheme(
      data: fluent_ui.FluentTheme.of(context).copyWith(
        buttonTheme: fluent_ui.ButtonThemeData(
          defaultButtonStyle: fluent_ui.ButtonStyle(
            border: fluent_ui.ButtonState.all(
              fluent_ui.BorderSide.none,
            ),
            elevation: fluent_ui.ButtonState.all(0),
            backgroundColor: fluent_ui.ButtonState.all(Colors.transparent),
            foregroundColor:
                fluent_ui.ButtonState.all(context.colorScheme.onBackground),
          ),
        ),
      ),
      child: fluent_ui.Tooltip(
        message: tooltipMessage,
        child: fluent_ui.DropDownButton(
          menuColor: context.colorScheme.backgroundColor,
          title: Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onBackground,
            ),
          ),
          items: items
              .map((item) => fluent_ui.MenuFlyoutItem(
                    onPressed: () => onChanged(item),
                    leading: const fluent_ui.Icon(
                      fluent_ui.FluentIcons.locale_language,
                    ),
                    text: Text(
                      item.text,
                      style: context.textTheme.labelLarge,
                    ),
                    trailing: fluent_ui.Checkbox(
                      checked: item.selected,
                      // onChanged:
                      onChanged: (checked) {
                        if (checked != item.selected) {
                          onChanged(item);
                        }
                        // close dropdown menu
                        Navigator.of(context).pop();
                      },
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
